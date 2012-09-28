-- Alessandro Montanari 880606-Y555
-- Test for 1.4us

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
ENTITY TestSobelKernel IS
END TestSobelKernel;
 
ARCHITECTURE behavior OF TestSobelKernel IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT edge_sobel
    PORT(
         pclk_i : IN  std_logic;
         fsync_i : IN  std_logic;
         rsync_i : IN  std_logic;
         pData1 : IN  std_logic_vector(7 downto 0);
         pData2 : IN  std_logic_vector(7 downto 0);
         pData3 : IN  std_logic_vector(7 downto 0);
         pData4 : IN  std_logic_vector(7 downto 0);
         pData5 : IN  std_logic_vector(7 downto 0);
         pData6 : IN  std_logic_vector(7 downto 0);
         pData7 : IN  std_logic_vector(7 downto 0);
         pData8 : IN  std_logic_vector(7 downto 0);
         pData9 : IN  std_logic_vector(7 downto 0);
         fsync_o : OUT  std_logic;
         rsync_o : OUT  std_logic;
         pdata_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal pclk_i : std_logic := '0';
   signal fsync_i : std_logic := '1';
   signal rsync_i : std_logic := '1';
   signal pData1 : std_logic_vector(7 downto 0) := (others => '0');
   signal pData2 : std_logic_vector(7 downto 0) := (others => '0');
   signal pData3 : std_logic_vector(7 downto 0) := (others => '0');
   signal pData4 : std_logic_vector(7 downto 0) := (others => '0');
   signal pData5 : std_logic_vector(7 downto 0) := (others => '0');
   signal pData6 : std_logic_vector(7 downto 0) := (others => '0');
   signal pData7 : std_logic_vector(7 downto 0) := (others => '0');
   signal pData8 : std_logic_vector(7 downto 0) := (others => '0');
   signal pData9 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal fsync_o : std_logic;
   signal rsync_o : std_logic;
   signal pdata_o : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	
	signal reset, fsync, rsync : std_logic;
	signal pData : std_logic_vector(7 downto 0) := (others => '0');
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: edge_sobel PORT MAP (
          pclk_i => pclk_i,
          fsync_i => fsync_i,
          rsync_i => rsync_i,
          pData1 => pData1,
          pData2 => pData2,
          pData3 => pData3,
          pData4 => pData4,
          pData5 => pData5,
          pData6 => pData6,
          pData7 => pData7,
          pData8 => pData8,
          pData9 => pData9,
          fsync_o => fsync_o,
          rsync_o => rsync_o,
          pdata_o => pdata_o
        );

   -- Clock process definitions
   clock_generate: process (pclk_i)
		constant T_pw : time := 20 ns;      -- Clock period is 100ns.
	begin  -- process img
		if pclk_i = '0' then
			pclk_i <= '1' after T_pw, '0' after 2*T_pw;
		end if;
	end process clock_generate;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 400 ns;	

      -- insert stimulus here 
		pData1 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData2 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData3 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData4 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData5 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData6 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData7 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData8 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData9 <= CONV_STD_LOGIC_VECTOR(255,8);
		
		wait for 400ns;
		
		pData1 <= CONV_STD_LOGIC_VECTOR(0,8);
		pData2 <= CONV_STD_LOGIC_VECTOR(0,8);
		pData3 <= CONV_STD_LOGIC_VECTOR(0,8);
		pData4 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData5 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData6 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData7 <= CONV_STD_LOGIC_VECTOR(0,8);
		pData8 <= CONV_STD_LOGIC_VECTOR(255,8);
		pData9 <= CONV_STD_LOGIC_VECTOR(255,8);
		
		 wait for 400 ns;	

      -- insert stimulus here 
		pData1 <= CONV_STD_LOGIC_VECTOR(0,8);
		pData2 <= CONV_STD_LOGIC_VECTOR(20,8);
		pData3 <= CONV_STD_LOGIC_VECTOR(24,8);
		pData4 <= CONV_STD_LOGIC_VECTOR(0,8);
		pData5 <= CONV_STD_LOGIC_VECTOR(22,8);
		pData6 <= CONV_STD_LOGIC_VECTOR(35,8);
		pData7 <= CONV_STD_LOGIC_VECTOR(22,8);
		pData8 <= CONV_STD_LOGIC_VECTOR(34,8);
		pData9 <= CONV_STD_LOGIC_VECTOR(0,8);
		
      wait;
   end process;

END;
