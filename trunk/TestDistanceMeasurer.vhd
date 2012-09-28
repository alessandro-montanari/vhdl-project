-- Alessandro Montanari 880606-Y555

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TestDistanceMeasurer IS
END TestDistanceMeasurer;
 
ARCHITECTURE behavior OF TestDistanceMeasurer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT distance_measurer
    PORT(
         clk : IN  std_logic;
			trigg : IN STD_LOGIC;
         pulse : IN  std_logic;
         distance : out  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal pulse : std_logic := '0';
	signal trigg : std_logic := '0';

 	--Outputs
   signal distance : std_logic_vector(8 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: distance_measurer PORT MAP (
          clk => clk,
			 trigg => trigg,
          pulse => pulse,
          distance => distance
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		pulse <= '0';
		trigg <= '1';
		wait for 5ms;
		trigg <= '0';
		wait for 5ms;
		pulse <= '1';
		wait for 5ms;
		pulse <='0';
		wait for 5ms;
		trigg <= '1';
		wait for 5ms;
		trigg <= '0';
		wait for 10ms;
		pulse <= '1';
		wait for 25ms;
		pulse <= '0';

      wait;
   end process;

END;
