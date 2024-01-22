interface alu_ifc;
  logic alu_clk; 
  logic rst_n;
  logic alu_irq_clr,alu_enable,alu_enable_a,alu_enable_b;
  logic[1:0] alu_op_a;
  logic[1:0] alu_op_b;
  logic[7:0] alu_in_a;
  logic[7:0] alu_in_b;
  logic[7:0] alu_out;
  logic alu_irq;
endinterface
