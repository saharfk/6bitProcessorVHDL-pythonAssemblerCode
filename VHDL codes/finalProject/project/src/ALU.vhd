library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ALU is 
	PORT( IN1, IN2 : in std_logic_vector(5 downto 0);
		  Result : out std_logic_vector(5 downto 0);
		  CMD : in std_logic);
end ALU;

architecture ALU of ALU is
begin

	process( CMD, IN1, IN2) 
begin
	if( CMD = '0')then Result <= (IN1 - IN2);
	else Result <= (IN1 + IN2);
	end if;
end process;

end ALU;
