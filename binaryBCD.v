`timescale 1ns / 1ps

module binaryBCD(
    input zero,one,two,three,four,five,six,seven,eight,nine,
    output D,
    output C,
    output B,
    output A
    );
    
    assign D = eight | nine;
    assign C = four | five | six | seven;
    assign B = two | three | six | seven;
    assign A = one | three | five | seven | nine;
    
endmodule
