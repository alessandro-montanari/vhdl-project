-- Alessandro Montanari 880606-Y555

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TestNumberDisplayer IS
END TestNumberDisplayer;
 
ARCHITECTURE behavior OF TestNumberDisplayer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component Number_Displayer is
port(
	  clk : in  STD_LOGIC;
	  fsync_in : in  STD_LOGIC;
	  rsync_in : in  STD_LOGIC;
	  data_in : in  STD_LOGIC_VECTOR(7 downto 0);
	  pos_row : in STD_LOGIC_VECTOR(9 downto 0);
	  pos_col : in STD_LOGIC_VECTOR(9 downto 0);
	  meters : in STD_LOGIC_VECTOR(3 downto 0);
	  decimeters : in STD_LOGIC_VECTOR(3 downto 0);
	  centimeters : in STD_LOGIC_VECTOR(3 downto 0);
	  fsync_out : out  STD_LOGIC;
	  rsync_out : out  STD_LOGIC;
	  data_out : out  STD_LOGIC_VECTOR(7 downto 0)
 );		  
end component;
    

   --Inputs
   signal clk : std_logic := '0';
   signal fsync_in : std_logic := '0';
   signal rsync_in : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal pos_row : std_logic_vector(9 downto 0) := (others => '0');
   signal pos_col : std_logic_vector(9 downto 0) := (others => '0');
	signal reset : std_logic;

 	--Outputs
   signal fsync_out : std_logic;
   signal rsync_out : std_logic;
   signal data_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Number_Displayer PORT MAP (
          clk => clk,
          fsync_in => fsync_in,
          rsync_in => rsync_in,
          data_in => data_in,
          pos_row => "0000111100", -- 60
          pos_col => "0000111100", -- 60
          meters => "0010",
          decimeters => "0111",
          centimeters => "1001",
          fsync_out => fsync_out,
          rsync_out => rsync_out,
          data_out => data_out
        );
		  
	img_read : entity work.img_testbench
	port map (
      pclk_i    => clk,
	 	reset_i	 => reset,
      fsync_i   => fsync_out,
      rsync_i   => rsync_out,		
      pdata_i   => data_out,	  
		cols_o	 => open,
		rows_o	 => open,
		col_o		 => open,
		row_o		 => open,
      fsync_o   => fsync_in,
      rsync_o   => rsync_in,
		pdata_o   => data_in);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

  
   reset <= '1', '0' after 60 ns;

END;
