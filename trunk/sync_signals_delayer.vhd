-- Alessandro Montanari 880606-Y555

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	use	IEEE.STD_LOGIC_ARITH.ALL;
	use	IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SyncSignalsDelayer is
	generic (
		ROW_BITS	   : integer := 9 );
	port(
			clk : in std_logic;
			fsync_in : in std_logic;
			rsync_in : in std_logic;
			fsync_out : out std_logic;
			rsync_out : out std_logic );
end SyncSignalsDelayer;

architecture Behavioral of SyncSignalsDelayer is

	signal rowsDelayCounterRising, rowsDelayCounterFalling : std_logic_vector(ROW_BITS - 1 downto 0);
	signal rsync2, rsync1, fsync_temp : std_logic;
	
	COMPONENT Counter is
		 generic (n : POSITIVE);
		 Port ( clk : in  STD_LOGIC;
				  en : in  STD_LOGIC;
				  reset : in  STD_LOGIC;			-- Active Low
				  output : out  STD_LOGIC_VECTOR(n-1 downto 0));
	end COMPONENT;

begin

	-- Step 2
	RowsCounteComp : Counter generic map(ROW_BITS) port map(rsync2, fsync_in,fsync_in,rowsDelayCounterRising);
	rsync_out <= rsync2;
	fsync_out <= fsync_temp;
	
-- Step 1
p1 : process(clk)
begin
	if clk'event and clk='1' then
		-- Step 1 - delay of two clock cycles
		rsync2 <= rsync1;
		rsync1 <= rsync_in;
	end if;
end process p1;

-- Steps 3 and 5
p2 : process(rowsDelayCounterRising, rowsDelayCounterFalling)
begin
	-- rows2 = 2
	if rowsDelayCounterRising = "000000010" then
		fsync_temp <= '1';
	elsif rowsDelayCounterFalling = "000000000" then
		fsync_temp <= '0';
	end if;
end process p2;

-- Step 4
p3 : process(rsync2)
begin
	if rsync2'event and rsync2 = '0' then
		if fsync_temp = '1' then
			-- 479
			if rowsDelayCounterFalling < "111011111" then
				rowsDelayCounterFalling <= rowsDelayCounterFalling + 1;
			else
				rowsDelayCounterFalling <= "000000000";
			end if;
		else
			rowsDelayCounterFalling <= "000000000";
		end if;
	end if;
end process p3;

end Behavioral;

