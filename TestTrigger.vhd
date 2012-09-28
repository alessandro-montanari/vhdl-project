-- Alessandro Montanari 880606-Y555

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TestTrigger IS
END TestTrigger;
 
ARCHITECTURE behavior OF TestTrigger IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
   component trigger_generator is
	port(
		clk : in STD_LOGIC;
		trigger : out STD_LOGIC
	);	
	end component;

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal triggersig : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: trigger_generator PORT MAP (
          clk => clk,
          trigger => triggersig
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
END;
