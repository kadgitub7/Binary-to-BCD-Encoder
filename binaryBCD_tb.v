`timescale 1ns / 1ps

module binaryBCD_tb();
    reg zero,one,two,three,four,five,six,seven,eight,nine;
    wire D,C,B,A;
    
    binaryBCD uut(zero,one,two,three,four,five,six,seven,eight,nine, D,C,B,A);
    
    task clear_inputs;
    begin
        zero = 0; one = 0; two = 0; three = 0; four = 0;
        five = 0; six = 0; seven = 0; eight = 0; nine = 0;
    end
    endtask
    
    initial begin
       clear_inputs; zero = 1;
        #10 $display("0 -> %b%b%b%b", D, C, B, A);

        clear_inputs; one = 1;
        #10 $display("1 -> %b%b%b%b", D, C, B, A);

        clear_inputs; two = 1;
        #10 $display("2 -> %b%b%b%b", D, C, B, A);

        clear_inputs; three = 1;
        #10 $display("3 -> %b%b%b%b", D, C, B, A);

        clear_inputs; four = 1;
        #10 $display("4 -> %b%b%b%b", D, C, B, A);

        clear_inputs; five = 1;
        #10 $display("5 -> %b%b%b%b", D, C, B, A);

        clear_inputs; six = 1;
        #10 $display("6 -> %b%b%b%b", D, C, B, A);

        clear_inputs; seven = 1;
        #10 $display("7 -> %b%b%b%b", D, C, B, A);

        clear_inputs; eight = 1;
        #10 $display("8 -> %b%b%b%b", D, C, B, A);

        clear_inputs; nine = 1;
        #10 $display("9 -> %b%b%b%b", D, C, B, A); 
    end
endmodule
