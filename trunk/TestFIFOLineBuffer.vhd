-- Alessandro Montanari 880606-Y555

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use WORK.TYPES.all;
 
ENTITY TestFIFOLineBuffer IS
END TestFIFOLineBuffer;
 
ARCHITECTURE behavior OF TestFIFOLineBuffer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FIFOLineBuffer
    PORT(
         clk : IN  std_logic;
         fsync : IN  std_logic;
         rsync : IN  std_logic;
         pdata_in : IN  std_logic_vector(7 downto 0);
         pdata_out : BUFFER  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
   
   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal pdata_out : std_logic_vector(7 downto 0);
	
	SIGNAL reset : std_logic;
	
	SIGNAL fsync_in :  std_logic := '0';
	SIGNAL rsync_in :  std_logic := '0';
	
	signal pdata_in_fifo : std_logic_vector(7 downto 0) := (others => '0');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FIFOLineBuffer PORT MAP (
          clk => clk,
          fsync => fsync_in,
          rsync => rsync_in,
          pdata_in => pdata_in_fifo,
          pdata_out => pdata_out
        );
		  
	img_read : entity work.img_testbench
	port map (
      pclk_i    => clk,
	 	reset_i	 => reset,
      fsync_i   => fsync_in,
      rsync_i   => rsync_in,		
      pdata_i   => pdata_out,	  
		cols_o	 => open,
		rows_o	 => open,
		col_o		 => open,
		row_o		 => open,
      fsync_o   => fsync_in,
      rsync_o   => rsync_in,
		pdata_o   => pdata_in_fifo);
	
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
