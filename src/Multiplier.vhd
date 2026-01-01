----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/16/2025 02:59:24 PM
-- Design Name: 
-- Module Name: Multiplier - Behavioral
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

entity Multiplier is
generic (
    WIDTH : integer := 8
  );
  port (
    X    : in  std_logic_vector(WIDTH-1 downto 0);
    Y    : in  std_logic_vector(WIDTH-1 downto 0);
    P    : out std_logic_vector((2*WIDTH)-1 downto 0)
  );
  end Multiplier;

architecture Behavioral of Multiplier is

  signal Acc : unsigned((2*WIDTH)-1 downto 0); 
begin

  process(X, Y)
    variable temp : unsigned((2*WIDTH)-1 downto 0);
  begin
    temp := (others => '0');

    -- SHIFT-ADD multiplication
    for i in 0 to WIDTH-1 loop
      if Y(i) = '1' then
        temp := temp + ( unsigned(X) sll i );
      end if;
    end loop;

    Acc <= temp;
  end process;

  P <= std_logic_vector(Acc);

end Behavioral;
