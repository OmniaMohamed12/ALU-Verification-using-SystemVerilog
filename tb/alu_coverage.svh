class alu_coverage;

	alu_transaction tr;
	mailbox#(alu_transaction) mb2cov;
    virtual alu_ifc vif;
    event next;
    
covergroup cg;
	opa: coverpoint tr.alu_op_a;
 	en_a: coverpoint tr.alu_enable_a;
	cross opa,en_a;
    opb: coverpoint tr.alu_op_b;
    en_b: coverpoint tr.alu_enable_b;
    cross opb,en_b;
    ina:coverpoint tr.alu_in_a;
    inb:coverpoint tr.alu_in_b;
    irq:coverpoint tr.alu_irq;
    clr:coverpoint tr.alu_irq_clr;
    rst:coverpoint tr.rst_n;
    out:coverpoint tr.alu_out;
endgroup
  function new(mailbox#(alu_transaction) mb2cov);
    this.mb2cov=mb2cov;
    cg=new();
  endfunction:new
  task run();
    forever begin
      mb2cov.get(tr);
      tr.display_alu("alu_coverage");
      cg.sample();
      $display("                               ********************************                ");
    end
  endtask:run
endclass:alu_coverage
