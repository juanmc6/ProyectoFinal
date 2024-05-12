----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2024 16:41:59
-- Design Name: 
-- Module Name: Cuenta1pxl_TB - Behavioral
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

entity Cuenta1pxl_TB is
--  Port ( );
end Cuenta1pxl_TB;

architecture Behavioral of Cuenta1pxl_TB is

signal clk_sim:std_logic;
signal rst_sim:std_logic;
signal new_pxl_sim: std_logic;

signal hsinc_sim: std_logic;
signal vsinc_sim: std_logic;

signal visible_sim: std_logic;

signal fila_sim: unsigned(9 downto 0);
signal col_sim: unsigned(9 downto 0);

component Cuenta1pxl is

    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           new_pxl : out std_logic;
           
          hsinc : out std_logic;
           vsinc : out std_logic;
           
           visible : out std_logic;
           
           fila : out unsigned(9 downto 0);
           col : out unsigned(9 downto 0));
          

end component;


begin
rst_sim<='1', '0' after 10 ns;

UUT:Cuenta1pxl port map(clk=>clk_sim,rst=>rst_sim,new_pxl=>new_pxl_sim,col=>col_sim,fila=>fila_sim,visible=>visible_sim,hsinc=>hsinc_sim,vsinc=>vsinc_sim);

    CLOCK: process 
    begin
        clk_sim<='1';
        wait for 5ns;
        clk_sim<='0';
        wait for 5ns;
    end process;


end Behavioral;
