-- Alessandro Montanari 880606-Y555

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TestRangeSensor IS
END TestRangeSensor;
 
ARCHITECTURE behavior OF TestRangeSensor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT range_sensor
    PORT(
         fpgaclk : IN  std_logic;
         triggerOut : OUT  std_logic;
         pulse : IN  std_logic;
         meters : OUT  std_logic_vector(3 downto 0);
         decimeters : OUT  std_logic_vector(3 downto 0);
         centimeters : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal fpgaclk : std_logic := '0';
   signal pulse : std_logic := '0';

 	--Outputs
   signal triggerOut : std_logic;
   signal meters : std_logic_vector(3 downto 0);
   signal decimeters : std_logic_vector(3 downto 0);
   signal centimeters : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant fpgaclk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: range_sensor PORT MAP (
          fpgaclk => fpgaclk,
          triggerOut => triggerOut,
          pulse => pulse,
          meters => meters,
          decimeters => decimeters,
          centimeters => centimeters
        );

   -- Clock process definitions
   fpgaclk_process :process
   begin
		fpgaclk <= '0';
		wait for fpgaclk_period/2;
		fpgaclk <= '1';
		wait for fpgaclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		pulse <= '0';
		wait for 251ms;
		pulse <= '1';
		wait for 10ms;
		pulse <='0';
		wait for 250ms;
		pulse <= '1';
		wait for 25ms;
		pulse <= '0';
      wait;
   end process;

END;
