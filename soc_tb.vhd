
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.Sys_Definition.all;

entity soc_tb is
end SoC_tb;

architecture behavior of SoC_tb is
signal rst, start, clk: STD_LOGIC;
begin
SoC_dut:  SoC  
    port map (    
        rst,
	start,
	clk
      );
CLKsig: process
begin
CLK <='1'; wait for 20 ns;
CLK <= '0'; wait for 20 ns;
end process;
--stimulus
Stimulus: process
begin
Start<= '1';
rst <= '1' ; wait for 20 ns;
rst <= '0' ; wait for 100 ns;
end process;
end behavior;
