***---- Trabalho 1 de CCI (Concepção de Circuitos Integrados) ----
***	Nesse trabalho foi desenvolvido um somador de 4 bits em spice
***	a topologia abordada é a WDDL (Wave Dynamic Differential Logic) no qual a topologia é considerada uma topologia de criptografia	

.include NMOS_VTG.inc
.include PMOS_VTG.inc 

V0 gnd 0 DC 0V
V1 vdd 0 DC 3.3V

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

* Descrição da NAND_2
* label de sub-circuito | nome | entrada(s)| saída(s)| Vcc | Gnd

.subckt NAND_2 A B S VDD GND

* Rede P - Pull UP
M1 S A VDD VDD PMOS W=2.4u L=0.3u
M2 S B VDD VDD PMOS W=2.4u L=0.3u

* Rede N - Pull Down
M3 S A Y GND NMOS W=2.4u L=0.3u
M4 Y B GND GND NMOS W=2.4u L=0.3u

.ends NAND_2
*DESCRIÇÃO NAND_2



*DESCRIÇÃO INV
.subckt INV IN OUT VDD GND
M1 VDD IN OUT VDD PMOS W=2.4u L=0.3u
M2 GND IN OUT GND NMOS W=1.2u L=0.3u
.ends INV
*FIM DA DESCRIÇÃO INV



*DESCRIÇÃO AND_2
.subckt AND_2 A B S VDD GND

* Rede P - Pull UP
M1 STEMP 	A VDD VDD PMOS W=2.4u L=0.3u
M2 STEMP 	B VDD VDD PMOS W=2.4u L=0.3u

* Rede N - Pull Down
M3 STEMP 	A Y GND NMOS W=2.4u L=0.3u
M4 Y 		B GND GND NMOS W=2.4u L=0.3u

X1 STEMP S VDD GND INV

.ends AND_2
*FIM DA DESCRIÇÃO AND_2




*DESCRIÇÃO NOR_2
.subckt NOR_2 A B S VDD GND

* Rede P - Pull UP
M1 Z A VDD VDD PMOS W=4.8u L=0.3u
M2 S B Z 	VDD PMOS W=4.8u L=0.3u

* Rede N - Pull Down
M3 S A GND GND NMOS W=1.2u L=0.3u
M4 S B GND GND NMOS W=1.2u L=0.3u

.ends NOR_2
*FIM DA DESCRIÇÃO NOR_2



*DESCRIÇÃO OR_2
.subckt OR_2 A B S VDD GND

* Rede P - Pull UP
M1 Z 		A VDD VDD PMOS W=4.8u L=0.3u
M2 STEMP 	B Z   VDD PMOS W=4.8u L=0.3u

* Rede N - Pull Down
M3 STEMP 	A GND GND NMOS W=1.2u L=0.3u
M4 STEMP 	B GND GND NMOS W=1.2u L=0.3u

X1 STEMP S VDD GND INV

.ends OR_2
*FIM DA DESCRIÇÃO OR_2



*CONVENÇÃO DUAL RAIL *CONVENÇÃO DUAL RAIL
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
*CONVENÇÃO DUAL RAIL *CONVENÇÃO DUAL RAIL


*CONVENÇÃO WDDL *CONVENÇÃO WDDL
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
*CONVENÇÃO WDDL *CONVENÇÃO WDDL


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
* Fim das Instancias

* CAPACITOR DA SAIDA 1
** Cnome  nó+ nó- valor
C1 SUM1 0 0.5pF
C2 SUM0 0 0.5pF
C3 carryOut1 0 0.5pF
C4 carryOut0 0 0.5pF

X1 A0 B0 A1 B1 carryIn0 carryIn1 SUM0 SUM1 carryOut0 carryOut1 VDD GND somador_WDDL

.tran 0.0002ns 160ns


.measure	tran t_R_carryOut1	trig v(carryOut1)	val = (0.1*2.7755863)	rise = 3.3
+										targ v(carryOut1)	val = (0.9*2.7755863)	rise = 3.3

.measure tran t_F_carryOut1	trig v(carryOut1) val = (0.9*2.7755863)	fall = 3.3
+										targ v(carryOut1) val = (0.1*2.7755863)  fall = 3.3

.measure tran t_R_Out1	trig v(SUM1) val = (0.9*3.3)	rise = 3.3
+								targ v(SUM1) val = (0.1*3.3)  rise = 3.3

.measure tran t_F_Out1	trig v(SUM1) val = (0.9*3.3)	fall = 3.3
+								targ v(SUM1) val = (0.1*3.3)  fall = 3.3

.measure tran tHL_Out1	trig v(A1) val = (0.5*3.3) fall = 3.3
+								targ v(SUM1) val = (0.5*3.3) rise = 3.3 

*.measure tran vini trig v(A1) val
.print v(A1) v(B1) v(carryIn1) v(carryOut1) v(SUM0) v(SUM1)

.end

