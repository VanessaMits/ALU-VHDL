----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/11/2025 02:29:15 AM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is

  constant WIDTH : integer := 8;

    -- Semnale de test
    signal A_tb, B_tb : std_logic_vector(WIDTH-1 downto 0);
    signal Op_tb      : std_logic_vector(3 downto 0);
    signal LogicSel_tb: std_logic_vector(1 downto 0);
    signal RotSel_tb  : std_logic;
    signal Result_tb  : std_logic_vector((2*WIDTH)-1 downto 0);
    signal Cout_tb    : std_logic;

begin

   ------------------------------------------------------------------
    -- UUT = Unit Under Test (ALU)
    ------------------------------------------------------------------
    UUT : entity work.ALU
        generic map (WIDTH => WIDTH)
        port map (
            A        => A_tb,
            B        => B_tb,
            Op       => Op_tb,
            LogicSel => LogicSel_tb,
            RotSel   => RotSel_tb,
            Result   => Result_tb,
            Cout     => Cout_tb
        );

    ------------------------------------------------------------------
    -- PROCES DE TEST
    ------------------------------------------------------------------
    stim_proc : process
    begin

        ------------------------------------------------------------
        -- ADD : 10 + 5 = 15
        ------------------------------------------------------------
        A_tb <= x"0A"; B_tb <= x"05";
        Op_tb <= "0000"; LogicSel_tb <= "00"; RotSel_tb <= '0';
        wait for 20 ns;
        assert Result_tb(7 downto 0) = x"0F"
            report "ERROR ADD" severity error;

        ------------------------------------------------------------
        -- SUB : 20 - 7 = 13
        ------------------------------------------------------------
        A_tb <= x"14"; B_tb <= x"07";
        Op_tb <= "0001";
        wait for 20 ns;
        assert Result_tb(7 downto 0) = x"0D"
            report "ERROR SUB" severity error;

        ------------------------------------------------------------
        -- INC : 10 + 1 = 11
        ------------------------------------------------------------
        A_tb <= x"0A";
        Op_tb <= "0010";
        wait for 20 ns;
        assert Result_tb(7 downto 0) = x"0B"
            report "ERROR INC" severity error;

        ------------------------------------------------------------
        -- DEC : 10 - 1 = 9
        ------------------------------------------------------------
        A_tb <= x"0A";
        Op_tb <= "0011";
        wait for 20 ns;
        assert Result_tb(7 downto 0) = x"09"
            report "ERROR DEC" severity error;

        ------------------------------------------------------------
        -- NEG : -7 (C2)
        ------------------------------------------------------------
        A_tb <= x"07";
        Op_tb <= "0100";
        wait for 20 ns;
        assert Result_tb(7 downto 0) = std_logic_vector(to_unsigned(256-7,8))
            report "ERROR NEG" severity error;

       ------------------------------------------------------------
-- LOGIC AND : 0F AND 33 = 03
------------------------------------------------------------
A_tb <= x"0F"; B_tb <= x"33";
Op_tb <= "0101"; LogicSel_tb <= "00";
wait for 20 ns;
assert Result_tb(7 downto 0) = x"03"
    report "ERROR AND" severity error;

------------------------------------------------------------
-- LOGIC OR : 0F OR 33 = 3F
------------------------------------------------------------
LogicSel_tb <= "01";
wait for 20 ns;
assert Result_tb(7 downto 0) = x"3F"
    report "ERROR OR" severity error;

------------------------------------------------------------
-- LOGIC NOT : NOT 0F = F0
------------------------------------------------------------
LogicSel_tb <= "10";
wait for 20 ns;
assert Result_tb(7 downto 0) = x"F0"
    report "ERROR NOT" severity error;

        ------------------------------------------------------------
        -- ROTATE LEFT
        ------------------------------------------------------------
        A_tb <= "10110011";
        Op_tb <= "0110"; RotSel_tb <= '0';
        wait for 20 ns;

        ------------------------------------------------------------
        -- ROTATE RIGHT
        ------------------------------------------------------------
        RotSel_tb <= '1';
        wait for 20 ns;

        ------------------------------------------------------------
        -- MUL : 10 * 3 = 30
        ------------------------------------------------------------
        A_tb <= x"0A"; B_tb <= x"03";
        Op_tb <= "0111";
        wait for 20 ns;
        assert Result_tb = x"001E"
            report "ERROR MUL" severity error;

        ------------------------------------------------------------
        -- DIV : 30 / 5 = 6
        ------------------------------------------------------------
        A_tb <= x"1E"; B_tb <= x"05";
        Op_tb <= "1000";
        wait for 20 ns;
        assert Result_tb(7 downto 0) = x"06"
            report "ERROR DIV" severity error;

        ------------------------------------------------------------
        report "ALL TESTS PASSED SUCCESSFULLY " severity note;
        wait;

    end process;
end Behavioral;
