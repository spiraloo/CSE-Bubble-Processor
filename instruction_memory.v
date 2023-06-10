`timescale 1ns / 1ps
module Instruction_memory (input [31:0] address, output reg [31:0] instruction);

  reg [31:0] instruction_mem[16:0];  // instruction memory

  integer n;
  initial begin
    for (n = 0; n < 17; n = n + 1) begin
      instruction_mem[n] = 32'b00000000000000000000000000000000;
    end

  

    instruction_mem[0] = 32'b00100010010100100000000000000111 ;    
    instruction_mem[1] = 32'b00100010010100101111111111111111 ;  
    instruction_mem[2] = 32'b00100000000010100000000000000000 ;    
    instruction_mem[3] = 32'b00100000000010010000000000000000;   
    instruction_mem[4] = 32'b00000010010010101010100000100010;  
    instruction_mem[5] = 32'b00100010000100010000000000000000;  
    instruction_mem[6] = 32'b10001110001011010000000000000000  ;
    instruction_mem[7] = 32'b10001110001011000000000000000001    ;
    instruction_mem[8] = 32'b00000001100011011100000000101010 ;   
    instruction_mem[9] = 32'b00010011000000000000000000000010 ;     
    instruction_mem[10] = 32'b10101110001011000000000000000000 ;    
    instruction_mem[11] = 32'b10101110001011010000000000000001;   
    instruction_mem[12] = 32'b00100010001100010000000000000001 ;  
    instruction_mem[13] = 32'b00100001001010010000000000000001 ; 
    instruction_mem[14] = 32'b00010101001101011111111111110111 ;
    instruction_mem[15] = 32'b00100001010010100000000000000001;
    instruction_mem[16] = 32'b00010101010100101111111111110010;
  end

  always @(address) begin
    instruction = instruction_mem[address/4];
  end

endmodule






// MIPS code
// 0 addi $s2, $s2, 0x7
// 1 addi $s2, $s2, -1 
// 2 addi $t2, $0, 0
// 3 addi $t1, $0, 0[[loop2]]
// 4 sub $s5, $s2, $t2
// 5 addi $s1, $s0, 0
// 6 lw $t5, 0($s1) [[loop1]]
// 7 lw $t4, 1($s1)
// 8 slt $t8,$t4, $t5
// 9 beq $t8, $zero, dont_swap
// 10 sw $t4, 0($s1)
// 11 sw $t5, 1($s1)
// 12 addi $s1, $s1, 1 [[dont_swap]]
// 13 addi $t1, $t1, 1
// 14 bne $t1, $s5, loop1
// 15 addi $t2, $t2, 1
// 16 bne $t2,$s2,loop2



