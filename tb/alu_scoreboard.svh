class alu_scoreboard;
  alu_transaction tr;
  mailbox#(alu_transaction) mb;
  virtual alu_ifc vif;
  event next;
  logic[7:0] exp_alu_out;
  logic exp_alu_irq;
  function new(mailbox#(alu_transaction) mb);
    this.mb=mb;
  endfunction:new
  task run();
    forever begin
      mb.get(tr);
      tr.display_alu("alu_scoreboard");
      if(!tr.rst_n)begin
        exp_alu_irq=1'b0;
        exp_alu_out=8'b0;
      end
      else begin
        if( tr.alu_irq_clr) begin
          exp_alu_irq=1'b0;
        end
    if(tr.alu_enable)begin
      if((tr.alu_enable_a==1'b1) && (tr.alu_enable_b==1'b0))begin
          case(tr.alu_op_a)
             2'b00:begin
               exp_alu_out=tr.alu_in_a & tr.alu_in_b;
               if(exp_alu_out==8'hff)
                 exp_alu_irq=1'b1;
               if(exp_alu_out==8'hff && tr.alu_irq_clr )
                exp_alu_irq=1'b1;
          
             end
            2'b01:begin
               exp_alu_out=~(tr.alu_in_a & tr.alu_in_b);
               if(exp_alu_out==8'h00)
                 exp_alu_irq=1'b1;
              if(exp_alu_out==8'h00 && tr.alu_irq_clr )
                exp_alu_irq=1'b1;
    
             end
            2'b10:begin
              exp_alu_out=tr.alu_in_a | tr.alu_in_b;
              if(exp_alu_out==8'hf8)
                exp_alu_irq=1'b1;
              if(exp_alu_out==8'hf8 && tr.alu_irq_clr )
                exp_alu_irq=1'b1;
             
             end
            2'b11:begin
              exp_alu_out=tr.alu_in_a ^ tr.alu_in_b;
              if(exp_alu_out==8'h83)
                exp_alu_irq=1'b1;
              if(exp_alu_out==8'h83 && tr.alu_irq_clr )
                exp_alu_irq=1'b1;
     
             end
          endcase
      end
      else if((tr.alu_enable_a==1'b0) && (tr.alu_enable_b==1'b1))begin
         case(tr.alu_op_b)
          2'b00:begin
            exp_alu_out=~(tr.alu_in_a ^ tr.alu_in_b);
            if(exp_alu_out==8'hf1)
              exp_alu_irq=1'b1;
            if(exp_alu_out==8'hf1 && tr.alu_irq_clr )
                exp_alu_irq=1'b1;
           
          end
          2'b01:begin
            exp_alu_out=(tr.alu_in_a & tr.alu_in_b);
            if(exp_alu_out==8'hf4)
              exp_alu_irq=1'b1;
            if(exp_alu_out==8'hf4 && tr.alu_irq_clr )
                exp_alu_irq=1'b1;
           
          end
          2'b10:begin
            exp_alu_out=~(tr.alu_in_a | tr.alu_in_b);
            if(exp_alu_out==8'hf5)
              exp_alu_irq=1'b1;
            if(exp_alu_out==8'hf5 && tr.alu_irq_clr )
                exp_alu_irq=1'b1;
            
           end
         2'b11:begin
            exp_alu_out=tr.alu_in_a | tr.alu_in_b;
           if(exp_alu_out==8'hff)
              exp_alu_irq=1'b1;
           if(exp_alu_out==8'hff && tr.alu_irq_clr )
                exp_alu_irq=1'b1;
    
          end
        endcase
     end
      else
        exp_alu_out=exp_alu_out;
    end 
     else
        exp_alu_out=exp_alu_out;
    end
      assert(exp_alu_out==tr.alu_out) 
  $display("****************CORRECT:exp_alu_out=%0x,alu_out=%0x ****************",exp_alu_out,tr.alu_out);
  else $error("****************FAILED:exp_alu_out=%0x,alu_out=%0x ****************",exp_alu_out,tr.alu_out);
      assert(exp_alu_irq==tr.alu_irq) $display("****************CORRECT:exp_alu_irq=%0b,alu_irq=%0b   **************** ",exp_alu_irq,tr.alu_irq);
      else $error("****************FAILED:exp_alu_irq=%0b,alu_irq=%0b   ****************",exp_alu_irq,tr.alu_irq);
    end
  endtask:run
endclass:alu_scoreboard

