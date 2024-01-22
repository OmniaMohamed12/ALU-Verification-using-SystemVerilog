class alu_driver;
  alu_transaction tr;
  mailbox#(alu_transaction) mb;
  virtual alu_ifc vif;
  event next_tr;
  function new(virtual alu_ifc vif,mailbox#(alu_transaction) mb);
    this.vif=vif;
    this.mb=mb;
  endfunction:new
  task reset();
     @(posedge vif.alu_clk);
     vif.alu_irq_clr <= 0;
      vif.alu_enable <= 0;
      vif.alu_enable_a <= 0;
      vif.alu_enable_b <= 0;
      vif.alu_op_a <= 2'b00;
      vif.alu_op_b <= 2'b00;
      vif.alu_in_a <= 8'h00;
      vif.alu_in_b <= 8'h00;
      vif.rst_n <= 1'b0;
     $display("alu_driver:reset phase");
    @(posedge vif.alu_clk);
    $display("%0t %0s ,rst_n=%0b,alu_irq_clr=%0b,alu_enable=%0b,alu_enable_a=%0b,alu_enable_b=%0b,alu_op_a=%0b,alu_op_b=%0b,alu_in_a=%0x,alu_in_b=%0x,alu_out=%0x,alu_irq=%0b",$time,"alu_driver",vif.rst_n,vif.alu_irq_clr,vif.alu_enable,vif.alu_enable_a,vif.alu_enable_b,vif.alu_op_a,vif.alu_op_b,vif.alu_in_a,vif.alu_in_b,vif.alu_out,vif.alu_irq);
  endtask:reset
  task run();
       reset();
    forever begin
      @(posedge vif.alu_clk);
      mb.get(tr);
      tr.display_alu("alu_driver");
      vif.rst_n<=tr.rst_n;
      vif.alu_irq_clr <= tr.alu_irq_clr;
      vif.alu_enable <= tr.alu_enable;
      vif.alu_enable_a <= tr.alu_enable_a;
      vif.alu_enable_b <= tr.alu_enable_b;
      vif.alu_op_a <= tr.alu_op_a;
      vif.alu_op_b <= tr.alu_op_b;
      vif.alu_in_a <= tr.alu_in_a;
      vif.alu_in_b <= tr.alu_in_b;
     ->next_tr;
    end
  endtask:run
endclass:alu_driver
