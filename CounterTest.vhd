-- Alessandro Montanari 880606-Y555

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY CounterTest IS
END CounterTest;
 
ARCHITECTURE behavior OF CounterTest IS 

	 constant bits : integer := 3;
	 
	 -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Counter
	 generic(n : POSITIVE := 10);
    PORT(
         clk : IN  std_logic;
         en : IN  std_logic;
         reset : IN  std_logic;
         output : OUT  std_logic_vector(bits-1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal output : std_logic_vector(bits-1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Counter GENERIC MAP(bits) PORT MAP (
          clk => clk,
          en => en,
          reset => reset,
          output => output
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
      wait for 10 ns;
		reset <= '0';
		wait for 10ns;
		reset <= '1';
		wait for 10ns;
		en <= '1';
		wait for 100ns;
		en <= '0';
		wait for 50ns;
		reset <= '0';
      wait;
   end process;
END;
