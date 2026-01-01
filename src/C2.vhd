----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2025 10:48:07 AM
-- Design Name: 
-- Module Name: C2 - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity C2 is
  generic (
    WIDTH : integer := 8
  );
  port (
    X : in  std_logic_vector(WIDTH-1 downto 0);
    Y : out std_logic_vector(WIDTH-1 downto 0) );
end C2;

architecture Behavioral of C2 is

signal temp : std_logic_vector(WIDTH-1 downto 0);
signal ONE  : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
begin

 ONE(0) <= '1';  

  temp <= not X;
  Y <= std_logic_vector(unsigned(temp) + unsigned(ONE));


end Behavioral;
