library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity memory is
	   	PORT( Addr : in std_logic_vector( 5 downto 0);
		  Dout : out std_logic_vector( 5 downto 0);
		  CLOCK : in std_logic);
end memory;



architecture memory of memory is
TYPE Memory is array ( 63 downto 0) of std_logic_vector(5 downto 0);
Signal msignal : Memory;
begin
msignal(0) <= "000000" ;
msignal(1) <= "000101" ;
msignal(2) <= "000100" ;
msignal(3) <= "000011" ;
msignal(4) <= "010001" ;
msignal(5) <= "111111" ;	
--msignal(0)<="000000";
--msignal(1)<="000000";
--msignal(2)<="000100";
--msignal(3)<="000111";
--msignal(4)<="001000";
--msignal(5)<="000001";
--msignal(6)<="001100";
--msignal(7)<="001000";
--msignal(8)<="111100";
--msignal(9)<="001011";
--msignal(10)<="111111";
--msignal(11)<="101110";
--msignal(12)<="010001";
--msignal(13)<="111100";
--msignal(14)<="001001";
--msignal(15)<="111111";
Dout <= msignal( to_integer(unsigned(Addr)));
end memory;
