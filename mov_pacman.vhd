----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2024 15:16:25
-- Design Name: 
-- Module Name: mov_pacman - Behavioral
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

entity mov_pacman is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           btnU : in STD_LOGIC;
           btnD : in STD_LOGIC;
           btnL : in STD_LOGIC;
           btnR : in STD_LOGIC;
           pacman_fila : out unsigned (4 downto 0);
           pacman_columna : out unsigned (4 downto 0));
end mov_pacman;

architecture Behavioral of mov_pacman is

signal pacmanF: unsigned (4 downto 0);
signal pacmanC: unsigned (4 downto 0);
signal cont_ns: unsigned (23 downto 0);
signal cont1ms: std_logic;

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
 
  P_pacman: Process (clk, rst)
  begin
        if rst='1' then
             pacmanF <= (others => '0'); 
             pacmanC <= (others => '0'); 
        elsif clk'event and clk = '1' then
         if cont1ms='1' then
            if btnU='1' and pacmanF<29 then--up
                pacmanF <= pacmanF +1;
                pacmanC <= pacmanC;
            elsif btnD='1' and pacmanF>0 then--down
                pacmanF <= pacmanF-1;
                pacmanC <= pacmanC;            
            elsif btnL='1' and pacmanC>0 then--left
                pacmanF <= pacmanF;
                pacmanC <= pacmanC -1;            
            elsif btnR='1' and pacmanC<31 then--right
                pacmanF <= pacmanF;
                pacmanC <= pacmanC +1;
            else
                pacmanF <= pacmanF;
                pacmanC <= pacmanC; 
            end if;
          else
               pacmanF <= pacmanF;
               pacmanC <= pacmanC;                     
   
            end if;
        end if;
 end process;
 
 pacman_fila<=pacmanF;
 pacman_columna<=pacmanC;


end Behavioral;
