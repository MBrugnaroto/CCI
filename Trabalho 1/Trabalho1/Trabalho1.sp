***---- Trabalho 1 de CCI (Concepção de Circuitos Integrados) ----
***	Nesse trabalho foi desenvolvido um somador de 4 bits em spice
***	a topologia abordada é a WDDL (Wave Dynamic Differential Logic) no qual a topologia é considerada uma topologia de criptografia	

.include NMOS_VTG.inc
.include PMOS_VTG.inc 

V0 gnd 0 DC 0V
V1 vdd 0 DC 3.3V

* The primary input is: a
*TESTE WDDL LOGIC
VinA0 A0 gnd pulse (3.3 0 	0 0.1ns 0.1ns 80ns 160.2ns)
VinA1 A1 gnd pulse (0 	3.3 0 0.1ns 0.1ns 80ns 160.2ns)
VinB0 B0 gnd pulse (3.3 0 	0 0.1ns 0.1ns 40ns 80.2ns)
VinB1 B1 gnd pulse (0 	3.3 0 0.1ns 0.1ns 40ns 80.2ns)

VincarryIn0 carryIn0 gnd pulse (3.3 0 0 0.1ns 0.1ns 20ns 40.2ns)
VincarryIn1 carryIn1 gnd pulse (0 3.3 0 0.1ns 0.1ns 20ns 40.2ns)
*FIM


*TESTE SINGLE RAIL
*VinA A gnd pulse  (3.3 0 	0 0.1ns 0.1ns 80ns 160.2ns)
*VinB B gnd pulse  (3.3 0 	0 0.1ns 0.1ns 40ns 80.2ns)
*VincarryIn carryIn gnd pulse (3.3 0 0 0.1ns 0.1ns 20ns 40.2ns)
*FIM


* Descrição da NAND 2
* label de sub-circuito | nome | entrada(s)| saída(s)| Vcc | Gnd

.subckt NAND_2 A B S VDD GND

* Rede P - Pull UP
M1 S A VDD VDD PMOS W=2.4u L=0.3u
M2 S B VDD VDD PMOS W=2.4u L=0.3u

* Rede N - Pull Down
M3 S A Y GND NMOS W=2.4u L=0.3u
M4 Y B GND GND NMOS W=2.4u L=0.3u

.ends NAND_2

.subckt INV IN OUT VDD GND
M1 OUT IN VDD VDD PMOS W=2.4u L=0.3u
M2 OUT IN GND GND NMOS W=1.2u L=0.3u
.ends INV

.subckt AND_2 A B S VDD GND

* Rede P - Pull UP
M1 STEMP 	A VDD VDD PMOS W=2.4u L=0.3u
M2 STEMP 	B VDD VDD PMOS W=2.4u L=0.3u

* Rede N - Pull Down
M3 STEMP 	A Y GND NMOS W=2.4u L=0.3u
M4 Y 		B GND GND NMOS W=2.4u L=0.3u

X1 STEMP S VDD GND INV

.ends AND_2

* Fim da descrição da NAND 2

* Descrição da NOR 2
* label de sub-circuito | nome | entrada(s)| saída(s)| Vcc | Gnd

.subckt NOR_2 C D S VDD GND

* Rede P - Pull UP
M1 Z C VDD VDD PMOS W=4.8u L=0.3u
M2 S D Z 	VDD PMOS W=4.8u L=0.3u

* Rede N - Pull Down
M3 S C GND GND NMOS W=1.2u L=0.3u
M4 S D GND GND NMOS W=1.2u L=0.3u

.ends NOR_2

.subckt OR_2 C D S VDD GND

* Rede P - Pull UP
M1 Z 		C VDD VDD PMOS W=4.8u L=0.3u
M2 STEMP 	D Z   VDD PMOS W=4.8u L=0.3u

* Rede N - Pull Down
M3 STEMP 	C GND GND NMOS W=1.2u L=0.3u
M4 STEMP 	D GND GND NMOS W=1.2u L=0.3u

X1 STEMP S VDD GND INV

.ends OR_2

.subckt xor A B S VDD GND
X1 B B_temp VDD GND INV
X2 A A_temp VDD GND INV
X3 A B_temp S_temp0 VDD GND AND_2
X4 A_temp B S_temp1 VDD GND AND_2
X5 S_temp0 S_temp1 S VDD GND OR_2

.ends xor

.subckt meio_somador A B Sum Carry VDD GND
X1 A B Sum VDD GND xor
X2 A B Carry VDD GND AND_2
.ends meio_somador

