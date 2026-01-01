----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/16/2025 04:06:02 PM
-- Design Name: 
-- Module Name: Divider - Behavioral
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
--use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Divider is
 generic (WIDTH : integer := 8);
  port (
    A : in  std_logic_vector(WIDTH-1 downto 0);
    B : in  std_logic_vector(WIDTH-1 downto 0);
    Q : out std_logic_vector(WIDTH-1 downto 0);
    R : out std_logic_vector(WIDTH-1 downto 0)
  );end Divider;

architecture Behavioral of Divider is

  signal A_u, B_u : unsigned(WIDTH-1 downto 0);
  
begin

  A_u <= unsigned(A);
  B_u <= unsigned(B);

  process(A_u, B_u)
    variable Rv : unsigned(WIDTH-1 downto 0);
    variable Qv : unsigned(WIDTH-1 downto 0);
    variable Bv : unsigned(WIDTH-1 downto 0);
  begin
    
    Rv := (others => '0');
    Qv := (others => '0');
    Bv := B_u;

    if B_u = 0 then
      Q <= (others => '0');
      R <= (others => '0');
    else
       for i in WIDTH-1 downto 0 loop
        Rv := shift_left(Rv, 1);

        
        Rv(0) := A_u(i);      
      if Rv >= Bv then
          Rv := Rv - Bv;
          Qv(i) := '1';       
        else
          Qv(i) := '0';
        end if;

      end loop;

      Q <= std_logic_vector(Qv);
      R <= std_logic_vector(Rv);
    end if;

  end process;


end Behavioral;
