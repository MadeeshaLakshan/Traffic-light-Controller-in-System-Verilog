module tb_top_module;

    logic clk;
    logic rstn; 
    logic traffic_B;
    logic red_light_A, amber_light_A, green_light_A;
    logic red_light_B, amber_light_B, green_light_B;
    logic [7:0] sec_counter_val;
    logic [3:0] mili_sec_counter_val;
    
    top_module dut (.*);
       
    // Clock Generation
    always #2.5 clk = ~clk;

    // Task: Apply Reset
    task apply_reset;
        begin
            rstn = 0;
            #10; // Hold reset for 20ns
            rstn = 1;
        end
    endtask

    // Task: Set Traffic_B Signal
    task drive_traffic_B(input logic value, input int delay);
        begin
            traffic_B = value;
            #(delay);
        end
    endtask

    initial begin
        // Initialize signals
        clk = 0;
        rstn = 0;
        traffic_B = 0;

        // Apply reset
        apply_reset;

        // Test Case 1: Basic State Transitions
        $display("Test Case 1: Basic State Transitions");
        drive_traffic_B(0, 25); // Traffic_B = 0 for 100ns
        drive_traffic_B(1, 25); // Traffic_B = 1 for 100ns
        drive_traffic_B(0, 25); // Traffic_B = 0 for 100ns

        // Test Case 2: Reset During Operation
        $display("Test Case 2: Reset During Operation");
        #20; // Wait for some time
        apply_reset;

        // Test Case 3: Random Traffic Signal Changes
        $display("Test Case 3: Random Traffic Signal Changes");
        repeat (20) begin
            drive_traffic_B($urandom_range(0, 1), $urandom_range(10,50));
        end

        // Test Case 4: Observe Amber Light Timing
        $display("Test Case 4: Amber Light Timing");
        drive_traffic_B(1, 400); // Keep Traffic_B = 1 to trigger amber light state
        $finish;
    end

    // Assertions
    always @(posedge clk) begin
        // Assert that only one light is ON for each lane at any time
        assert((red_light_A + amber_light_A + green_light_A) <= 1)
            else $error("Invalid light combination for Lane A at time %0t", $time);
        assert((red_light_B + amber_light_B + green_light_B) <= 1)
            else $error("Invalid light combination for Lane B at time %0t", $time);

        // Assert that the sec_counter and mili_sec_counter are within valid ranges
        assert(sec_counter_val <= 70)
            else $error("sec_counter_val out of range at time %0t", $time);
        assert(mili_sec_counter_val <= 5)
            else $error("mili_sec_counter_val out of range at time %0t", $time);
    end

    // Monitor Outputs
    initial begin
        $monitor($time, 
            " | traffic_B=%b | red_A=%b amber_A=%b green_A=%b | red_B=%b amber_B=%b green_B=%b | sec=%d ms=%d",
            traffic_B, red_light_A, amber_light_A, green_light_A,
            red_light_B, amber_light_B, green_light_B,
            sec_counter_val, mili_sec_counter_val);
    end
endmodule
