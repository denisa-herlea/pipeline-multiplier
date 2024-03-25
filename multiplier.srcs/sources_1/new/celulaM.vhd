library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity celulaM is
  Port ( 
    signal x: in std_logic;
    signal a: in std_logic;
    signal y:in std_logic;
    signal Tin: in std_logic;
    signal Tout: out std_logic;
    signal S: out std_logic
  );
end celulaM;

architecture Behavioral of celulaM is
signal b: std_logic;

component SE is
Port (
     x: in std_logic;
     y: in std_logic;
     Tin:in std_logic;
     S:out std_logic;
     Tout: out std_logic  
   );
end component;


begin
b<= x and y;

sumator : SE port map (x=>a, y=>b, Tin=>Tin, S=> S, Tout=>Tout);

end Behavioral;
