module traffic_light (
    input clk,
    input reset,
    output reg red,
    output reg yellow,
    output reg green
);

    // State definitions
    parameter RED = 2'b00,
              GREEN = 2'b01,
              YELLOW = 2'b10;

    reg [1:0] state, next_state;
    reg [3:0] count;

    // State register + counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RED;
            count <= 0;
        end else begin
            state <= next_state;
            if (state != next_state)
                count <= 0;
            else
                count <= count + 1;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            RED:    if (count == 4'd9) next_state = GREEN;
            GREEN:  if (count == 4'd9) next_state = YELLOW;
            YELLOW: if (count == 4'd4) next_state = RED;
        endcase
    end

    // Output logic (Moore FSM)
    always @(*) begin
        red = 0; yellow = 0; green = 0;
        case (state)
            RED:    red = 1;
            GREEN:  green = 1;
            YELLOW: yellow = 1;
        endcase
    end

endmodule
