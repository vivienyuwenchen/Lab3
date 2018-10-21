`define AND2 and #40
`define AND3 and #60
`define AND4 and #80
`define OR2 or #40
`define OR8 or #160
`define XOR2 xor #40
`define NOT1 not #10
`define NAND2 nand #20
`define NOR2 nor #20
`define NOR32 nor #320

module didOverflow // calculates overflow of 2 bits
(
    output overflow,
    input a, 
    input b, 
    input s, // most sig bit
    input sub
);
    wire BxorSub;
    wire notA;
    wire notB;
    wire notS;
    wire aAndB;
    wire notaAndNotb;
    wire negToPos;
    wire posToNeg;
    `XOR2 xorgate(BxorSub, b, sub);
    `NOT1 aNot(notA, a);
    `NOT1 bNot(notB, BxorSub);
    `NOT1 sNot(notS, s);
    `AND2 andab(aAndB, a, BxorSub);
    `AND2 andabNot(notaAndNotb, notA, notB);
    `AND2 andSwitch1(negToPos, aAndB, notS);
    `AND2 andSwitch2(posToNeg, notaAndNotb, s);
    `OR2 orGate(overflow, negToPos, posToNeg);
endmodule

module AdderAndSubtractor
(
    output res, 
    output carryout,
    input a, 
    input b, 
    input isSubtract,
    input carryin
);
    wire BxorSub;
    wire xAorB;
    wire AandB;
    wire xAorBandCin;
    `XOR2  xorgate(BxorSub, b, isSubtract);
    `XOR2  xorgate(xAorB, a, BxorSub);   // OR gate produces AorB from A and B
    `XOR2  xorgate(res, xAorB, carryin);
    `AND2  andgate(AandB, a, BxorSub);
    `AND2  andgate(xAorBandCin, xAorB, carryin);
    `OR2   orgate(carryout, AandB, xAorBandCin);
endmodule

module aluBitSlice
(
    output carryOut,
    output initialResult,
    input a,
    input b,
    input carryIn,
    input isSubtract,
    //selection bits to define what operand we are using
    input s0,
    input s1,
    input s2
);

    wire addSub;
    // intermediate results for each operand
    wire orRes;
    wire norRes;
    wire xorRes;
    wire andRes;
    wire nandRes;

    //inverted selection lines
    wire s0inv;
    wire s1inv;
    wire s2inv;
    
    //mapped selections
    wire isAdd;
    wire isSub;
    wire isOr;
    wire isNor;
    wire isXor;
    wire isAnd;
    wire isNand;
    wire isSLT;

     //bitwise operations for each operand
    `AND2(andRes, a, b);
    `NAND2(nandRes, a, b);
    `OR2(orRes, a, b);
    `NOR2(norRes, a, b);
    `XOR2(xorRes, a, b);

    AdderAndSubtractor adder (
        .res (addSub),
        .carryout (carryOut),
        .a (a),
        .b (b),
        .isSubtract (isSubtract),
        .carryin (carryIn)
    );

    //invert selection bits
    // Is essentially a Structual Mux for selecting which operation is being computed
    `NOT1(s0inv, s0);
    `NOT1(s1inv, s1);
    `NOT1(s2inv, s2);
     
     //ony on of these operations will ever result in a true
    `AND4(isAdd, addSub, s0inv, s1inv, s2inv);
    `AND4(isSub, addSub, s0, s1inv, s2inv);
    `AND4(isXor, xorRes, s0inv, s1, s2inv);
    `AND4(isSLT, addSub, s0, s1, s2inv);
    `AND4(isAnd, andRes, s0inv, s1inv, s2);
    `AND4(isNand, nandRes, s0, s1inv, s2);
    `AND4(isNor, norRes, s0inv, s1, s2);
    `AND4(isOr, orRes, s0, s1, s2);


    `OR8(initialResult, isAdd, isSub, isXor, isAnd, isNand, isNor, isOr, isSLT);

endmodule

module isZero (
    input[31:0] bit,
    output out
);
//nor all bits, if all are zero a one will be returned if any are not a 0 will be returned. 

`NOR32(out, bit[0], bit[1], bit[2], bit[3], bit[4], bit[5], bit[6], bit[7], bit[8], bit[9], bit[10], bit[11], bit[12], bit[13], bit[14], 
    bit[15], bit[16], bit[17], bit[18], bit[19], bit[20], bit[21], bit[22], bit[23], bit[24], bit[25], bit[26], bit[27], bit[28], bit[29], bit[30], bit[31]);

endmodule // isZero

module alu (
    output carryout,
    output zero,
    output overflow,
    output[31:0] result,
    input[31:0] operandA,
    input[31:0] operandB,
    input[2:0] command // s0, s1, s2
);

    wire[31:0] initialResult;
    wire[32:0] carryOut; //larger to accommadate carry out bit
    wire isSubtract;

    `OR2(isSubtract, command[0], command[0]); // command[0] = isSubtract b001(subtract) b011(SLT) we need a one in this plac eto know if it is sutract or SLT
    `OR2(carryOut[0], isSubtract, isSubtract);  //carryOut[0] = isSubract anywhere we need to subtract we need carryout


    generate
        genvar i;
        for (i=0; i<32; i=i+1)
	//makes mini ALU for each bit
        begin
            aluBitSlice aluBitSlice (
                .carryOut (carryOut[i+1]),
                .initialResult (initialResult[i]),
                .a (operandA[i]),
                .b (operandB[i]),
                .carryIn (carryOut[i]),
                .isSubtract (isSubtract),
                .s0 (command[0]),
                .s1 (command[1]),
                .s2 (command[2])
            );
        end
    endgenerate

    `OR2(carryout, carryOut[32], carryOut[32]); // carryout[32] = carryout set the carryout of the last bit to the final carryout

    didOverflow overflowCalc( // looks at most significant bit and checks if it will overflow
        .overflow (overflow),
        .a (operandA[31]),
        .b (operandB[31]),
        .s (initialResult[31]),
        .sub (isSubtract)
    );

    //SLT Module for . Uses outputs of subtractor
    wire s2inv;
    wire overflowInv;
    wire isSLTinv;
    wire isSLT;
    wire SLTval;

    `NOT1(s2inv, command[2]);
    `NOT1(overflowInv, overflow);
    `AND3(isSLT, s2inv, command[0], command[1]);
    `NOT1(isSLTinv, isSLT);
    `AND3(SLTval, initialResult[31], overflowInv, isSLT);

    generate
        genvar j;
        for (j=0; j<32; j=j+1)
        begin
            `AND2(result[j], initialResult[j], isSLTinv);
        end
    endgenerate

    `OR2(result[0], initialResult[0], SLTval);

    // determines if result is zero
    isZero zeroCalc(
        .bit (result),
        .out (zero)
    );
endmodule
