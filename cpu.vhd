
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

-- 
entity cpu is   
Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
port (
	rst,clk : in std_logic;
	start : in std_logic;
	data_out : in std_logic_vector(DATA_WIDTH -1 downto 0) ;
	data_in : out std_logic_vector(DATA_WIDTH -1 downto 0);
	address : out std_logic_vector(DATA_WIDTH -1 downto 0);
	mre,mwe : out STD_LOGIC
);
end cpu;


architecture struc of cpu is
signal aluz,rfwe,opr1e,opr2e : STD_LOGIC;
signal rfwa,opr1a,opr2a: STD_LOGIC_VECTOR (3 downto 0);
signal ir_out_8 : STD_LOGIC_VECTOR (15 downto 0);
signal rfs,alus : STD_LOGIC_VECTOR (1 downto 0);
signal opr2 : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

begin
cctr_unit : control_unit
   Generic map(
    DATA_WIDTH,
    ADDR_WIDTH
    )
   port map ( 
    	start,
        clk , rst,
	data_out,
	aluz,
	Address,
	rfwa,opr1a,opr2a,
	rfwe,opr1e,opr2e,
	ir_out_8,
	rfs,
	mre,mwe,
	alus,
	opr2
        );
datapath1 : datapath
Generic map (
    DATA_WIDTH,
    ADDR_WIDTH
    )
port map (
          rst,
          clk,
	  ir_out_8,
	  Data_out,
          data_in,
	  rfs,
	  rfwa,
	  opr1a,
	  opr2a,
	  rfwe, opr1e, opr2e,
	  alus,
	  aluz

        );	




end struc;




