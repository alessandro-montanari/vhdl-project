-- Alessandro Montanari 880606-Y555

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY test_Project_2011 IS
END entity test_Project_2011;

ARCHITECTURE behavior OF test_Project_2011 IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT edge_sobel_wrapper
	PORT(
		clk : IN std_logic;
		fsync_in : IN std_logic;
		rsync_in : IN std_logic;
		pdata_in : IN std_logic_vector(7 downto 0);          
		fsync_out : OUT std_logic;
		rsync_out : OUT std_logic;
		pdata_out : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Number_Displayer is
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
 end COMPONENT;
 
 
	SIGNAL clk :  std_logic := '0';
	SIGNAL fsync_in :  std_logic := '0';
	SIGNAL rsync_in :  std_logic := '0';
	SIGNAL pdata_in :  std_logic_vector(7 downto 0) := (others=>'0');
	
	SIGNAL fsync_out_sobel :  std_logic := '0';
	SIGNAL rsync_out_sobel :  std_logic := '0';
	SIGNAL pdata_out_sobel :  std_logic_vector(7 downto 0) := (others=>'0');
	
	SIGNAL reset : std_logic := '0';
	
	SIGNAL fsync_out_displayer :  std_logic := '0';
	SIGNAL rsync_out_displayer :  std_logic := '0';
	SIGNAL pdata_out_displayer :  std_logic_vector(7 downto 0) := (others=>'0');

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: edge_sobel_wrapper PORT MAP(
		clk => clk,
		fsync_in => fsync_in,
		rsync_in => rsync_in,
		pdata_in => pdata_in,
		fsync_out => fsync_out_sobel,
		rsync_out => rsync_out_sobel,
		pdata_out => pdata_out_sobel
	);
	
	nd: Number_Displayer PORT MAP (
          clk => clk,
          fsync_in => fsync_out_sobel,
          rsync_in => rsync_out_sobel,
          data_in => pdata_out_sobel,
          pos_row => "0000111100",
          pos_col => "0000111100",
          meters => "0100",
          decimeters => "0110",
          centimeters => "0111",
          fsync_out => fsync_out_displayer,
          rsync_out => rsync_out_displayer,
          data_out => pdata_out_displayer
        );


	img_read : entity work.img_testbench
	port map (
      pclk_i    => clk,
	 	reset_i	 => reset,
      fsync_i   => fsync_out_displayer,
      rsync_i   => rsync_out_displayer,		
      pdata_i   => pdata_out_displayer,	  
		cols_o	 => open,
		rows_o	 => open,
		col_o		 => open,
		row_o		 => open,
      fsync_o   => fsync_in,
      rsync_o   => rsync_in,
		pdata_o   => pdata_in);

	clock_generate: process (clk)
		constant T_pw : time := 50 ns;      -- Clock period is 100ns. pr 60ns
	begin  -- process img
		if clk = '0' then
			clk <= '1' after T_pw, '0' after 2*T_pw;
		end if;
	end process clock_generate;
	
	reset <= '1', '0' after 60 ns;

END;
