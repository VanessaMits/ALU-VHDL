----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2025 10:30:30 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
generic (WIDTH : integer := 8);
  port (
    A, B       : in  std_logic_vector(WIDTH-1 downto 0);
    Op         : in  std_logic_vector(3 downto 0);  -- main operation code
    LogicSel   : in  std_logic_vector(1 downto 0);  -- for logic ops
    RotSel     : in  std_logic;                     -- for rotation ops
    Result     : out std_logic_vector((2*WIDTH)-1 downto 0);
    Cout       : out std_logic);
end ALU;

architecture Behavioral of ALU is

  signal AddOut, SubOut, NegOut, LogicOut, RotOut : std_logic_vector(WIDTH-1 downto 0);
  signal Cadd, Csub : std_logic;
  signal B_c2 : std_logic_vector(WIDTH-1 downto 0);
  signal ShiftVal : integer range 0 to WIDTH-1 := 1;
  signal IncOut : std_logic_vector(WIDTH-1 downto 0);
  signal Cinc   : std_logic;

  signal ONE     : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
  signal ONE_C2  : std_logic_vector(WIDTH-1 downto 0);
  signal DecOut  : std_logic_vector(WIDTH-1 downto 0);
  signal Cdec    : std_logic;
  
  signal MulOut : std_logic_vector((2*WIDTH)-1 downto 0);
  signal DivOut : std_logic_vector(WIDTH-1 downto 0); -- quotient
  signal RemOut : std_logic_vector(WIDTH-1 downto 0); -- remainder (optional)



  
  component Ripple_Adder is

generic (
    WIDTH : integer := 8  
  );
  
    port(
    A    : in  std_logic_vector(WIDTH-1 downto 0);
    B    : in  std_logic_vector(WIDTH-1 downto 0);
    Cin  : in  std_logic;
    Sum  : out std_logic_vector(WIDTH-1 downto 0);
    Cout : out std_logic
  );
end component;


component C2 is
  generic (WIDTH : integer := 8);
  port (
    X : in  std_logic_vector(WIDTH-1 downto 0);
    Y : out std_logic_vector(WIDTH-1 downto 0)
  );
end component;

component Incrementer is
generic (
    WIDTH : integer := 8
  );
  port (
    A    : in  std_logic_vector(WIDTH-1 downto 0);
    Y    : out std_logic_vector(WIDTH-1 downto 0);
    Cout : out std_logic
  );
end component;


component Logic_Utit is
generic (WIDTH : integer := 8);
  port (
    A, B      : in  std_logic_vector(WIDTH-1 downto 0);
    LogicSel  : in  std_logic_vector(1 downto 0); -- selects AND, OR, XOR, NOT
    Result    : out std_logic_vector(WIDTH-1 downto 0)
  );
end component;

component Rotation_Unit is
generic (WIDTH : integer := 8);
  port (
    A       : in  std_logic_vector(WIDTH-1 downto 0);
    ShiftVal : in  integer range 0 to WIDTH-1;
    RotSel  : in  std_logic; 
    Result  : out std_logic_vector(WIDTH-1 downto 0)
    );
end component;

component Multiplier is
generic (
    WIDTH : integer := 8
  );
  port (
    X    : in  std_logic_vector(WIDTH-1 downto 0);
    Y    : in  std_logic_vector(WIDTH-1 downto 0);
    P    : out std_logic_vector((2*WIDTH)-1 downto 0)
  );
  end component;
  
  component Divider is
 generic (WIDTH : integer := 8);
  port (
    A : in  std_logic_vector(WIDTH-1 downto 0);
    B : in  std_logic_vector(WIDTH-1 downto 0);
    Q : out std_logic_vector(WIDTH-1 downto 0);
    R : out std_logic_vector(WIDTH-1 downto 0)
  );end component;
  
  

begin

process(A, B, Op, AddOut, SubOut, IncOut, DecOut, NegOut, LogicOut, RotOut, MulOut, DivOut)
begin
  case Op is

    when "0000" => Result((2*WIDTH)-1 downto WIDTH) <= (others => '0');
      Result(WIDTH-1 downto 0) <= AddOut; Cout <= Cadd;

    when "0001" => Result((2*WIDTH)-1 downto WIDTH) <= (others => '0');
      Result(WIDTH-1 downto 0) <= SubOut; Cout <= Csub;

    when "0010" => Result((2*WIDTH)-1 downto WIDTH) <= (others => '0');
      Result(WIDTH-1 downto 0) <= IncOut; Cout <= Cinc;

    when "0011" => Result((2*WIDTH)-1 downto WIDTH) <= (others => '0');
      Result(WIDTH-1 downto 0) <= DecOut; Cout <= Cdec;

    when "0100" => Result((2*WIDTH)-1 downto WIDTH) <= (others => '0');
      Result(WIDTH-1 downto 0) <= NegOut; Cout <= '0';

    when "0101" => Result((2*WIDTH)-1 downto WIDTH) <= (others => '0');
      Result(WIDTH-1 downto 0) <= LogicOut; Cout <= '0';

    when "0110" => Result((2*WIDTH)-1 downto WIDTH) <= (others => '0');
      Result(WIDTH-1 downto 0) <= RotOut; Cout <= '0';
      
    when "0111" =>Result <= MulOut; Cout <= '0';
    
    when "1000" => Result((2*WIDTH)-1 downto WIDTH) <= (others => '0'); 
    Result(WIDTH-1 downto 0) <= DivOut; Cout <= '0';
    
    when others =>Result <= (others => '0'); Cout <= '0';

  end case;
end process;


ONE(0) <= '1';

C2_B: C2 generic map (WIDTH => WIDTH)port map (X => B, Y => B_c2);
C2_ONE: C2 generic map (WIDTH => WIDTH)port map (X => ONE, Y => ONE_C2);

ADD_U: Ripple_Adder port map(A => A, B => B, Cin => '0', Sum => AddOut, Cout => Cadd);
SUB_U: Ripple_Adder port map(A => A, B => B_c2, Cin => '0', Sum => SubOut, Cout => Csub);
INC_U: Incrementer generic map (WIDTH => WIDTH)port map (A => A, Y=> IncOut, Cout => Cinc);
DEC_U: Ripple_Adder generic map (WIDTH => WIDTH)port map (A => A, B => ONE_C2, Cin  => '0', Sum  => DecOut, Cout => Cdec );
NEG_U: C2 generic map (WIDTH => WIDTH)port map (X => A, Y => NegOut);
LOGIC_U: Logic_Utit port map(A => A, B => B, LogicSel => LogicSel, Result => LogicOut);
ROT_U: Rotation_Unit port map(A => A, ShiftVal => ShiftVal, RotSel => RotSel, Result => RotOut);
MUL_U: Multiplier generic map(WIDTH=>WIDTH) port map(x=>A, y=>B, P=>MulOut);
DIV_U: Divider generic map(WIDTH=>WIDTH)port map(A=>A, B=>B, Q=>DivOut, R=>RemOut);

end Behavioral;
