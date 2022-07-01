-- Nguyen Kiem Hung
-- cpu : the top level entity

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

-- 
entity control_unit is
   Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( 
    	start : in STD_LOGIC;    -- high active Start: enable cpu
        clk , rst  : in STD_LOGIC;    -- Clock
	data_out : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
	aluz : in STD_LOGIC;
	Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
	rfwa,opr1a,opr2a : out STD_LOGIC_VECTOR (3 downto 0);
	rfwe,opr1e,opr2e : out STD_LOGIC; 
	ir_out_8 : out STD_LOGIC_VECTOR (15 downto 0);
	rfs : out STD_LOGIC_VECTOR ( 1  downto 0);
	mre,mwe : out std_logic;
	alus : out STD_LOGIC_VECTOR (1 downto 0);
	opr2 : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0)
        );
end control_unit;


architecture struc of control_unit is
signal pcclr,pcinc,pcld : STD_LOGIC;
signal pc_out : STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
signal irclr : STD_LOGIC;
signal 	ir_out : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
signal 	ms : STD_LOGIC_VECTOR (  1 downto 0);
signal irld : STD_LOGIC;
signal addrout : STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
signal ir_out_8b : STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
begin

ir_out_8b <= "00000000" & ir_out(7 DOWNTO 0);
ir_out_8 <= ir_out_8b;

ir1 : ir
   Generic map (DATA_WIDTH )
   port map (
     	  clk,
	  data_out,
	  irld,
	  ir_out
        );

pc1 : pc
Generic map (DATA_WIDTH)
   port map (
     	  clk,
	  ir_out_8b,
	  pcclr,
	  pcinc,
	  pcld,
	  pc_out
        );

controller1 : controller
Generic map  (DATA_WIDTH)
port map (
	 rst,
    	 start,
         clk,
	 IR_out,
     	 ALUz,
	 alus,ms,
     	 RFs,
     	 Mre, Mwe,
     	 opr1a,opr2a,rfwa,
	 opr1e,opr2e,rfwe,
         pcclr,pcinc,pcld,irld
        );
mux3to11 : mux31
GENERIC map ( 
	DATA_WIDTH)
PORT map 
	(
	opr2,ir_out_8b,pc_out,
	ms,
	addrout
          );
addr_out <= addrout;
end struc;



