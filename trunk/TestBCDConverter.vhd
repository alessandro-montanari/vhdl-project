-- Alessandro Montanari 880606-Y555

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TestBCDConverter IS
END TestBCDConverter;
 
ARCHITECTURE behavior OF TestBCDConverter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bcd_converter
    PORT(
         input : IN  std_logic_vector(8 downto 0);
         hundreds : OUT  std_logic_vector(3 downto 0);
         tens : OUT  std_logic_vector(3 downto 0);
         unit : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(8 downto 0) := (others => '0');

 	--Outputs
   signal hundreds : std_logic_vector(3 downto 0);
   signal tens : std_logic_vector(3 downto 0);
   signal unit : std_logic_vector(3 downto 0);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bcd_converter PORT MAP (
          input => input,
          hundreds => hundreds,
          tens => tens,
          unit => unit
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
		input <= "010111001";
		wait for 200us;
		input <= "111010110";
		wait for 200us;
		input <= "101001001";
      wait;
   end process;

END;
