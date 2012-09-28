-- Alessandro Montanari 880606-Y555

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity distance_measurer is
    port ( clk : in  STD_LOGIC;
			  trigg : in STD_LOGIC;
           pulse : in  STD_LOGIC;
           distance : out  STD_LOGIC_VECTOR(8 downto 0) := (others => '0') );  -- we start from a known state (not necessary)
end distance_measurer;

architecture Behavioral of distance_measurer is

	component Counter is
		 generic(n : POSITIVE := 10);
		 Port ( clk : in  STD_LOGIC;
				  en : in  STD_LOGIC;
				  reset : in  STD_LOGIC;			-- Active Low
				  output : out  STD_LOGIC_VECTOR(n-1 downto 0) );
	end component;

	signal CounterPulseOut : STD_LOGIC_VECTOR(21 downto 0);

begin

	CounterPulse : Counter generic map(22) port map(clk,pulse,not trigg,CounterPulseOut);
	
	DistanceProcess : process(pulse,CounterPulseOut)
		variable temp : integer;
		variable tempVar : STD_LOGIC_VECTOR(23 downto 0);
	begin
			if(pulse'event and pulse = '0') then							-- we use the negative edge of the pulse because we know that in that moment
				tempVar :=  CounterPulseOut * "11";							-- the measure is finished and even because in this way its possible to leave 
				temp := to_integer(unsigned(tempVar(23 downto 13)));	-- the distance unchenged for the entire period necessary to make another measure.
				if(temp > 458) then												-- Without the edge detection the distance will change when the CounterPulseOut goes
					distance <= "111111111";									-- to zero (when the trigger rise to 1). To put the CounterPulseOut in the sensitivty list
				else																	-- was signaled from XST as a warning. 
					distance <= STD_LOGIC_VECTOR(to_unsigned(temp,9));
				end if;
			end if;
	end process DistanceProcess;
end Behavioral;

