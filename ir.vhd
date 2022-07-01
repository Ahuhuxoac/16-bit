

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use work.sys_definition.all;

-- 
entity ir is
   Generic (
    DATA_WIDTH : integer   := 16    -- Data Width
    );
   port (
     	  clk   : in STD_LOGIC;  
	  ir_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	  irld  : in std_logic;
	  ir_out: out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0)
        );
end ir;


 architecture struc of ir is
 begin
	process (clk)
	begin
		if clk'event and clk = '1' then
			if (irld <= '1') then 
				ir_out <= ir_in;
			else 
				ir_out <= (others => '0');
			end if;
		end if;
	end process;


							

end struc;