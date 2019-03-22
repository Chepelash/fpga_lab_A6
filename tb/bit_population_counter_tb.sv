module bit_population_counter_tb;

parameter int CLK_T = 10000;
parameter int WIDTH = 8;

logic                     clk;
logic                     rst;

logic                     data_val_i;
logic   [WIDTH-1:0]       data_i;

logic   [$clog2(WIDTH):0] data_o;
logic                     data_val_o;

 
 bit_population_counter #(
  .WIDTH                ( WIDTH      )
) bpc (
  .clk_i                ( clk        ),
  .srst_i               ( rst       ),
  
  .data_i               ( data_i     ),
  .data_val_i           ( data_val_i ),
  
  .data_o               ( data_o     ),
  .data_val_o           ( data_val_o )
);
 
 
task automatic clk_gen;

  forever
    begin
      #( CLK_T / 2 );
      clk <= ~clk;
    end

endtask

task automatic apply_rst;

  rst <= 1'b1;
  @( posedge clk );
  rst <= 1'b0;
  @( posedge clk );

endtask
  
task automatic apply_data_val;

  data_val_i <= 1'b1;
  @( posedge clk );
  data_val_i <= 1'b0;
  @( posedge clk );

endtask

task automatic rand_numb_test;
  
  bit [WIDTH-1:0] check_val_o;
  
  for( int i = 0; i < 5; i++ )
    begin
      
      data_i <= $urandom_range(0, 255);
      apply_data_val();

      @(posedge data_val_o);
      for( int i = 0; i < 8; i++ )
        begin
          check_val_o += data_i[i];
        end
      if( check_val_o == data_o ) 
        begin
          $display("OK! Input = %8b; Module output = %d; Check value = %d;",
                    data_i, data_o, check_val_o);
        end
      else
        begin
          $display("Error! Input = %b; Module output = %d; Check value = %d;",
                    data_i, data_o, check_val_o);
          $stop();          
        end
      check_val_o = 0;
    end
    $display("Test completed!");
endtask
 
 always
  begin
    clk_gen();
  end
    

initial
  begin
    clk <= 0;
    rst <= 0;
    
    $display("------------------------------------\n");
    $display("Starting test!\n");
    $display("------------------------------------\n");
    
//    fork
//      clk_gen();      
//    join_none

    $display("Resetting...\n");
    apply_rst();
    
    // проверка соответствия 5 случайных чисел
    $display("Testing 5 random numbers");
    rand_numb_test();    
    
    $display("------------------------------------\n");        
      
    $display("Everything is OK\n");
    $stop();
  end  
  
endmodule