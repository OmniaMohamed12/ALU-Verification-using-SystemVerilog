class alu_environment;
  
  virtual alu_ifc ifc;
  event next;
  alu_generator gen;
  mailbox#(alu_transaction) mb2drv;
  mailbox#(alu_transaction) mb2scb;
  mailbox#(alu_transaction) mb2cov;
  alu_driver drv;
  alu_monitor mon;
  alu_scoreboard scb;
  alu_coverage cov;
  
  function new(virtual alu_ifc ifc);
    this.ifc=ifc;
    mb2drv=new();
    gen=new(mb2drv);
    drv=new(ifc,mb2drv);
    mb2scb=new();
    mb2cov=new();
    mon=new(ifc,mb2scb,mb2cov);
    scb=new(mb2scb);
    cov=new(mb2cov);
    gen.vif=this.ifc;
    scb.vif=this.ifc;
    cov.vif=this.ifc;
    gen.next_tr=next;
    drv.next_tr=next;
    mon.next_tr=next;
  endfunction:new
  task pre_test;
  	drv.reset();
  endtask
  task test;
    fork 
      
       gen.run();
       drv.run();
       mon.run();
      scb.run();
      cov.run();
    join_any
  endtask
  task post_test;
    wait(gen.finsh_tr==1'b1);
    $stop;
  endtask
  task run;
    test();
    post_test();
  endtask
  
endclass
