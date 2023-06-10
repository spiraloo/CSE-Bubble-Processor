`timescale 1ns / 1ps


module Data_memory (input clk,input [31:0] addr,input [31:0] writeData,input [31:0] Data_in,input MemWrite,input Reg_save,output reg [31:0] read_Data);

 
  reg [31:0] Data_mem[0:31];  // data memory


  initial begin
        Data_mem[0]= 32'b000000_00000_00000_00000_00000_000100;
        Data_mem[1]= 32'b000000_00000_00000_00000_00000_000011;
        Data_mem[2]= 32'b000000_00000_00000_00000_00000_001000;
        Data_mem[3]= 32'b000000_00000_00000_00000_00000_000110;
        Data_mem[4]= 32'b000000_00000_00000_00000_00000_000000;
        Data_mem[5]= 32'b000000_00000_00000_00000_00000_000010;
        Data_mem[6]= 32'b000000_00000_00000_00000_00000_000000;
        Data_mem[7]= 32'b000000_00000_00000_00000_00000_000000;
        Data_mem[8]= 32'b000000_00000_00000_00000_00000_000000;
        Data_mem[9]= 32'b000000_00000_00000_00000_00000_000000;
        Data_mem[10]=32'b000000_00000_00000_00000_00000_000000;
        Data_mem[11]=32'b000000_00000_00000_00000_00000_000000;
        Data_mem[12]=32'b000000_00000_00000_00000_00000_000000;
        Data_mem[13]=32'b000000_00000_00000_00000_00000_000000;
        Data_mem[14]=32'b000000_00000_00000_00000_00000_000000;
        Data_mem[15]=32'b000000_00000_00000_00000_00000_000000;
        Data_mem[16]= 32'b000000_00000_00000_00000_00000_000100;
        Data_mem[17]= 32'b000000_00000_00000_00000_00000_000011;
        Data_mem[18]= 32'b000000_00000_00000_00000_00000_001000;
        Data_mem[19]= 32'b000000_00000_00000_00000_00000_000110;
        Data_mem[20]= 32'b000000_00000_00000_00000_00000_000000;
        Data_mem[21]= 32'b000000_00000_00000_00000_00000_000010;
        Data_mem[22]= 32'b000000_00000_00000_00000_00000_000000;
        Data_mem[23]= 32'b000000_00000_00000_00000_00000_000000;
        Data_mem[24]= 32'b000000_00000_00000_00000_00000_000000;
        Data_mem[25]= 32'b000000_00000_00000_00000_00000_000000;
        Data_mem[26]=32'b000000_00000_00000_00000_00000_000000;
        Data_mem[27]=32'b000000_00000_00000_00000_00000_000000;
        Data_mem[28]=32'b000000_00000_00000_00000_00000_000000;
        Data_mem[29]=32'b000000_00000_00000_00000_00000_000000;
        Data_mem[30]=32'b000000_00000_00000_00000_00000_000000;
        Data_mem[31]=32'b000000_00000_00000_00000_00000_000000;
  end

  always @(Reg_save or Data_in) begin
    case (Reg_save)
        1: read_Data = Data_mem[addr];
        default: read_Data = Data_in;
    endcase
  end

  always @(posedge clk) begin  
    if (MemWrite == 1) begin
      Data_mem[addr] = writeData;
    end
  end

endmodule