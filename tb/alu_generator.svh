class alu_generator;
  virtual alu_ifc vif;
  alu_transaction tr;
  mailbox#(alu_transaction) mb;
  event next_tr;
  int num_repetition;
  bit finsh_tr=1'b0;
  function new(mailbox#(alu_transaction) mb);
    this.mb=mb;
    tr=new();
  endfunction:new
  task run();
    repeat(num_repetition)begin
      @(posedge vif.alu_clk);
      assert(tr.randomize()) else $error("Randomization failed");
      mb.put(tr);
      tr.display_alu("alu_generator");
      @(posedge vif.alu_clk);
      @(next_tr);
    end
    finsh_tr=1'b1;
  endtask:run
endclass:alu_generator
