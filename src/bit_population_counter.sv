module bit_population_counter #(
  parameter WIDTH = 8
)(
  input                          clk_i,
  input                          srst_i,
  
  input                          data_val_i,
  input        [WIDTH-1:0]       data_i, 
  
  output logic [$clog2(WIDTH):0] data_o,
  output logic                   data_val_o
);

logic [WIDTH-1:0]       inp_data;
logic [$clog2(WIDTH):0] out_data;
logic [$clog2(WIDTH):0] pre_out_data;
logic                   val_delay_o;

assign data_o = out_data;

always_ff @( posedge clk_i )
  begin
    out_data      <= pre_out_data;
    val_delay_o   <= data_val_i;
    data_val_o    <= val_delay_o;

    if( srst_i )
      begin
        out_data      <= '0;
        val_delay_o   <= '0;
        data_val_o    <= '0;   
      end
    else if( data_val_i )
      begin
        inp_data <= data_i;        
      end
  end

  
always_comb
  begin
    pre_out_data = '0;
    for( int i = 0; i < WIDTH; i++ )
      begin
        pre_out_data += inp_data[i];
      end
  end

//always_comb
//  begin
//    pre_out_data = '0;
//    for ( int i = 0; i < WIDTH; i++ )
//      begin
//        if ( inp_data[i] )
//          begin
//            pre_out_data++;
//          end
//      end
//  end

endmodule
