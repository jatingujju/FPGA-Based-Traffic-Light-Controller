`timescale 1ns/1ps

module tb_traffic_light_controller_v2;

reg clk;
reg rst;

reg ped_req;
reg emergency;
reg night_mode;

wire [2:0] roadA;
wire [2:0] roadB;
wire ped_walk;

// DUT
traffic_light_controller_v2 dut (
    .clk(clk),
    .rst(rst),
    .ped_req(ped_req),
    .emergency(emergency),
    .night_mode(night_mode),
    .roadA(roadA),
    .roadB(roadB),
    .ped_walk(ped_walk)
);

// Clock Generation
initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

// VCD Dump
initial
begin
    $dumpfile("traffic_v2.vcd");
    $dumpvars(0, tb_traffic_light_controller_v2);
end

// Monitor
initial
begin
    $display("Time\tRST\tPED\tEMERG\tNIGHT\tRoadA\tRoadB\tPED_WALK");

    $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b",
             $time,
             rst,
             ped_req,
             emergency,
             night_mode,
             roadA,
             roadB,
             ped_walk);
end

// Test Sequence
initial
begin

    // Initialize
    rst = 1;
    ped_req = 0;
    emergency = 0;
    night_mode = 0;

    #20;
    rst = 0;

    $display("\n=== NORMAL OPERATION ===");

    #300;

    $display("\n=== PEDESTRIAN REQUEST ===");

    ped_req = 1;
    #20;
    ped_req = 0;

    #300;

    $display("\n=== EMERGENCY MODE ===");

    emergency = 1;

    #100;

    emergency = 0;

    #200;

    $display("\n=== NIGHT MODE ===");

    night_mode = 1;

    #150;

    night_mode = 0;

    #200;

    $display("\n=== TEST COMPLETE ===");

    $finish;

end

// Safety Check
always @(posedge clk)
begin
    if ((roadA == 3'b001) && (roadB == 3'b001))
    begin
        $display("ERROR: BOTH ROADS GREEN AT TIME %0t", $time);
        $stop;
    end
end

endmodule