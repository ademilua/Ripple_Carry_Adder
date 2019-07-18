library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Ripple_Carry_Adder_tb is
--  Port ( );
end Ripple_Carry_Adder_tb;

architecture Behavioral of Ripple_Carry_Adder_tb is
component Ripple_Carry_Adder is
Generic (data_width_rca:integer:=4); --I used "data_width_rca" because I want to use another "data_width" in the multiplier section
   Port ( A : in STD_LOGIC_VECTOR (data_width_rca-1 downto 0);
           B : in STD_LOGIC_VECTOR (data_width_rca-1 downto 0);
           C_in : in STD_LOGIC;
           SUM : out STD_LOGIC_VECTOR (data_width_rca downto 0));
end component;

constant data_width_rca : integer:=4;
signal A_tb : STD_LOGIC_VECTOR (data_width_rca-1 downto 0);
signal B_tb : STD_LOGIC_VECTOR (data_width_rca-1 downto 0);
signal C_in_tb : STD_LOGIC:='0'; -- because the first carry in should be zero normally
signal SUM_tb : STD_LOGIC_VECTOR (data_width_rca downto 0);
signal SUMmm : STD_LOGIC_VECTOR (data_width_rca+1 downto 0);

begin

uut: component Ripple_Carry_Adder
generic map (data_width_rca=>data_width_rca)
 port map(
          A=>A_tb,
          B=>B_tb,
          C_in=>C_in_tb,
          SUM=>SUM_tb);

process
begin
C_in_tb<='0';

for k in 0 to ((2**data_width_rca)-1) loop
  A_tb<=std_logic_vector(to_unsigned(k,data_width_rca));
  for h in 0 to ((2**data_width_rca)-1) loop
    B_tb<=std_logic_vector(to_unsigned(h,data_width_rca));
    wait for 10 ns;
    assert(SUM_tb<=std_logic_vector(to_unsigned(k,data_width_rca) + to_unsigned(h,data_width_rca))) 
    report "Testing at A("&integer'image(k)&")"&" and B("&integer'image(h)&") failed"
    severity error;
  end loop;
end loop;
wait;    
end process;

end Behavioral;
