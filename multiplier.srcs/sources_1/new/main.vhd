library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;


entity main is
    generic( n: integer:=4);
    
  Port (
      x: in std_logic_vector(n-1 downto 0);
      y: in std_logic_vector(n-1 downto 0);
      Clk: in std_logic;
      P: out std_logic_vector (2*n-1 downto 0)
   );
end entity main;


architecture Behavioral of main is

component celulaM is
  Port(
      x: in std_logic;
      a: in std_logic;
      y:in std_logic;
      Tin: in std_logic;
      Tout: out std_logic;
      S: out std_logic
  );
end component;




signal T: std_logic_vector ((n*(n+1)-1) downto 0):=(others => '0');
signal S: std_logic_vector ((n*n)-1 downto 0):=(others => '0');
signal R1: std_logic_vector (2*n-1 downto 0):= (others => '0');

type memory is array(0 to n-2) of std_logic_vector(3*n-1 downto 0);
signal R: memory := (others => (others => '0'));

begin
process(Clk)
begin
  if rising_edge(Clk) then
        R1(2*n-1 downto 0) <=x(n-1 downto 0)&y(n-1 downto 0);
     end if; 
end process;

---------------------------------------------------------------------------------------------------------------
generare_etaj_1 : 
for i in 0 to n-1 generate
    M1_n : celulaM port map(x=>R1(i+n),a=>'0',y=>R1(0),Tin=>T(i),Tout=>T(i+1),S=>S(i));
end generate;

-----------------------------------------------------------------------------------------------------------------
process(Clk)
begin
   if rising_edge(Clk) then
        R(0)(3*n-1) <= R1(2*n-1);
        R(0)(3*n-2) <= T(n);
  
        for i in 1 to n-1 loop
             R(0)(3*n-(((i+1)*2)-1)) <= R1(2*n-i-1);
             R(0)(3*n-(((i+1)*2)-1)-1) <= S(n-i);
        end loop;
        R(0)(n-1) <= S(0);

        for i in 1 to n-1 loop
             R(0)(n-1-i) <= R1(n-i);
        end loop;

       end if;
end process;

--------------------------------------------------------------------------------------------------------------------------
generare_etaje_2_n_minus_1 : for i in 2 to n-1 generate
   
    celuleM : for j in 1 to n generate
        M: celulaM port map(x=>R(i-2)(n-1 +2*j),a=>R(i-2)(n-1 + 2*j -1),y=>R(i-2)(0),Tin=>T(j-1 + (n+1)*(i-1)),Tout=>T(j+ (n+1)*(i-1)), S=>S(n*(i-1) + j-1));
        
    end generate;

------------------------------------------------------------------------------------------------------------------------    

process(Clk)
begin
    if rising_edge(Clk) then
        R(i-1)(3*n-1) <= R(i-2)(3*n-1);
        R(i-1)(3*n-2) <= T(n + (n+1)*(i-1));

         for j in 1 to n-1 loop
            R(i-1)(3*n-(((j+1)*2)-1)) <= R(i-2)(3*n-2 -j*2+ 1);
            R(i-1)(3*n-(((j+1)*2)-1)-1) <= S((2*n-j)+ (i-2)*n);
         end loop;
         
         R(i-1)(n-1) <= S(n*(i-1));
         
         for j in 1 to n-1 loop
            R(i-1)(n-j-1) <= R(i-2)(n-j);
         end loop;
         
    end if;
end process;

end generate;

-------------------------------------------------------------------------------------------------------------------------------
ultime_celuleM : for j in 1 to n generate
M : celulaM port map(x=>R(n-2)(n-1 +2*j),a=>R(n-2)(n-1 +2*j-1),y=>R(n-2)(0),Tin=>T(j-1 + (n+1)*(n-1)),Tout=>T(j+ (n+1)*(n-1)), S=>S(n*(n-1) + j-1));
end generate;


-------------------------------------------------------------------------------------------------------------------------------
process(Clk)
    begin
    if rising_edge(Clk) then
        P(2*n-1) <= T(n* (n+1) -1);
        for i in 1 to n loop
            P(2*n-i-1)<=S(n*n-i);
        end loop;
        
        for i in 1 to n-1 loop
            P(n-i-1)<= R(n-2)(n-i);
        end loop;
end if;
end process;

end Behavioral;
