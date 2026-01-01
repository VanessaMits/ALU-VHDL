----------------------------------------------------------------------------------
-- SSD - Seven Segment Display Driver (Basys 3)
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SSD is
    Port (
        digit0 : in std_logic_vector(3 downto 0); -- units
        digit1 : in std_logic_vector(3 downto 0); -- tens
        digit2 : in std_logic_vector(3 downto 0); -- hundreds
        digit3 : in std_logic_vector(3 downto 0); -- thousands
        clk    : in std_logic;
        catod  : out std_logic_vector(6 downto 0); -- a b c d e f g
        anod   : out std_logic_vector(3 downto 0)  -- AN3 AN2 AN1 AN0
    );
end SSD;

architecture Behavioral of SSD is

    signal d     : std_logic_vector(3 downto 0);
    signal count : unsigned(15 downto 0) := (others => '0');

begin

    ------------------------------------------------------------------
    -- BCD ? 7-segment decoder (common anode)
    ------------------------------------------------------------------
    process(d)
    begin
        case d is
            when "0000" => catod <= "1000000"; -- 0
            when "0001" => catod <= "1111001"; -- 1
            when "0010" => catod <= "0100100"; -- 2
            when "0011" => catod <= "0110000"; -- 3
            when "0100" => catod <= "0011001"; -- 4
            when "0101" => catod <= "0010010"; -- 5
            when "0110" => catod <= "0000010"; -- 6
            when "0111" => catod <= "1111000"; -- 7
            when "1000" => catod <= "0000000"; -- 8
            when "1001" => catod <= "0010000"; -- 9
            when others => catod <= "1111111"; -- OFF
        end case;
    end process;

    ------------------------------------------------------------------
    -- Clock divider (multiplexare afi?aj)
    ------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            count <= count + 1;
        end if;
    end process;

    ------------------------------------------------------------------
    -- Selectare anod (4 cifre)
    ------------------------------------------------------------------
    process(count(15 downto 14))
    begin
        case count(15 downto 14) is
            when "00" => anod <= "1110"; -- digit0 (AN0)
            when "01" => anod <= "1101"; -- digit1 (AN1)
            when "10" => anod <= "1011"; -- digit2 (AN2)
            when others => anod <= "0111"; -- digit3 (AN3)
        end case;
    end process;

    ------------------------------------------------------------------
    -- Selectare cifr? afi?at?
    ------------------------------------------------------------------
    process(count(15 downto 14))
    begin
        case count(15 downto 14) is
            when "00" => d <= digit0;
            when "01" => d <= digit1;
            when "10" => d <= digit2;
            when others => d <= digit3;
        end case;
    end process;

end Behavioral;
