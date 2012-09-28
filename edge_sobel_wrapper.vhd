-- Alessandro Montanari 880606-Y555

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity edge_sobel_wrapper is
	generic (
		DATA_WIDTH	: integer := 8 
	);
    Port ( clk : in  STD_LOGIC;
           fsync_in : in  STD_LOGIC;
           rsync_in : in  STD_LOGIC;
           pdata_in : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           fsync_out : out  STD_LOGIC;
           rsync_out : out  STD_LOGIC;
           pdata_out : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
end entity edge_sobel_wrapper;

architecture Structural of edge_sobel_wrapper is

SIGNAL pdata_int1 :  std_logic_vector(DATA_WIDTH-1 downto 0);	
SIGNAL pdata_int2 :  std_logic_vector(DATA_WIDTH-1 downto 0); 
SIGNAL pdata_int3 :  std_logic_vector(DATA_WIDTH-1 downto 0); 
SIGNAL pdata_int4 :  std_logic_vector(DATA_WIDTH-1 downto 0);  
SIGNAL pdata_int5 :  std_logic_vector(DATA_WIDTH-1 downto 0);
SIGNAL pdata_int6 :  std_logic_vector(DATA_WIDTH-1 downto 0);
SIGNAL pdata_int7 :  std_logic_vector(DATA_WIDTH-1 downto 0);
SIGNAL pdata_int8 :  std_logic_vector(DATA_WIDTH-1 downto 0);
SIGNAL pdata_int9 :  std_logic_vector(DATA_WIDTH-1 downto 0);
SIGNAL fsynch_int :  std_logic;
SIGNAL rsynch_int :  std_logic; 

begin

	CacheSystem : entity work.CacheSystem 
	GENERIC MAP (
		DATA_WIDTH => DATA_WIDTH,
		WINDOW_SIZE	=> 3,
		ROW_BITS => 9,
		COL_BITS => 10,
		NO_OF_ROWS => 480,
		NO_OF_COLS => 640 )
	PORT MAP(
		 clk	   => clk, 
		 fsync_in => fsync_in, 
		 rsync_in => rsync_in, 
		 pdata_in  => pdata_in, 
		 fsync_out => fsynch_int, 
		 rsync_out => rsynch_int, 
		 pdata_out1 => pdata_int1, 
		 pdata_out2 => pdata_int2, 
		 pdata_out3 => pdata_int3, 
		 pdata_out4 => pdata_int4, 
		 pdata_out5 => pdata_int5, 
		 pdata_out6 => pdata_int6, 
		 pdata_out7 => pdata_int7, 
		 pdata_out8 => pdata_int8, 
		 pdata_out9 => pdata_int9
		);
	
krnl: entity work.edge_sobel 
	GENERIC MAP ( DATA_WIDTH	=>  DATA_WIDTH)
	PORT MAP(
		pclk_i => clk,
		fsync_i => fsynch_int,
		rsync_i => rsynch_int,
		pData1 => pData_int1,
		pData2 => pData_int2,
		pData3 => pData_int3,
		pData4 => pData_int4,
		pData5 => pData_int5,
		pData6 => pData_int6,
		pData7 => pData_int7,
		pData8 => pData_int8,
		pData9 => pData_int9,
		fsync_o => fsync_out,
		rsync_o => rsync_out,
		pdata_o => pdata_out
	);

end Structural;

