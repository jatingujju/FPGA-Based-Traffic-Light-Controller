`timescale 1ns/1ps

module tb_traffic_light_controller;

reg clk;
reg rst;

wire [2:0] roadA;
wire [2:0] roadB;

traffic_light_controller dut(
    .clk(clk),
    .rst(rst),
    .roadA(roadA),
    .roadB(roadB)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    #20;
    rst = 0;

    #500;

    $finish;
end

initial begin
    $dumpfile("traffic.vcd");
    $dumpvars(0, tb_traffic_light_controller);
end

endmodule