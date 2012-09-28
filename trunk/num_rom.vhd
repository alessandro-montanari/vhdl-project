-- Alessandro Montanari 880606-Y555

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Num_Rom is
port(
		en : in STD_LOGIC;
		address : in STD_LOGIC_VECTOR(6 downto 0);
		rd : in STD_LOGIC;
		data_out : out STD_LOGIC_VECTOR(0 to 7)
);
end Num_Rom;

architecture Behavioral of Num_Rom is

begin

	process(en,rd,address)
	begin
			if(en = '1' and rd = '1') then
				case address is
					-- 0
					when "0000000" => data_out <= "00111110";
					when "0000001" => data_out <= "01100011";
					when "0000010" => data_out <= "01100011";
					when "0000011" => data_out <= "01101011";
					when "0000100" => data_out <= "01101011";
					when "0000101" => data_out <= "01100011";
					when "0000110" => data_out <= "01100011";
					when "0000111" => data_out <= "00111110";
					
					-- 1
					when "0001000" => data_out <= "00001100";
					when "0001001" => data_out <= "00111100";
					when "0001010" => data_out <= "00001100";
					when "0001011" => data_out <= "00001100";
					when "0001100" => data_out <= "00001100";
					when "0001101" => data_out <= "00001100";
					when "0001110" => data_out <= "00001100";
					when "0001111" => data_out <= "00111111";
					
					-- 2
					when "0010000" => data_out <= "00111110";
					when "0010001" => data_out <= "01100011";
					when "0010010" => data_out <= "01100011";
					when "0010011" => data_out <= "00000110";
					when "0010100" => data_out <= "00001100";
					when "0010101" => data_out <= "00011000";
					when "0010110" => data_out <= "00110011";
					when "0010111" => data_out <= "01111111";
					
					-- 3
					when "0011000" => data_out <= "00111110";
					when "0011001" => data_out <= "01100011";
					when "0011010" => data_out <= "00000011";
					when "0011011" => data_out <= "00001110";
					when "0011100" => data_out <= "00001110";
					when "0011101" => data_out <= "00000011";
					when "0011110" => data_out <= "01100011";
					when "0011111" => data_out <= "00111110";
					
					-- 4
					when "0100000" => data_out <= "00000110";
					when "0100001" => data_out <= "00001110";
					when "0100010" => data_out <= "00011110";
					when "0100011" => data_out <= "00110110";
					when "0100100" => data_out <= "01100110";
					when "0100101" => data_out <= "01111111";
					when "0100110" => data_out <= "00000110";
					when "0100111" => data_out <= "00000110";
					
					-- 5
					when "0101000" => data_out <= "01111111";
					when "0101001" => data_out <= "01100000";
					when "0101010" => data_out <= "01100000";
					when "0101011" => data_out <= "01111110";
					when "0101100" => data_out <= "00000011";
					when "0101101" => data_out <= "00000011";
					when "0101110" => data_out <= "01100011";
					when "0101111" => data_out <= "00111110";
					
					-- 6
					when "0110000" => data_out <= "00111110";
					when "0110001" => data_out <= "01100011";
					when "0110010" => data_out <= "01100000";
					when "0110011" => data_out <= "01111110";
					when "0110100" => data_out <= "01100011";
					when "0110101" => data_out <= "01100011";
					when "0110110" => data_out <= "01100011";
					when "0110111" => data_out <= "00111110";
					 
					-- 7
					when "0111000" => data_out <= "01111111";
					when "0111001" => data_out <= "01100011";
					when "0111010" => data_out <= "00000110";
					when "0111011" => data_out <= "00001100";
					when "0111100" => data_out <= "00011000";
					when "0111101" => data_out <= "00011000";
					when "0111110" => data_out <= "00011000";
					when "0111111" => data_out <= "00011000";
        
					-- 8
					when "1000000" => data_out <= "00111110";
					when "1000001" => data_out <= "01100011";
					when "1000010" => data_out <= "01100011";
					when "1000011" => data_out <= "01100011";
					when "1000100" => data_out <= "00111110";
					when "1000101" => data_out <= "01100011";
					when "1000110" => data_out <= "01100011";
					when "1000111" => data_out <= "00111110";
        
					-- 9
					when "1001000" => data_out <= "00111110";
					when "1001001" => data_out <= "01100011";
					when "1001010" => data_out <= "01100011";
					when "1001011" => data_out <= "01100011";
					when "1001100" => data_out <= "00111111";
					when "1001101" => data_out <= "00000011";
					when "1001110" => data_out <= "01100011";
					when "1001111" => data_out <= "00111110";
					
					-- .
					when "1111000" => data_out <= "00000000";
					when "1111001" => data_out <= "00000000";
					when "1111010" => data_out <= "00000000";
					when "1111011" => data_out <= "00000000";
					when "1111100" => data_out <= "00000000";
					when "1111101" => data_out <= "00000000";
					when "1111110" => data_out <= "00011000";
					when "1111111" => data_out <= "00011000";
					
					when others => data_out <= "00000000";
				
				end case;
			else
				data_out <= (others => 'Z');
			end if;
	end process;
end Behavioral;

