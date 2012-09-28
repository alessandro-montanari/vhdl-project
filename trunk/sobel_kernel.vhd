-- Alessandro Montanari 880606-Y555

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity edge_sobel is
	 generic (
		DATA_WIDTH	: integer := 8 );
    port ( 
				pclk_i		: in std_logic;
				fsync_i		: in std_logic;
				rsync_i		: in std_logic;
				pData1 		: in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
				pData2 		: in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
				pData3 		: in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
				pData4 		: in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
				pData5 		: in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
				pData6 		: in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
				pData7 		: in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
				pData8 		: in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
				pData9 		: in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
				
				fsync_o		: out std_logic;
				rsync_o		: out std_logic;
				pdata_o		: out std_logic_vector(DATA_WIDTH-1 downto 0) );
			  
end entity edge_sobel;

architecture Behavioral of edge_sobel is
begin
	edge_sobel: process (pclk_i)
	
		variable summax, summay : std_logic_vector(10 downto 0);
		variable summa1, summa2 : std_logic_vector(10 downto 0);
		variable summa          : std_logic_vector(10 downto 0);
		
	begin  
		if (pclk_i'event and pclk_i = '1') then 
			
			rsync_o <= rsync_i;
			fsync_o <= fsync_i;
			
		if fsync_i = '1' then			
			if rsync_i = '1' then			
															-- x2
				summax:=("000" & pdata3)+("00" & pdata6 & '0')+("000" & pdata9)
					-("000" & pdata1)-("00" & pdata4 & '0')-("000" & pdata7);
															-- x2
				summay:=("000" & pdata7)+("00" & pdata8 & '0')+("000" & pdata9)
					-("000" & pdata1)-("00" & pdata2 & '0')-("000" & pdata3);
				
				-- Here is computed the absolute value of the numbers
				if summax(10)='1' then
					summa1:= not summax+1;
				else
					summa1:= summax;				
				end if;

				if summay(10)='1' then
					summa2:= not summay+1;
				else
					summa2:= summay;
				end if;
				
				summa:=summa1+summa2;
				
				-- Threshold = 127
				if summa>"00001111111" then			
					pdata_o<=(others => '1');
				else 
					pdata_o<=summa(DATA_WIDTH-	1 downto 0);
				end if;
				
			END IF;
		end if;
		end if;  -- pclk_i
	end process edge_sobel;
end Behavioral;