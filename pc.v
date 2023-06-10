`timescale 1ns / 1ps

module Next_pc (input [31:0] pc,input [31:0] instruction, input Jump, input Branch, input Bne, input zero, output reg [31:0] next_pc, output reg [31:0] pc_out, input clk);

  reg [31:0] sign_ext,pc_new,jump;  
  reg zero_new;

  initial begin
    next_pc = 32'b0;
    pc_out = -4;
  end
  always @(posedge clk) begin
    pc_out = next_pc;
  end
  always @(pc) begin
    pc_new = pc + 4;
  end

  always @(zero, Bne) begin
    zero_new = zero;
    if (Bne == 1) begin
      zero_new = !zero_new;
    end
  end

  always @(instruction) begin
    jump = {4'b0, instruction[25:0], 2'b0};
  end

  always @(instruction) begin
    case (instruction[15])
      1'b0: begin
        sign_ext = {16'b0, instruction[15:0]};
      end
      default: begin
        sign_ext = {{16{1'b1}}, instruction[15:0]};
      end
    endcase
    sign_ext = {sign_ext[29:0], 2'b0};  
  end 

  always @(instruction or pc_new or jump) begin
    jump = {pc_new[31:28], jump[27:0]};
  end

  always @(pc_new, sign_ext, jump, Branch, zero_new, Jump) begin
    case({Branch, zero_new})
      2'b11: begin
        next_pc = pc_new + sign_ext;
      end
      default: begin
        next_pc = pc_new;
      end
    endcase
    if (Jump == 1) begin
      next_pc = jump;
    end
    
  end

endmodule