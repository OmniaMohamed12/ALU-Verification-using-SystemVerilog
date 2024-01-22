class alu_transaction;
  rand bit alu_irq_clr;
   bit rst_n=1'b1;
  rand bit alu_enable;
  rand bit alu_enable_a;
  rand bit alu_enable_b;
  rand bit[1:0] alu_op_a;
  rand bit[1:0] alu_op_b;
  rand bit[7:0] alu_in_a;
  rand bit[7:0] alu_in_b;
  logic[7:0] alu_out;
  logic alu_irq;

  constraint clr_c{
    alu_irq_clr dist{0:/20,1:/70};    
  }
 constraint alu_enable_c{
    alu_enable dist{0:/20,1:/90};
  }
  constraint alu_enable_ab_c{
    alu_enable_a != alu_enable_b;
    alu_enable_a dist{0:/60,1:/50};
    alu_enable_b dist{0:/60,1:/70};
  }
  constraint alu_op_ab_c{
    alu_op_a dist{0:/50,1:/50,2:/50,3:/50};
    alu_op_b dist{0:/50,1:/50,2:/50,3:/50};
  }
  constraint illegal_opa_c{
    if(alu_enable==1'b1 && alu_enable_b==1'b0 && alu_enable_a==1'b1 ){
    if(alu_op_a==2'b00)
      alu_in_b != 8'h00;
    if(alu_op_a==2'b01){
      alu_in_a != 8'hff;
      alu_in_b != 8'h03;
    }
    }}
    
  constraint illegal_opb_c{
    if(alu_enable==1'b1 && alu_enable_b==1'b1 && alu_enable_a==1'b0 ){
       if(alu_op_b==2'b01){
          alu_in_b != 8'h03;
       }
       if(alu_op_b==2'b10){
          alu_in_a != 8'hf5;
    }
         }}
     constraint enable_irq_c1 {
           if(alu_enable==1'b1 && alu_enable_a==1'b1 && alu_enable_b==1'b0  && alu_op_a == 2'b10 ){
             alu_in_a ==8'ha8; alu_in_b==8'h50 ;}}
    constraint enable_irq_c2 {
      if(alu_enable==1'b1 && alu_enable_a==1'b1 && alu_enable_b==1'b0  && alu_op_a == 2'b00 ){
        alu_in_a==8'hff; alu_in_b == 8'hff;
        }}
    constraint enable_irq_c3 {
      if(alu_enable==1'b1 && alu_enable_a==1'b1 && alu_enable_b==1'b0  && alu_op_a == 2'b11 ){
         alu_in_a==8'h73 ; alu_in_b==8'hf0;}}
     constraint enable_irq_c4 {
       if(alu_enable==1'b1 && alu_enable_a==1'b0 && alu_enable_b==1'b1  && alu_op_b == 2'b00 ){
         ~(alu_in_a ^ alu_in_b)==8'hf1;}}
   constraint enable_irq_c5 {
     if(alu_enable==1'b1 && alu_enable_a==1'b0 && alu_enable_b==1'b1  && alu_op_b == 2'b01 ){
       alu_in_a & alu_in_b==8'hf4;}}
   constraint enable_irq_c6 {
     if(alu_enable==1'b1 && alu_enable_a==1'b0 && alu_enable_b==1'b1  && alu_op_b == 2'b10 ){
       ~(alu_in_a | alu_in_b)==8'hf5;}}
   constraint enable_irq_c7 {
     if(alu_enable==1'b1 && alu_enable_a==1'b0 && alu_enable_b==1'b1  && alu_op_b == 2'b11 ){
         alu_in_a | alu_in_b==8'hff;}}
       
  
  function void display_alu (input string class_name);
       $display("%0t %0s ,rst_n=%0b,alu_irq_clr=%0b,alu_enable=%0b,alu_enable_a=%0b,alu_enable_b=%0b,alu_op_a=%0b,alu_op_b=%0b,alu_in_a=%0x,alu_in_b=%0x,alu_out=%0x,alu_irq=%0b",$time,class_name,rst_n,alu_irq_clr,alu_enable,alu_enable_a,alu_enable_b,alu_op_a,alu_op_b,alu_in_a,alu_in_b,alu_out,alu_irq);
       
  endfunction:display_alu
  function alu_transaction copy;
    copy=new();
    copy.alu_irq_clr=this.alu_irq_clr;
    copy.alu_enable=this.alu_enable;
    copy.alu_enable_a=this.alu_enable_a;
    copy.alu_enable_b=this.alu_enable_b;
    copy.alu_op_a=this.alu_op_a;
    copy.alu_op_b=this.alu_op_b;
    copy.alu_in_a=this.alu_in_a;
    copy.alu_in_b=this.alu_in_b;
    copy.alu_out=this.alu_out;
    copy.alu_irq=this.alu_irq;
  endfunction:copy
  
  
endclass:alu_transaction
