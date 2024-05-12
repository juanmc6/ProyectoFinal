----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2024 13:22:00
-- Design Name: 
-- Module Name: TOP_videojuego_TB - Behavioral
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

entity TOP_videojuego_TB is

end TOP_videojuego_TB;

architecture Behavioral of TOP_videojuego_TB is

component TOP_videojuego is
Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           
           btnU: in std_logic;
           btnD: in std_logic;
           btnL: in std_logic;
           btnR: in std_logic;
           
          hsinc : out std_logic;
          vsinc : out std_logic;
           
          rgb: out unsigned(11 downto 0));
end component;



signal clk_sim:std_logic;
signal rst_sim:std_logic;
signal btnU_sim:std_logic;
signal btnD_sim:std_logic;
signal btnL_sim:std_logic;
signal  btnR_sim:std_logic;
signal hsinc_sim:std_logic;
signal vsinc_sim:std_logic;
signal rgb_sim:unsigned(11 downto 0);

begin
rst_sim<='1', '0' after 10 ns;
btnU_sim<='1','0'after 15 ns,'1' after 25 ns,'0' after 35 ns,'1' after 40 ns;


UUT: TOP_videojuego port map(clk=>clk_sim,rst=>rst_sim,btnU=>btnU_sim,btnD=>btnD_sim,btnL=>btnL_sim,btnR=>btnR_sim,hsinc=>hsinc_sim,vsinc=>vsinc_sim,rgb=>rgb_sim);

    CLOCK: process 
    begin
        clk_sim<='1';
        wait for 5ns;
        clk_sim<='0';
        wait for 5ns;
    end process;



end Behavioral;