.subckt somador_completo A B Sum carryIn carryOut VDD GND
X1 A B N3 Carry VDD GND meio_somador
X2 N3 carryIn Sum VDD GND xor
X3 N3 carryIn N2 VDD GND AND_2
X4 Carry N2 carryOut VDD GND OR_2
.ends somador_completo







*CONVEÇÃO WDDL *CONVEÇÃO WDDL
.subckt nand_WDDL A0 A1 B0 B1 S0 S1 VDD GND
X1 A1 B1 S0	VDD GND AND_2
X2 A0 B0 S1 VDD GND OR_2

.ends nand_WDDL

.subckt and_WDDL A0 A1 B0 B1 S0 S1 VDD GND
X1 A1 B1 S1	VDD GND AND_2
X2 A0 B0 S0 VDD GND OR_2

.ends and_WDDL

.subckt or_WDDL A0 A1 B0 B1 S0 S1 VDD GND
X1 A0 B0 S0	VDD GND AND_2
X2 A1 B1 S1 VDD GND OR_2
.ends or_WDDL

.subckt xor_WDDL A0 A1 B0 B1 S0 S1 VDD GND
X1 A0 B1 S1_temp0	VDD GND AND_2
X2 A1 B0 S1_temp1 	VDD GND AND_2
X3 A1 B0 S0_temp0	VDD GND OR_2
X4 A0 B1 S0_temp1 	VDD GND OR_2

X5 S1_temp0 S1_temp1 S1	VDD GND OR_2
X6 S0_temp0 S0_temp1 S0	VDD GND AND_2
.ends xor_WDDL

.subckt xnor_WDDL A0 A1 B0 B1 S0 S1 VDD GND
X1 A0 B1 S1_temp0	VDD GND AND_2
X2 A1 B0 S1_temp1 	VDD GND AND_2
X3 A1 B0 S0_temp0	VDD GND OR_2
X4 A0 B1 S0_temp1 	VDD GND OR_2

X5 S1_temp0 S1_temp1 S0	VDD GND OR_2
X6 S0_temp0 S0_temp1 S1	VDD GND AND_2
.ends xnor_WDDL
*CONVEÇÃO WDDL *CONVEÇÃO WDDL




*Somador em WDDL

.subckt meio_somador_wddl A0 B0 A1 B1 SUM0 SUM1 carryOut0 carryOut1 VDD GND
X1 A0 A1 B0 B1 SUM0 SUM1 VDD GND xor_WDDL
X2 A0 A1 B0 B1 carryOut0 carryOut1 VDD GND and_WDDL
.ends meio_somador_wddl

.subckt somador_WDDL A0 B0 A1 B1 carryIn0 carryIn1 SUM0 SUM1 carryOut0 carryOut1 VDD GND
X1 A0 B0 A1 B1 N30 N31 N10 N11 VDD GND meio_somador_wddl
X2 N30 N31 carryIn0 carryIn1 Sum0 Sum1 VDD GND xor_WDDL
X3 N30 N31 carryIn0 carryIn1 N20 N21 VDD GND and_WDDL
X4 N10 N11 N20 N21 carryOut0 carryOut1 VDD GND or_WDDL
.ends somador_WDDL

*Somador em WDDL
*São entradas e saídas temporárias os N's







*X5 A0 B0 SUM0 CARRY0 A1 B1 SUM1 CARRY1 VDD GND meio_somador1
*X5 A0 A1 B0 B1 S0 S1 VDD GND or_WDDL

*X1 A0 B0 SUM0 carryIn0 carryOut0 A1 B1 SUM1 carryIn1 carryOut1 VDD GND somador_WDDL
*X1 A0 B0 SUM0 carryOut0 A1 B1 SUM1 carryOut1 VDD GND meio_somador_wddl

*X1 A0 A1 B0 B1 S0 S1 VDD GND and_WDDL

* Fim das Instancias

* CAPACITOR DA SAIDA 1
** Cnome  nó+ nó- valor
C1 S_f 0 0.5pF

.tran 0.0002ns 320ns

*X1 A0 A1 B0 B1 S0 S1 VDD GND xnor_WDDL
X2 IN OUT VDD GND INV

*.print v(A0) v(A1) v(S0) v(S1)
*.print v(A1)
*.print v(B0)
*.print v(B1)
*.print v(S0)
*.print v(S1)

.print v(IN) v(OUT)

.end

