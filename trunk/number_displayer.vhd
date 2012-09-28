-- Alessandro Montanari 880606-Y555

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Number_Displayer is
	generic (
			DATA_WIDTH	: integer := 8;
			COL_BITS	   : integer := 10 );
	port(
		  clk : in  STD_LOGIC;
		  fsync_in : in  STD_LOGIC;
		  rsync_in : in  STD_LOGIC;
		  data_in : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
		  pos_row : in STD_LOGIC_VECTOR(COL_BITS-1 downto 0);
		  pos_col : in STD_LOGIC_VECTOR(COL_BITS-1 downto 0);
		  meters : in STD_LOGIC_VECTOR(3 downto 0);
		  decimeters : in STD_LOGIC_VECTOR(3 downto 0);
		  centimeters : in STD_LOGIC_VECTOR(3 downto 0);
		  fsync_out : out  STD_LOGIC;
		  rsync_out : out  STD_LOGIC;
		  data_out : out  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) );		  
	end Number_Displayer;

architecture Behavioral of Number_Displayer is

	constant NUMBERS_DIM : integer := 8;

	component Counter is
		 generic(n : POSITIVE := 10);
		 port ( clk : in  STD_LOGIC;
				  en : in  STD_LOGIC;
				  reset : in  STD_LOGIC;			-- Active Low
				  output : out  STD_LOGIC_VECTOR(COL_BITS-1 downto 0) );
	end component;

	component Num_Rom is
	port(
			en : in STD_LOGIC;
			address : in STD_LOGIC_VECTOR(6 downto 0);
			rd : in STD_LOGIC;
			data_out : out STD_LOGIC_VECTOR(0 to NUMBERS_DIM-1) );
	end component;


	signal RowsCounterOut,ColsCounterOut : STD_LOGIC_VECTOR(COL_BITS-1 downto 0) := (others => '0');
	signal FontDataOut : STD_LOGIC_VECTOR(0 to NUMBERS_DIM-1);
	signal FontAddress : STD_LOGIC_VECTOR(6 downto 0);

begin
	RowsCounter : Counter port map(rsync_in, fsync_in,fsync_in,RowsCounterOut);
	ColsCounter : Counter port map(clk, rsync_in,rsync_in,ColsCounterOut);
	LUTFont : Num_Rom port map('1',FontAddress,'1',FontDataOut);
	
	fsync_out <= fsync_in;
	rsync_out <= rsync_in;
	
	process(RowsCounterOut,ColsCounterOut,pos_row,pos_col,meters,decimeters,centimeters, data_in)
		variable rowLUT : STD_LOGIC_VECTOR(COL_BITS-1 downto 0);
		variable colLUT : STD_LOGIC_VECTOR(COL_BITS-1 downto 0);
	begin			
		-- First Number
		if(RowsCounterOut >= pos_row and RowsCounterOut <= (pos_row+7) and ColsCounterOut >= (pos_col-1) and ColsCounterOut <= (pos_col+7-1)) then  
			rowLUT := (RowsCounterOut - pos_row);
			colLUT := (ColsCounterOut - (pos_col-1));
			FontAddress <= (meters & rowLUT(2 downto 0));
			data_out <= (others => FontDataOut(conv_integer(colLUT(2 downto 0))));
		
		-- Decimal Point
		elsif(RowsCounterOut >= pos_row and RowsCounterOut <= (pos_row+7) and ColsCounterOut >= (pos_col+8-1) and ColsCounterOut <= (pos_col+15-1)) then  
			rowLUT := (RowsCounterOut - pos_row);
			colLUT := (ColsCounterOut - (pos_col+8-1));
			FontAddress <= ("1111" & rowLUT(2 downto 0));
			data_out <= (others => FontDataOut(conv_integer(colLUT(2 downto 0))));
		
		-- Second Number
		elsif(RowsCounterOut >= pos_row and RowsCounterOut <= (pos_row+7) and ColsCounterOut >= (pos_col+16-1) and ColsCounterOut <= (pos_col+23-1)) then   
			rowLUT := (RowsCounterOut - pos_row);
			colLUT := (ColsCounterOut - (pos_col+16-1));
			FontAddress <= (decimeters & rowLUT(2 downto 0));
			data_out <= (others => FontDataOut(conv_integer(colLUT(2 downto 0))));
		
		-- Third Number 
		elsif(RowsCounterOut >= pos_row and RowsCounterOut <= (pos_row+7) and ColsCounterOut >= (pos_col+24-1) and ColsCounterOut <= (pos_col+31-1)) then 
			rowLUT := (RowsCounterOut - pos_row);
			colLUT := (ColsCounterOut - (pos_col+24-1));
			FontAddress <= (centimeters & rowLUT(2 downto 0));
			data_out <= (others => FontDataOut(conv_integer(colLUT(2 downto 0))));
		
		-- Original Image
		else
			FontAddress <= (others => '0'); -- Only to not make infer a latch
			data_out <= data_in;
		end if;
	end process;
end Behavioral;

