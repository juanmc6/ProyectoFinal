----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2024 13:51:16
-- Design Name: 
-- Module Name: tb_MOVPACMAN - Behavioral
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

entity tb_MOVPACMAN is
--  Port ( );
end tb_MOVPACMAN;

architecture Behavioral of tb_MOVPACMAN is

component mov_pacman is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           btnU : in STD_LOGIC;
           btnD : in STD_LOGIC;
           btnL : in STD_LOGIC;
           btnR : in STD_LOGIC;
           pacman_fila : out unsigned (4 downto 0);
           pacman_columna : out unsigned (4 downto 0));
end component;

signal clk_sim : STD_LOGIC;
signal rst_sim : STD_LOGIC;
signal btnU_sim : STD_LOGIC;
signal btnD_sim : STD_LOGIC;
signal btnL_sim : STD_LOGIC;
signal btnR_sim : STD_LOGIC;
signal pacman_fila_sim : unsigned (4 downto 0);
signal pacman_columna_sim : unsigned (4 downto 0);

begin

rst_sim<='1', '0' after 10 ns;
btnU_sim<='1','0'after 15 ns,'1' after 25 ns,'0' after 35 ns,'1' after 40 ns;



UUT:mov_pacman port map(clk=>clk_sim,rst=>rst_sim,btnU=>btnU_sim,btnD=>btnD_sim,btnL=>btnL_sim,btnR=>btnR_sim,pacman_fila=>pacman_fila_sim,pacman_columna=>pacman_columna_sim);

    CLOCK: process 
    begin
        clk_sim<='1';
        wait for 5ns;
        clk_sim<='0';
        wait for 5ns;
    end process;



end Behavioral;
