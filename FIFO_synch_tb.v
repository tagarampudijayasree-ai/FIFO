`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2026 14:30:16
// Design Name: 
// Module Name: FIFO_synch_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
    module FIFO_synch_tb();
    reg clk,rst_n,cs,wr_en,rd_en;
    reg [31:0] data_in;
    wire [31:0] data_out;
    wire full,empty;
    FIFO_synch dut(.clk(clk),.rst_n(rst_n),.cs(cs),.wr_en(wr_en),.rd_en(rd_en),.data_in(data_in),.data_out(data_out),.full(full),.empty(empty));
    always #5 clk=~clk;
    initial begin
    clk=0; rst_n=0; cs=0; wr_en=0; rd_en=0; data_in=0;
    
    #20 rst_n=1;
    cs=1;
    //write opoeration
    wr_en=1;
    data_in = 32'h11; @(posedge clk);
    data_in = 32'h22; @(posedge clk);
    data_in = 32'h33; @(posedge clk);
    data_in = 32'h44; @(posedge clk);
    data_in = 32'h55; @(posedge clk);
    data_in = 32'h66; @(posedge clk);
    data_in = 32'h77; @(posedge clk);
    data_in = 32'h88; @(posedge clk);
    wr_en=0;
    // writing when full
  
    data_in=32'hAA;
    wr_en =1;
    @(posedge clk);
    wr_en=0;
    // read all 8 words
    rd_en=1;
    
    repeat(8)
    @(posedge clk);
    rd_en=0;
    //reading when empty
    @(posedge clk);
    rd_en=1;
    
   @(posedge clk);
    rd_en=0;
    #20;
    $finish;
    end
    initial begin
    $monitor("Time=%0t WR=%b RD=%b DIN=%h DOUT+%h FULL=%b EMPTY= %b WP=%d RP=%d",
    $time,wr_en,rd_en,data_in,data_out, full,empty,dut.write_pointer,dut.read_pointer);
    end   
    
 
    
endmodule
