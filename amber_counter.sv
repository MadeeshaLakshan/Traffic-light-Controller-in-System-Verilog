module amber_timer(
    input logic  clk,
    input logic enable,
    output logic timer_done,
    output logic [7:0]sec_counter_val,
    output logic [3:0]mili_sec_counter_val
);

logic sec_done ;

down_counter #(.N(70)) sec_counter (
    .clk(clk),
    .enable(enable),
    .count(sec_counter_val),
    .done(sec_done)
);

down_counter  #(.N(5))mili_sec_counter(
    .clk(clk),
    .enable(sec_done),
    .count(mili_sec_counter_val),
    .done(timer_done)
);
    
endmodule

module down_counter #(parameter N = 10)(
    input logic clk,
    input logic enable,
    output logic [$clog2(N):0] count,
    output logic done
);

    always_ff @(posedge clk) begin
        if (enable) begin
            if (count > 0) begin
                count <= count - 1;
                done <= 1'b0;
            end else begin
                done <= 1'b1;
            end
        end else begin
            count <= N ;
            done <= 1'b0;
        end
    end

endmodule