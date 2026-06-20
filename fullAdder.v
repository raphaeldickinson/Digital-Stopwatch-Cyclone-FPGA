module fullAdder(a, b, cin, sum, cout);
    output	sum, cout;
    input 	a, b, cin;

    assign sum = a ^ b ^ cin;
    assign cout = (a&b) | (a&cin) | (b&cin);
 
endmodule





  

