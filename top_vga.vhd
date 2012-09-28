-- Alessandro Montanari 880606-Y555

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity topVGA is 
	port(
		clk		: in std_logic;
		dbg		: out std_logic;
		grd		: out std_logic;
		mode		: in std_logic;
		trigg		: out std_logic;
		
		data		: in std_logic_vector(7 downto 0);
		lv			: in std_logic;
		FV			: in std_logic;
		pixel_clk : in std_logic;

		LV_out	: out std_logic;								-- horizontal synchro signal					
		FV_out	: out std_logic;								-- verical synchro signal 
		vgaRed	: out std_logic_vector(7 downto 5); 	-- final color
		vgaGreen	: out std_logic_vector(7 downto 5);		-- outputs
		vgaBlue	: out std_logic_vector(7 downto 6)
	);
end entity topVGA;

architecture structure of topVGA is 

	SIGNAL data_o	: STD_LOGIC_VECTOR(7 DOWNTO 0);	
	SIGNAL meters		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL decimeters		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL centimeters		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL FV_OUT_SOBEL : STD_LOGIC;
	SIGNAL LV_OUT_SOBEL : STD_LOGIC;
	SIGNAL DATA_FOR_VGA : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
begin
	dbg <= '0';
	grd <= '0';

	rs : entity work.range_sensor  
	port map(
		fpgaclk		=> clk,
		pulse			=> mode,
		triggerOut	=> trigg,
		
		meters		=> meters,
		decimeters			=> decimeters,
		centimeters			=> centimeters
	);

	edge : entity work.edge_sobel_wrapper
	Port map ( 
		clk 			=> pixel_clk,
		fsync_in 	=> FV,
		rsync_in 	=> lv, 
		pdata_in 	=> DATA,
		fsync_out 	=> FV_OUT_SOBEL,
		rsync_out 	=> LV_OUT_SOBEL,
		pdata_out 	=> DATA_O
	);
	
	nm : entity work.number_displayer
	port map(
		clk      => pixel_clk,
		
		fsync_in => FV_OUT_SOBEL,
		rsync_in => LV_OUT_SOBEL,
		data_in => DATA_O,
		
		fsync_out => FV_OUT,
		rsync_out => LV_OUT,
		data_out => DATA_FOR_VGA,

		pos_row => "0000111100", -- 60
		pos_col => "0000111100", -- 60
	
		meters	   => meters,
		decimeters	   => decimeters,
		centimeters	   => centimeters
	);
	
	vgaRed <= DATA_FOR_VGA(7 DOWNTO 5);
	vgaGreen <= DATA_FOR_VGA(7 DOWNTO 5);
	vgaBlue <= DATA_FOR_VGA(7 DOWNTO 6);	
	
end architecture structure;
