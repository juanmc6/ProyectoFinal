----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.05.2024 11:36:31
-- Design Name: 
-- Module Name: mov_fantasma - Behavioral
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

entity mov_fantasma is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           fantasma_fila : out unsigned (4 downto 0);
           fantasma_columna : out unsigned (4 downto 0));
end mov_fantasma;

architecture Behavioral of mov_fantasma is

signal cont_ns: unsigned (23 downto 0);
signal cont1ms: std_logic;

 signal cont_filas: unsigned(4 downto 0);
 signal cont_columnas: unsigned(4 downto 0);

 type e_movimiento is (e_upleft, e_upright, e_downright, e_downleft);
 signal estado_actual, estado_siguiente : e_movimiento;


begin

  P_p1ms: Process (clk, rst)
  begin
        if rst = '1' then
             cont_ns <= (others => '0'); 
        elsif clk'event and clk = '1' then
            if cont1ms='1' then
                cont_ns<= (others => '0'); 
            else
                cont_ns<= cont_ns +1;
            end if;
        end if;
  end process;
 cont1ms <= '1' when cont_ns=10000000 else '0'; 

P_conta_filascolumnas: Process (clk,rst)--proceso con las sentencias que harán en cada estado
begin
    if rst='1' then
        cont_filas<=(others =>'0');
        cont_columnas<=(others =>'0');
    elsif clk'event and clk='1' then
        if cont1ms='1' then
            case estado_actual is 
                when e_upleft =>
                    cont_columnas<=cont_columnas -1;
                    cont_filas<=cont_filas -1; 
             
                when e_upright =>
                    cont_columnas<=cont_columnas +1;
                    cont_filas<=cont_filas -1; 
              
                when e_downright =>
                    cont_columnas<=cont_columnas +1;
                    cont_filas<=cont_filas +1; 
              
                when e_downleft =>
                    cont_columnas<=cont_columnas -1;
                    cont_filas<=cont_filas +1;         
    
            end case;
       end if;
 end if;
end process;

 P_es1: Process (rst, clk)--maquina de estados que obliga a que el estado actual pase a ser el estado siguiente si no se pulsa el rst
    begin
        if rst = '1' then
            estado_actual <= e_downright;
        elsif clk'event and clk='1' then
            estado_actual <= estado_siguiente;
        end if;
 end process;


 P_est2: Process(estado_actual,cont_columnas,cont_filas) --maquina de estados que segun la posicion determinará cual será el estado siguiente
 begin
    estado_siguiente <= estado_actual;
    case estado_actual is
        when e_upleft =>
            if cont_columnas=1 then       
                estado_siguiente <= e_upright;
            elsif cont_filas=1 then
                estado_siguiente <= e_downleft;
            end if; 
        when e_upright =>
            if cont_columnas=31 then
                estado_siguiente <= e_upleft;
            elsif cont_filas=1 then
                estado_siguiente <= e_downright;
            end if; 
        when e_downright =>
            if cont_columnas=31 then
                estado_siguiente <= e_downleft;
            elsif cont_filas=29 then
                estado_siguiente <= e_upright;    
            end if; 
        when e_downleft =>
            if cont_columnas=1 then
                estado_siguiente <= e_downright;
            elsif cont_filas=29 then
                estado_siguiente <= e_upleft; 
            end if; 
    end case;

 end process;  
   
fantasma_columna<=cont_columnas;
fantasma_fila<=cont_filas;   

end Behavioral;
