module alu(
  input logic alu_clk,rst_n,alu_irq_clr,alu_enable,alu_enable_a,alu_enable_b,
  input logic[1:0] alu_op_a,input logic[1:0] alu_op_b,
  input logic[7:0] alu_in_a,input logic[7:0] alu_in_b,
  output logic[7:0] alu_out,output logic alu_irq);
  always@(posedge alu_clk or negedge rst_n)begin
    if(!rst_n)begin
      alu_irq<=1'b0;
      alu_out<=8'b0;
    end
    else begin
	if( alu_irq_clr)begin
      alu_irq<=1'b0;
    end
    if(alu_enable)begin
      if(alu_enable_a)begin
        case(alu_op_a)
          2'b00:begin
            assert (alu_in_b != 8'h00) else $error("illegal input alu_in_b != 8'h00");
            alu_out=alu_in_a & alu_in_b;
            if(alu_out==8'hff)
              alu_irq<=1'b1;
            if(alu_out==8'hff && alu_irq_clr==1'b1)
              alu_irq<=1'b1;
           
          end
          2'b01:begin
            assert (alu_in_a != 8'hff ) else $error("illegal input alu_in_a = 8'hff ");
            assert (alu_in_b != 8'h03 ) else $error("illegal input alu_in_a = 8'hff ");
            alu_out=~(alu_in_a & alu_in_b);
            if(alu_out==8'h00)
              alu_irq<=1'b1;
            if(alu_out==8'h00 && alu_irq_clr==1'b1)
              alu_irq<=1'b1;
          end
          2'b10:begin
            alu_out=alu_in_a | alu_in_b;
            if(alu_out==8'hf8)
              alu_irq<=1'b1;
            if(alu_out==8'hf8 && alu_irq_clr==1'b1)
              alu_irq<=1'b1;
          end
          2'b11:begin
            alu_out=alu_in_a ^ alu_in_b;
            if(alu_out==8'h83)
              alu_irq<=1'b1;
            if(alu_out==8'h83 && alu_irq_clr==1'b1)
              alu_irq<=1'b1;
          end
        endcase
      end
       else if(alu_enable_b)begin
         case(alu_op_b)
          2'b00:begin
            alu_out=~(alu_in_a ^ alu_in_b);
            if(alu_out==8'hf1)
              alu_irq<=1'b1;
            if(alu_out==8'hf1 && alu_irq_clr==1'b1)
              alu_irq<=1'b1;
          end
          2'b01:begin
            assert (alu_in_b != 8'h03 ) else $error("illegal input alu_in_b = 8'h03 ");
            alu_out=(alu_in_a & alu_in_b);
            if(alu_out==8'hf4)
              alu_irq<=1'b1;
            if(alu_out==8'hf4 && alu_irq_clr==1'b1)
              alu_irq<=1'b1;
          end
          2'b10:begin
            assert (alu_in_a != 8'hf5 ) else $error("illegal input alu_in_a = 8'hf5 ");
            alu_out=~(alu_in_a | alu_in_b);
            if(alu_out==8'hf5)
              alu_irq<=1'b1;
            if(alu_out==8'hf5 && alu_irq_clr==1'b1)
              alu_irq<=1'b1;
          end
          2'b11:begin
            alu_out=alu_in_a | alu_in_b;
            if(alu_out==8'hff)
              alu_irq<=1'b1;
            if(alu_out==8'hff && alu_irq_clr==1'b1)
              alu_irq<=1'b1;
          end
        endcase
       end
    end
    end
  end       
endmodule
