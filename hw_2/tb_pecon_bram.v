`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2017 09:56:06 PM
// Design Name: 
// Module Name: tb_pecon_bram
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
//////////////////////////////////////////////////////////////////////////////////


module tb_pecon_bram();
    parameter CLOCK_PERIOD = 20; // 50MHz
    parameter BRAM_ADDR_WIDTH = 15;

    reg start;
    reg aclk;
    reg aresetn;
    
    wire done;
    wire [31:0] BRAM_ADDR;
    wire [31:0] BRAM_WRDATA;
    wire [3:0] BRAM_WE;
    wire BRAM_CLK;
    wire [31:0] BRAM_RDDATA;

    // fixed value for auxilary control signals
    wire BRAM_EN = 1;
    wire BRAM_RST = 0;
    
    pe_con #(
        .VECTOR_SIZE(16),
        .L_RAM_SIZE(4)
    ) u_con (
        .start(start),
        .aclk(aclk),
        .aresetn(aresetn),
        .done(done),
        .BRAM_ADDR(BRAM_ADDR),
        .BRAM_WRDATA(BRAM_WRDATA),
        .BRAM_WE(BRAM_WE),
        .BRAM_CLK(BRAM_CLK),
        .BRAM_RDDATA(BRAM_RDDATA)
    );
    
    
    my_bram #(
        .BRAM_ADDR_WIDTH(BRAM_ADDR_WIDTH),
        .INIT_FILE("input.txt"),
        .OUT_FILE("output.txt")
    ) u_mem (
        .BRAM_ADDR(BRAM_ADDR[BRAM_ADDR_WIDTH-1:0]),
        .BRAM_CLK(BRAM_CLK),
        .BRAM_WRDATA(BRAM_WRDATA),
        .BRAM_RDDATA(BRAM_RDDATA),
        .BRAM_WE(BRAM_WE),
        .done(done),
        
        .BRAM_EN(BRAM_EN),
        .BRAM_RST(BRAM_RST)
    );
    
    always #(CLOCK_PERIOD / 2) aclk <= ~aclk;
    
    initial begin
        aclk <= 0;
        start <= 0;
        aresetn <= 1;
        
        #(CLOCK_PERIOD / 2)
        aresetn <= 0;
        
        #(CLOCK_PERIOD * 100)
        aresetn <= 1; 
        
        #(CLOCK_PERIOD * 5)
        start <= 1;
        
        #(CLOCK_PERIOD)
        start <= 0;
        
        wait(done)
        #(CLOCK_PERIOD*10) $finish; 
        
    end
    
endmodule
