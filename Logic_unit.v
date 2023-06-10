`timescale 1ns / 1ps


module Logic_Unit (input[31:0] input1,input[31:0] read2, input[31:0] instruction,input Src,output reg check,output reg [31:0] result, input [1:0] Operation,input [5:0] instructionN);

  reg [31:0] input2;
  reg [3:0] control;
  always @(Operation, instructionN) begin
    case (Operation)
      2'b00:   control = 4'b0010;  
      2'b01:   control = 4'b0110;  
      2'b10: begin  // R-Type
        case (instructionN)
          6'b100000:  // add
          control = 4'b0010;
          6'b100010:  // sub
          control = 4'b0110;
          6'b100100:  // and
          control = 4'b0000;
          6'b100101:  // or
          control = 4'b0001;
          6'b101010:  // slt
          control = 4'b0111;
          default: ;
        endcase
      end
      2'b11:   control = 4'b0000;
      default: ;
    endcase
  end
  always @(Src, read2, instruction) begin
    if (Src == 0) begin
      input2 = read2;
    end else begin
      case(instruction[15])
        1'b0: begin
          input2 = {16'b0, instruction[15:0]};
        end
        default: begin
          input2 = {{16{1'b1}}, instruction[15:0]};
        end
      endcase
    end
  end

  always @(input1, input2, control) begin
    case (control)
      4'b0000:  // AND
      result = input1 & input2;
      4'b0010:  // ADD
      result = input1 + input2;
      4'b0001:  // OR
      result = input1 | input2;
      4'b0110:  // SUB
      result = input1 - input2;
      4'b1100:  // NOR
      result = input1 | ~input2;
      4'b0111:  // SLT
      result = (input1 < input2) ? 1 : 0;
      4'b1000:  // SLL
      result = input1 << input2[4:0];
      4'b1001:  // SRL
      result = input1 >> input2[4:0];

      default: begin
        result = 32'b0;
      end

    endcase
    if (result == 0) begin
      check = 1;
    end else begin
      check = 0;
    end
  end

endmodule