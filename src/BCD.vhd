----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/16/2025 09:20:08 PM
-- Design Name: 
-- Module Name: BCD - Behavioral
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

entity BCD is
  Port (value16 : in  std_logic_vector(15 downto 0);
        digit0  : out std_logic_vector(3 downto 0); -- units
        digit1  : out std_logic_vector(3 downto 0); -- tens
        digit2  : out std_logic_vector(3 downto 0); -- hundreds
        digit3  : out std_logic_vector(3 downto 0); -- thousands
        digit4  : out std_logic_vector(3 downto 0)  -- ten-thousands
);
end BCD;

architecture Behavioral of BCD is

    signal num : integer range 0 to 65535;
begin

    process(value16)
        variable n : integer;
    begin
        n := to_integer(unsigned(value16));

        digit0 <= std_logic_vector(to_unsigned(n mod 10, 4));
        n := n / 10;

        digit1 <= std_logic_vector(to_unsigned(n mod 10, 4));
        n := n / 10;

        digit2 <= std_logic_vector(to_unsigned(n mod 10, 4));
        n := n / 10;

        digit3 <= std_logic_vector(to_unsigned(n mod 10, 4));
        n := n / 10;

        digit4 <= std_logic_vector(to_unsigned(n mod 10, 4));
    end process;
end Behavioral;
