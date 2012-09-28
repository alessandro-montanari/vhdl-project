-- Alessandro Montanari 880606-Y555

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TestDoubleFIFOLineBuffer IS
END TestDoubleFIFOLineBuffer;
 
ARCHITECTURE behavior OF TestDoubleFIFOLineBuffer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DoubleFiFOLineBuffer
    PORT(
         clk : IN  std_logic;
         fsync : IN  std_logic;
         rsync : IN  std_logic;
         pdata_in : IN  std_logic_vector(7 downto 0);
         pdata_out1 : OUT  std_logic_vector(7 downto 0);
         pdata_out2 : BUFFER  std_logic_vector(7 downto 0);
         pdata_out3 : BUFFER  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal fsync : std_logic := '0';
   signal rsync : std_logic := '0';
   signal pdata_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal pdata_out1 : std_logic_vector(7 downto 0);
   signal pdata_out2 : std_logic_vector(7 downto 0);
   signal pdata_out3 : std_logic_vector(7 downto 0);
	
	SIGNAL reset : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DoubleFiFOLineBuffer PORT MAP (
          clk => clk,
          fsync => fsync,
          rsync => rsync,
          pdata_in => pdata_in,
          pdata_out1 => pdata_out1,
          pdata_out2 => pdata_out2,
          pdata_out3 => pdata_out3
        );

   img_read : entity work.img_testbench
	port map (
      pclk_i    => clk,
	 	reset_i	 => reset,
      fsync_i   => fsync,
      rsync_i   => rsync,		
      pdata_i   => pdata_out1,	  
		cols_o	 => open,
		rows_o	 => open,
		col_o		 => open,
		row_o		 => open,
      fsync_o   => fsync,
      rsync_o   => rsync,
		pdata_o   => pdata_in);
	
	clock_generate: process (clk)
		constant T_pw : time := 50 ns;      -- Clock period is 100ns.
	begin  -- process img
		if clk = '0' then
			clk <= '1' after T_pw, '0' after 2*T_pw;
		end if;
	end process clock_generate;

   -- Stimulus process
   stim_proc: process
   begin		

      wait;
   end process;
	
	reset <= '1', '0' after 60 ns;

END;
