library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.all ;
--use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.Sys_Definition.all;

ENTITY mux31 IS
   GENERIC ( 
	DATA_WIDTH : integer := 16);
   	PORT (
	A,B, C: IN  std_logic_vector (DATA_WIDTH-1 downto 0);
        SEL : IN std_logic_vector (1 downto 0);
        Z: OUT std_logic_vector (DATA_WIDTH-1 downto 0)
          );
END mux31;
ARCHITECTURE bev OF mux31 IS

begin
process (a,b,c,sel) is
BEGIN
     	if (sel = "00" ) then
      		Z <= A;
  	elsif (sel = "01") then
      		z <= B;
  	else
      		Z <= C;
  	end if;
 	
end process;

END bev;