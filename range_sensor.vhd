-- Alessandro Montanari 880606-Y555

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity range_sensor is
	port (
		fpgaclk : in STD_LOGIC;
		triggerOut : out STD_LOGIC;
		pulse : in STD_LOGIC;
		meters : out STD_LOGIC_VECTOR(3 downto 0);
		decimeters : out STD_LOGIC_VECTOR(3 downto 0);
		centimeters : out STD_LOGIC_VECTOR(3 downto 0) );
end range_sensor;


architecture Behavioral of range_sensor is

	component distance_measurer is
		 Port ( clk : in  STD_LOGIC;
				  trigg : in STD_LOGIC;
				  pulse : in  STD_LOGIC;
				  distance : out  STD_LOGIC_VECTOR(8 downto 0) );
	end component;

	component trigger_generator is
	port(	clk : in STD_LOGIC;
			trigger : out STD_LOGIC );
	end component;

	component bcd_converter is
		 Port ( input : in  STD_LOGIC_VECTOR(8 downto 0);
				  hundreds : out  STD_LOGIC_VECTOR(3 downto 0);
				  tens : out  STD_LOGIC_VECTOR(3 downto 0);
				  unit : out  STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	signal distanceOut : STD_LOGIC_VECTOR(8 downto 0);
	signal triggOut : STD_LOGIC;

begin

		triggerOut <= triggOut;
		trigger_gen : trigger_generator port map(fpgaclk,triggOut);
		measurer : distance_measurer port map(fpgaclk,triggOut,pulse,distanceOut);
		BCDConv : bcd_converter port map(distanceOut,meters,decimeters,centimeters);

end Behavioral;

