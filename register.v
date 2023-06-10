`timescale 1ns / 1ps

module Veda (input clk, input [31:0] instruction, input write_enable, input instruction_check, input [31:0] data_write,  output [31:0] ReadData1, output [31:0] ReadData2);  
// instruction from the instruction memory
wire[4:0] addr1,addr2, addr3;
reg [31:0] Register_Data[31:0];  // 32*32 register made 

  // initialize the register data to 0 
  integer i;
  initial begin
    for (i = 0; i < 32; i = i + 1) begin
      Register_Data[i] = 32'b0;
    end
  end
  // saving the address of the register to be read
  assign addr1 = instruction[25:21];
  assign addr2 = instruction[20:16];
  assign addr3 = instruction[15:11];
  assign ReadData1 = Register_Data[addr1];
  assign ReadData2 = Register_Data[addr2];

  always @(posedge clk) begin  
    case (write_enable)
        1'b1: begin
            case (instruction_check)
            1'b0: begin
                Register_Data[addr3] = data_write; // if instruction_check is 0, write to rd as it is for function with constant
            end
            1'b1: begin
                Register_Data[addr2] = data_write;  //if instruction_check is 1, write to rt which is for operations on value in given register
            end
            endcase
        end
    endcase 
  end

endmodule
