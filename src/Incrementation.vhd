----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2025 03:17:38 PM
-- Design Name: 
-- Module Name: Incrementer - Behavioral
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

entity Incrementer is
generic (
    WIDTH : integer := 8
  );
  port (
    A    : in  std_logic_vector(WIDTH-1 downto 0);
    Y    : out std_logic_vector(WIDTH-1 downto 0);
    Cout : out std_logic
  );
end Incrementer;

architecture Behavioral of Incrementer is

  component Ripple_Adder
    generic (
      WIDTH : integer := 8
    );
    port (
      A, B  : in  std_logic_vector(WIDTH-1 downto 0);
      Cin   : in  std_logic;
      Sum   : out std_logic_vector(WIDTH-1 downto 0);
      Cout  : out std_logic
    );
  end component;
  
   signal One : std_logic_vector(WIDTH-1 downto 0) := (others => '0');



begin

 One(0) <= '1';
 
 ADDER: Ripple_Adder
    port map (
      A    => A,
      B    => One,
      Cin  => '0',
      Sum  => Y,
      Cout => Cout
    );


end Behavioral;
