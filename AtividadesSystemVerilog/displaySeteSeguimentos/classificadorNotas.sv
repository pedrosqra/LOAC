//Felipe de Souza Siqueira
//Display de 7 seguimentos
//119110399

parameter NINSTR_BITS = 32;
parameter NBITS_TOP = 8, NREGS_TOP = 32, NBITS_LCD = 64;

module top(input  logic clk_2,
           input  logic [NBITS_TOP-1:0] SWI,
           output logic [NBITS_TOP-1:0] LED,
           output logic [NBITS_TOP-1:0] SEG,
           output logic [NBITS_LCD-1:0] lcd_a, lcd_b,
           output logic [NINSTR_BITS-1:0] lcd_instruction,
           output logic [NBITS_TOP-1:0] lcd_registrador [0:NREGS_TOP-1],
           output logic [NBITS_TOP-1:0] lcd_pc, lcd_SrcA, lcd_SrcB,
           lcd_ALUResult, lcd_Result, lcd_WriteData, lcd_ReadData, 
           output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite);

/*

Classificador de nota
Implemente um circuito lógico combinacional que apresente a situação de um aluno em um display de sete segmentos, conforme descrição a seguir.

    “A” (Aprovado por média) se a nota do aluno for igual ou superior a 7 pontos
    “F” (Final) se a nota do aluno for maior ou igual a 4 e menor que 7 pontos
    “P” (Perdeu a disciplina) se a nota do aluno for inferior a 4 pontos. 
Observação: a nota do aluno é representada por um valor inteiro entre 0 e 9.

Entradas:

    SWI[3:0] ... nota do aluno
    SWI[7] ... em "1" mostra a situação, em "0" mostra a nota. 

Saída: SEG

*/

logic bit0, bit1, bit2, bit3, opcao, seguimento0, seguimento1, seguimento2, seguimento3, seguimento4, seguimento5, seguimento6;

parameter ALTA_TENSAO=1, BAIXA_TENSAO=0;

always_comb begin
  bit0 <= SWI[0];
  bit1 <= SWI[1];
  bit2 <= SWI[2];
  bit3 <= SWI[3];
  opcao <= SWI[7];
end

always @(*) begin

  if (opcao) begin
    seguimento0 <= ALTA_TENSAO;
    seguimento1 <= ~(~bit3 & bit2 & ~(bit1 & bit0));
    seguimento2 <= (bit3 | (bit0 & bit1 & bit2));
    seguimento3 <= BAIXA_TENSAO;
    seguimento4 <= ALTA_TENSAO;
    seguimento5 <= ALTA_TENSAO;
    seguimento6 <= ALTA_TENSAO;  
  end

  else begin
    if (~bit3 & ~bit2 & ~bit1 & ~bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= ALTA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= BAIXA_TENSAO;
    end

    if (~bit3 & ~bit2 & ~bit1 & bit0) begin
      seguimento0 <= BAIXA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= BAIXA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= BAIXA_TENSAO;
      seguimento6 <= BAIXA_TENSAO;

    end

    if (~bit3 & ~bit2 & bit1 & ~bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= BAIXA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= ALTA_TENSAO;
      seguimento5 <= BAIXA_TENSAO;
      seguimento6 <= ALTA_TENSAO;

    end

    if (~bit3 & ~bit2 & bit1 & bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= BAIXA_TENSAO;
      seguimento6 <= ALTA_TENSAO;

    end

    if (~bit3 & bit2 & ~bit1 & ~bit0) begin
      seguimento0 <= BAIXA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= BAIXA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= ALTA_TENSAO;

    end

    if (~bit3 & bit2 & ~bit1 & bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= BAIXA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= ALTA_TENSAO;

    end

    if (~bit3 & bit2 & bit1 & ~bit0) begin

      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= BAIXA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= ALTA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= ALTA_TENSAO;

    end

    if (~bit3 & bit2 & bit1 & bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= BAIXA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= BAIXA_TENSAO;
      seguimento6 <= BAIXA_TENSAO;

    end

    if (bit3 & ~bit2 & ~bit1 & ~bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= ALTA_TENSAO;
      seguimento4 <= ALTA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= ALTA_TENSAO;

    end

    if (bit3 & ~bit2 & ~bit1 & bit0) begin
      seguimento0 <= ALTA_TENSAO;
      seguimento1 <= ALTA_TENSAO;
      seguimento2 <= ALTA_TENSAO;
      seguimento3 <= BAIXA_TENSAO;
      seguimento4 <= BAIXA_TENSAO;
      seguimento5 <= ALTA_TENSAO;
      seguimento6 <= ALTA_TENSAO;

    end
  end

SEG[0] <= seguimento0;
SEG[1] <= seguimento1;
SEG[2] <= seguimento2;
SEG[3] <= seguimento3;
SEG[4] <= seguimento4;
SEG[5] <= seguimento5;
SEG[6] <= seguimento6;
end
endmodule

