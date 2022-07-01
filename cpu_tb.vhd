
library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.sys_definition.all;
 
use std.textio.all;
 
entity cpu_tb is

end cpu_tb;

 
 
architecture behavior of cpu_tb is
constant clktime : time := 20ns;
constant  DATA_WIDTH : INteger := 16;
Constant addR_WIDTH : integer := 16;
signal data_out,data_in,address : std_logic_vector(15 downto 0) ;
signal clk: std_logic :='0';
signal rst: std_logic :='0';
signal start : STD_LOGIC;
signal mwe,mre : std_logic;
Begin
clk <= not clk after clktime/2;
 cpu1 :cpu
Generic map(
    DATA_WIDTH,
    ADDR_WIDTH
    )
port map (
	rst,clk,
	start,
	data_out,
	data_in,
	address,
	mre,mwe
);

  stm_sig : process
begin
	rst <= '0'; data_out <= (OTHERS => '0');
	wait for 20 ns;
	rst <= '1'; 
	wait for 10 ns;
	data_out <= X"0003";
	wait for 20 ns;

	wait;
end process stm_sig;

  
End behavior;