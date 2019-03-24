module bit_population_counter_wrap #(
  parameter WIDTH = 8
)(
  input                          clk,
  input                          rst,
  
  input                          data_val_i,
  input        [WIDTH-1:0]       data_i, 
  
  output logic [$clog2(WIDTH):0] data_o,
  output logic                   data_val_o
);

logic                   rst_wrap;

logic                   data_val_i_wrap;
logic [WIDTH-1:0]       data_i_wrap;
  
logic [$clog2(WIDTH):0] data_o_wrap;
logic                   data_val_o_wrap;


bit_population_counter #(
  .WIDTH                ( WIDTH           )
) bpc (
  .clk_i                ( clk             ),
  .srst_i               ( rst_wrap        ),
  
  .data_i               ( data_i_wrap     ),
  .data_val_i           ( data_val_i_wrap ),
  
  .data_o               ( data_o_wrap     ),
  .data_val_o           ( data_val_o_wrap )
);


always_ff @( posedge clk )
  begin
    rst_wrap        <= rst;
    
    data_val_i_wrap <= data_val_i;
    data_i_wrap     <= data_i;
    
    data_o          <= data_o_wrap;
    data_val_o      <= data_val_o_wrap;
  end  

endmodule