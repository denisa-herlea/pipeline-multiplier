library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SE is
  Port (
     x: in std_logic;
     y: in std_logic;
     Tin:in std_logic;
     S:out std_logic;
     Tout: out std_logic  
   );
end SE;

architecture Behavioral of SE is

begin
S<= x xor y xor Tin;
Tout<= (x and y) or ((x or y) and Tin);

end Behavioral;
