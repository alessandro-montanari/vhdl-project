-- Alessandro Montanari 880606-Y555

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TestSyncSignalsDelayer IS
END TestSyncSignalsDelayer;
 
ARCHITECTURE behavior OF TestSyncSignalsDelayer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SyncSignalsDelayer
    PORT(
         clk : IN  std_logic;
         fsync_in : IN  std_logic;
         rsync_in : IN  std_logic;
         fsync_out : OUT  std_logic;
         rsync_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal fsync_in : std_logic := '0';
   signal rsync_in : std_logic := '0';

 	--Outputs
	signal pdata_in : std_logic_vector(7 downto 0); 
	signal pdata_out : std_logic_vector(7 downto 0);
   signal fsync_out : std_logic;
   signal rsync_out : std_logic;
	signal reset : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SyncSignalsDelayer PORT MAP (
          clk => clk,
          fsync_in => fsync_in,
          rsync_in => rsync_in,
          fsync_out => fsync_out,
          rsync_out => rsync_out
        );
		  
	img_read : entity work.img_testbench
	port map (
      pclk_i    => clk,
	 	reset_i	 => reset,
      fsync_i   => fsync_out,
      rsync_i   => rsync_out,		
      pdata_i   => pdata_out,	  
		cols_o	 => open,
		rows_o	 => open,
		col_o		 => open,
		row_o		 => open,
      fsync_o   => fsync_in,
      rsync_o   => rsync_in,
		pdata_o   => pdata_in);
		
		pdata_out <= pdata_in;

  clock_generate: process (clk)
		constant T_pw : time := 50 ns;      -- Clock period is 100ns.
	begin  -- process img
		if clk = '0' then
			clk <= '1' after T_pw, '0' after 2*T_pw;
		end if;
	end process clock_generate;
	
	reset <= '1', '0' after 60 ns;

END;
