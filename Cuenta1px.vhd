----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2024 16:25:12
-- Design Name: 
-- Module Name: Cuenta1px - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Cuenta1pxl is

    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           new_pxl : out std_logic;
           
          hsinc : out std_logic;
          vsinc : out std_logic;
           
          visible : out std_logic;
           
           fila : out unsigned(9 downto 0);
           col : out unsigned(9 downto 0));
          

end Cuenta1pxl;

architecture Behavioral of Cuenta1pxl is
signal cont_clk:unsigned(2 downto 0);
signal cuatro_clk:std_logic;

signal cont_pxl:unsigned(9 downto 0);
signal cont_linea:unsigned(9 downto 0);

signal fin_lineas:std_logic;
signal new_linea:std_logic;
signal new_lineaa:std_logic;

--signal vsinc_sig:std_logic;
signal vsinc1_sig:std_logic;
signal vsinc2_sig:std_logic;

--signal hsinc_sig:std_logic;
signal hsinc1_sig:std_logic;
signal hsinc2_sig:std_logic;

signal visible_sig:std_logic;
signal visiblefila_sig:std_logic;
signal visiblecol_sig:std_logic;

signal hsinc_sig:std_logic;
signal vsinc_sig:std_logic;




begin

P_Cont_clk: Process (rst,clk)
begin
        if rst = '1' then
             cont_clk <= (others => '0'); 
        elsif clk'event and clk = '1' then
            if cuatro_clk = '1' then
                cont_clk <= (others => '0');
            else
                cont_clk <= cont_clk + 1;
            end if;
        end if;
    end process;
cuatro_clk <= '1' when cont_clk=3 else '0'; 
new_pxl<=cuatro_clk;

P_Cont_unalinea: Process (rst,clk)
begin
    if rst = '1' then
             cont_pxl <= (others => '0'); 
        elsif clk'event and clk = '1' then
        if cuatro_clk='1' then
            if new_linea = '1' then
                cont_pxl <= (others => '0');
            else
                cont_pxl <= cont_pxl + 1;
            end if;
        end if;
        end if;
    end process;
new_linea<= '1' when cont_pxl >= 799 else '0';
new_lineaa<=new_linea and cuatro_clk;
col<= cont_pxl;
--new_linea<=cont_linea;
--al hacer ambos  procesos en el mismo bloque, ¿la cuenta de 1 clk se mantiene activo todo el ciclo de reloj y entonces el resto de las cuentas ya van con 10ns de retraso ya que no empiezan a contar hasta que se ponga a 0 esta señal?
P_Cont_linea: Process (rst,clk)
begin
    if rst = '1' then
             cont_linea <= (others => '0'); 
        elsif clk'event and clk = '1' then
            if new_lineaa='1' then
                if fin_lineas = '1' then
                cont_linea <= (others => '0');
            else
                cont_linea <= cont_linea + 1;
            end if;
        end if;
        end if;
    end process;
    fin_lineas<= '1' when cont_linea >= 519 else '0';
    fila<=cont_linea;

visiblecol_sig<='1' when cont_pxl <640 else '0';
visiblefila_sig<='1'when cont_linea<480 else '0';
visible<=visiblecol_sig and visiblefila_sig;

hsinc1_sig<='1' when cont_pxl <656 else'0';
hsinc2_sig<='1' when cont_pxl >751 else'0';
hsinc_sig<= hsinc1_sig or hsinc2_sig;

vsinc1_sig<='1' when cont_linea <489 else'0';
vsinc2_sig<='1' when cont_linea >490 else'0';
vsinc_sig<= vsinc1_sig or vsinc2_sig;

process(clk)
    begin  
       if clk'event and clk='1' then
          vsinc<= vsinc_sig;
          hsinc<= hsinc_sig;
       end if;
    end process;

--

--hvisible = '0' when 655< cont_pxl <700;
end Behavioral;
