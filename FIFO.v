
module FIFO(input clk,rst_n,cs,wr_en,rd_en,input[31:0]data_in,output reg [31:0]data_out,output empty,full);
reg[31:0]fifo[0:7];
reg [3:0]write_pointer;
reg[3:0]read_pointer;
always@(posedge clk or negedge rst_n)
begin
if (!rst_n)
begin
write_pointer<=4'b0000;
end
else if(cs && wr_en &&!full)
 begin
 fifo[write_pointer[2:0]] <= data_in;
 write_pointer <= write_pointer + 1'b1;
 end
 end
 //read operatiin
 always@(posedge clk or negedge rst_n)
 begin
 if(!rst_n)
 begin
 read_pointer<=4'b0000;
   data_out <= 32'b0;
   end
 else if(cs && rd_en && !empty)
 begin
 data_out <= fifo[read_pointer[2:0]];
 read_pointer<=read_pointer+1'b1;
 end
 end
 assign empty=(read_pointer==write_pointer);
 assign full=(read_pointer=={~write_pointer[3],write_pointer[2:0]});

endmodule
