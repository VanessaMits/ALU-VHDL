----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/16/2025 10:22:55 PM
-- Design Name: 
-- Module Name: ALU_Display - Behavioral
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

entity ALU_Display is
  Port ( clk   : in  std_logic;
        A_in  : in  std_logic_vector(7 downto 0);
        B_in  : in  std_logic_vector(7 downto 0);
        Op_in : in  std_logic_vector(3 downto 0);

        catod : out std_logic_vector(6 downto 0);
        anod  : out std_logic_vector(3 downto 0) );
end ALU_Display;

architecture Behavioral of ALU_Display is

    signal alu_result  : std_logic_vector(15 downto 0);
    signal alu_cout    : std_logic;

    
    signal d0, d1, d2, d3, d4 : std_logic_vector(3 downto 0);

begin

 ALU_U : entity work.ALU
    generic map(WIDTH => 8)
    port map(
        A        => A_in,
        B        => B_in,
        Op       => Op_in,
        LogicSel => "00",    
        RotSel   => '0',    
        Result   => alu_result,
        Cout     => alu_cout
    );
        
BCD_U : entity work.BCD
        port map(
            value16 => alu_result,
            digit0  => d0,
            digit1  => d1,
            digit2  => d2,
            digit3  => d3,
            digit4  => d4
        );

 SSD_U : entity work.SSD
        port map(
            digit0 => d0,
            digit1 => d1,
            digit2 => d2,
            digit3 => d3,
  
            clk    => clk,
            catod  => catod,
            anod   => anod
        );


end Behavioral;
