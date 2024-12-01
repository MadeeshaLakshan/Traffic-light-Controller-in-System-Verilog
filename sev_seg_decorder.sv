module Sev_segment_decorder (
    input logic [3:0]number,
    output logic [6:0]sev_segment 
);

always_comb begin
    case(number)
    4'd0: sev_segment  = 7'b0111111; // 0
    4'd1: sev_segment  = 7'b0000110; // 1
    4'd2: sev_segment  = 7'b1011011; // 2
    4'd3: sev_segment  = 7'b1001111; // 3
    4'd4: sev_segment  = 7'b1100110; // 4
    4'd5: sev_segment  = 7'b1101101; // 5
    4'd6: sev_segment  = 7'b1111101; // 6
    4'd7: sev_segment  = 7'b0000111; // 7
    4'd8: sev_segment  = 7'b1111111; // 8
    4'd9: sev_segment  = 7'b1101111; // 9
    default: sev_segment  = 7'b0000000; 
    endcase
end
endmodule