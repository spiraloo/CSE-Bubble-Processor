`timescale 1ns / 1ps

`include "a7new_top.v"



module top_tb;

  reg clk;
  integer i; // integer  counter

  always #10 clk = ~clk;

  top uut (.clk(clk));

  initial begin
    // Initialize data memory
    for (i = 0; i < 32; i = i + 1) begin
      uut.u_Data_memory.Data_mem[i] = 32'b0;
    end
    uut.u_Data_memory.Data_mem[0] = 8;
    uut.u_Data_memory.Data_mem[1] = 4;
    uut.u_Data_memory.Data_mem[2] = 3;
    uut.u_Data_memory.Data_mem[3] = 1;
    uut.u_Data_memory.Data_mem[4] = 15;
    uut.u_Data_memory.Data_mem[5] = 10;
    uut.u_Data_memory.Data_mem[6] = 9;

    // initialize veda memory File
    for (i = 0; i < 32; i = i + 1) begin
      uut.uut_veda.Register_Data[i] = 32'b0;
    end
   
    clk = 0;
  end
  
  initial begin  
    #67000;
    $display("sorted_array\n  %d %d %d %d %d %d %d",  uut.u_Data_memory.Data_mem[0], uut.u_Data_memory.Data_mem[1],  uut.u_Data_memory.Data_mem[2],  uut.u_Data_memory.Data_mem[3],  uut.u_Data_memory.Data_mem[4],  uut.u_Data_memory.Data_mem[5],  uut.u_Data_memory.Data_mem[6]);
  end
  
  initial begin
    #567890 $finish;
  end


endmodule