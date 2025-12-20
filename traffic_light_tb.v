`include "traffic_light.v"

module traffic_light_tb;

    reg clk, reset;
    wire red, yellow, green;

    traffic_light dut (
        .clk(clk),
        .reset(reset),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        #200 $finish;
    end

    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, traffic_light_tb);
        $monitor("Time=%0t RED=%b YELLOW=%b GREEN=%b",
                  $time, red, yellow, green);
    end

endmodule
