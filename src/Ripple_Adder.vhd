----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2025 11:21:06 PM
-- Design Name: 
-- Module Name: Ripple_Adder - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ripple_Adder is

generic (
    WIDTH : integer := 8  -- default bit width = 4
  );
  
    port(
    A    : in  std_logic_vector(WIDTH-1 downto 0);
    B    : in  std_logic_vector(WIDTH-1 downto 0);
    Cin  : in  std_logic;
    Sum  : out std_logic_vector(WIDTH-1 downto 0);
    Cout : out std_logic
  );
end Ripple_Adder;

architecture Behavioral of Ripple_Adder is

signal C: std_logic_vector(WIDTH downto 1);

component FA is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           sum : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;

begin
  FA0: FA port map(a => A(0), b => B(0), cin => Cin,  sum => Sum(0), cout => C(1));
  FA1: FA port map(a => A(1), b => B(1), cin => C(1), sum => Sum(1), cout => C(2));
  FA2: FA port map(a => A(2), b => B(2), cin => C(2), sum => Sum(2), cout => C(3));
  FA3: FA port map(a => A(3), b => B(3), cin => C(3), sum => Sum(3), cout => C(4));
  FA4: FA port map(a => A(4), b => B(4), cin => C(4), sum => Sum(4), cout => C(5));
  FA5: FA port map(a => A(5), b => B(5), cin => C(5), sum => Sum(5), cout => C(6));
  FA6: FA port map(a => A(6), b => B(6), cin => C(6), sum => Sum(6), cout => C(7));
  FA7: FA port map(a => A(7), b => B(7), cin => C(7), sum => Sum(7), cout => Cout);

end Behavioral;
