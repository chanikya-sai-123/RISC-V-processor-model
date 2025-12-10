`timescale 1ns/1ps

module proctb;
    reg clk1, clk2;
    integer k;
    proc uut (.clk1(clk1), .clk2(clk2));
    initial begin
        clk1 = 0;
        clk2 = 0;
        forever begin
            #5  clk1 = ~clk1;   //  half-cycle
            #5  clk2 = ~clk2;   //  phase-shifted half-cycle
        end
    end

    // -------------------------------------------------
    // Test program
    // -------------------------------------------------
    initial begin
        // 1) Initialise register file so every Reg[i] = i
        for (k = 0; k < 32; k = k + 1)
            uut.Reg[k] = k;

        // 2) Tiny pause for any global reset logic
        #2;

        // 3) Load instruction memory (raw opcodes shown)
        uut.Mem[0] = {6'b001010, 5'd0, 5'd1, 16'd5};     // ADDI R1, R0, 5
        uut.Mem[1] = {6'b001010, 5'd0, 5'd2, 16'd3};     // ADDI R2, R0, 3
        uut.Mem[2] = {6'b000000, 5'd1, 5'd2, 5'd3, 5'd0, 6'b000000}; // ADD  R3, R1, R2
        
      uut.Mem[3] = {6'b000000, 5'd1, 5'd3, 5'd3, 5'd0, 6'b000000}; // ADD R3,R3,R1
      //uut.Mem[3] = {6'b000000, 5'd3, 5'd2, 5'd4, 5'd0, 6'b000000};  //ADD R4,R3,R2
      //uut.Mem[4]={6'b001001,5'd0,5'd7,16'd23}; //SW R7,23[R0]
    
      uut.Mem[4]={6'b001000,5'd0,5'd20,16'd23}; //LW R20,23[R0]
       uut.Mem[5]={6'b000000,5'd20,5'd1,5'd10,11'd0}; // ADD R10,R20,R1
       uut.Mem[6] = {6'b000100, 5'd1, 5'd1, 16'd2};     // BEQZ R1, R1, +2
       uut.Mem[7] = {6'b001010, 5'd0, 5'd13, 16'd6};     // ADDI R13, R0, 6
       uut.Mem[8] = {6'b001010, 5'd0, 5'd13, 16'd7};     // ADDI R13, R0, 7
       uut.Mem[9]= {6'b001010, 5'd13, 5'd13, 16'd7};     // ADDI R13, R13, 7
        
       
       uut.Mem[23]=6;
      
        // 4) Clear control flags and PC
        uut.HALTED = 0;
        uut.PC     = 0;

        // 5) Let the program run for a while
        #1000;

        // 6) Print every register as a message
        $display("\n========== FINAL REGISTER FILE ==========");
        for (k = 0; k < 32; k = k + 1)
            $display("Register R%-2d contains: %0d", k, uut.Reg[k]);
        $display("=========================================\n");

        $finish;
    end
endmodule