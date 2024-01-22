`include "timescale.sv"
`include "alu_ifc.sv"
`include "alu_transaction.svh"
`include "alu_generator.svh"
`include "alu_driver.svh"
`include "alu_monitor.svh"
`include "alu_scoreboard.svh"
`include "alu_coverage.svh"
`include "alu_environment.svh"
`include "alu.sv"
module tb;
  alu_ifc ifc();
  alu_environment env;
  initial begin
   ifc.alu_clk<=0;
    forever#10 ifc.alu_clk<=~ifc.alu_clk;
  end

 alu dut( ifc.alu_clk,ifc.rst_n,ifc.alu_irq_clr,ifc.alu_enable,ifc.alu_enable_a,ifc.alu_enable_b,  ifc.alu_op_a,ifc.alu_op_b,ifc.alu_in_a,ifc.alu_in_b,ifc.alu_out,ifc.alu_irq);

  initial begin
    env=new(ifc);
    env.gen.num_repetition=1500;
    env.run();
  end
 
 
 initial begin
    $dumpfile("test.vcd");
    $dumpvars;
  end
  `ifdef FSDB
  initial begin
    $fsdbDumpfile("textbench.fsdb");
    $fsdbDumpvars;
  end
  `endif
endmodule:tb
    
  
