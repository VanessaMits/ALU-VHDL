----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2025 08:47:08 PM
-- Design Name: 
-- Module Name: Logic_Utit - Behavioral
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

entity Logic_Utit is
generic (WIDTH : integer := 8);
  port (
    A, B      : in  std_logic_vector(WIDTH-1 downto 0);
    LogicSel  : in  std_logic_vector(1 downto 0); -- selects AND, OR, XOR, NOT
    Result    : out std_logic_vector(WIDTH-1 downto 0)
  );
end Logic_Utit;

architecture Behavioral of Logic_Utit is

begin
process (A, B, LogicSel)

begin

case LogicSel is
      when "00" => Result <= A and B;   
      when "01" => Result <= A or B;    
      when "10" => Result <= not A ;   
      
      when others => Result <= (others => '0');
    end case;
  end process;


end Behavioral;
