class alu_monitor;
  alu_transaction tr;
  mailbox#(alu_transaction) mb2scb;
  mailbox#(alu_transaction) mb2cov;
  virtual alu_ifc vif;
  event next_tr;
  function new(virtual alu_ifc vif,mailbox#(alu_transaction) mb2scb,mailbox#(alu_transaction) mb2cov);
    this.vif=vif;
    this.mb2scb=mb2scb;
    this.mb2cov=mb2cov;
    tr=new();
  endfunction:new
  task run();
    forever begin
       @(posedge vif.alu_clk);
       @(posedge vif.alu_clk);
       #1ns;
      tr.rst_n=vif.rst_n;
      tr.alu_irq_clr=vif.alu_irq_clr ;
      tr.alu_enable=vif.alu_enable;
      tr.alu_enable_a=vif.alu_enable_a;
      tr.alu_enable_b=vif.alu_enable_b ;
      tr.alu_op_a=vif.alu_op_a;
      tr.alu_op_b=vif.alu_op_b;
      tr.alu_in_a=vif.alu_in_a;
      tr.alu_in_b=vif.alu_in_b;
      tr.alu_out=vif.alu_out;
      tr.alu_irq=vif.alu_irq;
      mb2scb.put(tr);
      mb2cov.put(tr);
      tr.display_alu("alu_monitor");
     ->next_tr;
      
    end
  endtask:run
endclass:alu_monitor
