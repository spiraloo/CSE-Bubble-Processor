`timescale 1ns / 1ps
`include "a7new_instruction_memory.v"
`include "a7new_register.v"
`include "a7new_control.v"
`include "a7new_Logic_unit.v"
`include "a7new_data_memory.v"
`include "a7new_pc.v"


module top (input clk);

  wire [31:0] instruction_taken, input_prog_count, output_program_count, wbdata, read1, read2, result;
  wire destination, Jump, Branch, Bne,MemtoReg, MemWrite, Src, RegWrite, zero;
  wire [1:0] Operation;
  wire [3:0] control;

  
  Next_pc u_Next_pc (.pc(output_program_count),.instruction(instruction_taken),.Jump(Jump),.Branch(Branch),.Bne(Bne),.zero(zero),.next_pc(input_prog_count), .pc_out(output_program_count), .clk(clk));

  Instruction_memory u_Instruction_memory (.address(output_program_count),.instruction(instruction_taken));

  Veda uut_veda (.clk(clk),.instruction(instruction_taken),.write_enable(RegWrite),.instruction_check(destination),.data_write(wbdata),.ReadData1(read1),.ReadData2(read2));

  Logic_Unit u_Logic_Unit (.input1(read1),.read2(read2),.instruction(instruction_taken),.Src(Src),.check(zero),.result(result), .Operation(Operation),.instructionN(instruction_taken[5:0]));

  Control u_Control (.instruction(instruction_taken),.instruction_check(destination),.Jump(Jump),.Branch(Branch),.Bne(Bne),.MemtoReg(MemtoReg),.Operation(Operation),.MemWrite(MemWrite),.source(Src),.RegWrite(RegWrite));

  Data_memory u_Data_memory (.clk(clk),.addr(result),.writeData(read2),.Data_in(result),.MemWrite (MemWrite),.Reg_save (MemtoReg),.read_Data(wbdata));


endmodule
