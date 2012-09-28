-- Alessandro Montanari 880606-Y555

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter is
	 generic(n : POSITIVE := 10);
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           reset : in  STD_LOGIC;			-- Active Low
           output : out  STD_LOGIC_VECTOR(n-1 downto 0) );
end Counter;

architecture Behavioral of Counter is
	signal num : STD_LOGIC_VECTOR(n-1 downto 0);

begin
	process (clk, reset)
		
	begin
		if(reset = '0') then
			num <= (others => '0');
		elsif(clk'event and clk = '1') then
			if (en = '1') then
					num <= num + 1;   	-- When num goes in overflow it will change automatically in "0..."
			end if;
		end if;
	end process;
	
	output <= num;

end Behavioral;

