library ieee;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity cpu_with_control_tb is
end cpu_with_control_tb;

architecture TB_ARCHITECTURE of cpu_with_control_tb is
	-- Component declaration of the tested unit
	component cpu_with_control
	port(
		CLOCK : in STD_LOGIC;
		RST : in STD_LOGIC;
		mem_content : out STD_LOGIC_VECTOR(5 downto 0);
		out0 : out STD_LOGIC_VECTOR(5 downto 0);
		out1 : out STD_LOGIC_VECTOR(5 downto 0);
		out2 : out STD_LOGIC_VECTOR(5 downto 0);
		out3 : out STD_LOGIC_VECTOR(5 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLOCK : STD_LOGIC;
	signal RST : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal mem_content : STD_LOGIC_VECTOR(5 downto 0);
	signal out0 : STD_LOGIC_VECTOR(5 downto 0);
	signal out1 : STD_LOGIC_VECTOR(5 downto 0);
	signal out2 : STD_LOGIC_VECTOR(5 downto 0);
	signal out3 : STD_LOGIC_VECTOR(5 downto 0);

	-- Add your code here ...
constant clk_period : time := 10 ns;
begin

	-- Unit Under Test port map
	UUT : cpu_with_control
		port map (
			CLOCK => CLOCK,
			RST => RST,
			mem_content => mem_content,
			out0 => out0,
			out1 => out1,
			out2 => out2,
			out3 => out3
		);

	clk_process :process
   begin
		clock <= '0';
		wait for clk_period/2;
		clock <= '1';
		wait for clk_period/2;
   end process;
  
   rSt <= '1','0' after 6ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_cpu_with_control of cpu_with_control_tb is
	for TB_ARCHITECTURE
		for UUT : cpu_with_control
			use entity work.cpu_with_control(cpu_with_control);
		end for;
	end for;
end TESTBENCH_FOR_cpu_with_control;

