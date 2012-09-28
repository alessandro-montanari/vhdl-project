-- Alessandro Montanari 880606-Y555

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity trigger_generator is
port(
		clk : in STD_LOGIC;
		trigger : out STD_LOGIC
);
end trigger_generator;

architecture Behavioral of trigger_generator is

component Counter is
	 generic(n : POSITIVE := 10);
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           reset : in  STD_LOGIC;			-- Active Low
           output : out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

signal resetCounter : STD_LOGIC := '0';
signal outputCounter : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');

begin

	count : Counter generic map(24) port map(clk,'1',resetCounter,outputCounter);
	
 	process(clk)
		constant ms250 : STD_LOGIC_VECTOR(23 downto 0) := "101111101011110000100000";
		constant ms250And100us : STD_LOGIC_VECTOR(23 downto 0) := "101111101100111110101000";
		
	begin
		if(clk'event and clk = '1') then
			if(outputCounter >= ms250 and outputCounter < ms250And100us) then
				trigger <= '1';
			else
				trigger <= '0';
			end if;
			
			if(outputCounter = ms250And100us) then
				resetCounter <= '0';
			else
				resetCounter <= '1';
			end if;
		end if; -- clk
	end process;
end Behavioral;
