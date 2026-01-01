----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2025 08:54:24 PM
-- Design Name: 
-- Module Name: Rotation_Unit - Behavioral
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
use IEEE.NUMERIC_STD.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rotation_Unit is
generic (WIDTH : integer := 8);
  port (
    A       : in  std_logic_vector(WIDTH-1 downto 0);
    ShiftVal : in  integer range 0 to WIDTH-1;
    RotSel  : in  std_logic; -- '0' = Rotate Left, '1' = Rotate Right
    Result  : out std_logic_vector(WIDTH-1 downto 0)
    );
end Rotation_Unit;

architecture Behavioral of Rotation_Unit is

begin
process (A, RotSel)
  begin
     if RotSel = '0' then
      Result <= std_logic_vector(unsigned(A) rol ShiftVal);  
    else
      Result <= std_logic_vector(unsigned(A) ror ShiftVal); 
    end if;
  end process;


end Behavioral;
