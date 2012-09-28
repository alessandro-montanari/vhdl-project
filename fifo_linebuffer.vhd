-- Alessandro Montanari 880606-Y555

PACKAGE TYPES IS 
	subtype SMALL_INTEGER is INTEGER range 0 to 639;
END PACKAGE;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use WORK.TYPES.all;

entity FIFOLineBuffer is
	generic (
		DATA_WIDTH	: integer := 8;
		NO_OF_COLS	: integer := 640 );
	port(
		clk 		   : in std_logic;
		fsync   		: in std_logic;
		rsync			: in std_logic;
		pdata_in 	: in std_logic_vector(DATA_WIDTH -1 downto 0);
		pdata_out	: buffer std_logic_vector(DATA_WIDTH -1 downto 0) );
end FIFOLineBuffer;

architecture Behavioral of FIFOLineBuffer is

	type ram_type is array (NO_OF_COLS - 1 downto 0) of std_logic_vector(DATA_WIDTH -1 downto 0);
	signal ram_array	: ram_type; -- := (others => "00000000");
	signal clk2 : std_logic;
	signal ColsCounter : SMALL_INTEGER := 0;
	
begin
	clk2<=not clk;	
	
	--NB: putting the two IF about fsync and rsync inside the clk and clk2 IFs
	--		will lead to an automatic inference of a RAM
	
	-- reading from the memory
	p : process(clk)
	begin
		if clk'event and clk='1' then
			if fsync = '1' then
				if rsync = '1' then
					pdata_out <= ram_array(ColsCounter);
				end if;
			end if;
		end if; -- clk
	end process;
	
	-- writing into the memory
	p2 : process (clk2)
	begin
		if clk2'event and clk2='1' then
			if fsync = '1' then
				if rsync = '1' then
					ram_array(ColsCounter) <= pdata_in;

					if ColsCounter < 639 then
						ColsCounter	<= ColsCounter+1;
					else
						ColsCounter	<= 0;
					end if;
				else
					ColsCounter	<= 0;
				end if; -- rsync
			end if; -- fsync
		end if; -- clk2
	end process p2;

end Behavioral;

