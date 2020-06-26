********************************************************************************
* SPICE netlist generated by HiPer Verify's NetList Extractor
*
* Extract Date/Time:	Mon Jul 01 16:04:24 2019
* L-Edit Version:		L-Edit Win64 16.01.20130408.01:22:50
*
* Rule Set Name:
* TDB File Name:		C:\Users\vinig\Downloads\arquivos leiaute\inversor.tdb
* Command File:		C:\Users\vinig\Downloads\arquivos leiaute\ams035.ext
* Cell Name:			XOR
* Write Flat:			NO
********************************************************************************



****************************************
.include ams35ps_T-Spice.lib

V1 vdd 0 DC 3.3V

VinA A gnd pulse (3.3 0 0 0.1ns 0.1ns 4ns 8ns)
VinB B gnd pulse (3.3 0 0 0.1ns 0.1ns 2ns 4ns)

M1 A1_temp1 A gnd 1 MODN l=3e-007 w=3.45e-006  $ (-15.65 -7.3 -15.35 -3.85)
M2 2 A1_temp1 gnd 1 MODN l=3e-007 w=2.4e-006  $ (-10.7 -6.75 -10.4 -4.35)
M3 A1_temp2 B 2 1 MODN l=3e-007 w=2.4e-006  $ (-9.8 -6.75 -9.5 -4.35)
M4 Temp1 A1_temp2 gnd 1 MODN l=3e-007 w=3.45e-006  $ (-5.4 -7.3 -5.1 -3.85)
M5 gnd Temp1 Temp 1 MODN l=3e-007 w=1.2e-006  $ (-2.05 -7.35 -1.75 -6.15)
M6 Temp Temp2 gnd 1 MODN l=3e-007 w=1.2e-006  $ (-0.75 -7.35 -0.45 -6.15)
M7 out Temp gnd 1 MODN l=3e-007 w=3.45e-006  $ (2.65 -7.3 2.95 -3.85)
M8 gnd A_temp2 Temp2 1 MODN l=3e-007 w=3.45e-006  $ (6.55 -7.3 6.85 -3.85)
M9 3 A A_temp2 1 MODN l=3e-007 w=2.4e-006  $ (10.95 -6.75 11.25 -4.35)
M10 gnd A_temp1 3 1 MODN l=3e-007 w=2.4e-006  $ (11.85 -6.75 12.15 -4.35)
M11 gnd B A_temp1 1 MODN l=3e-007 w=3.45e-006  $ (16.8 -7.3 17.1 -3.85)
M12 A1_temp1 A vdd 4 MODP l=3e-007 w=2.75e-006  $ (-15.65 -2.75 -15.35 0)
M13 A1_temp2 A1_temp1 vdd 4 MODP l=3e-007 w=2.4e-006  $ (-10.7 -2.85 -10.4 -0.45)
M14 vdd B A1_temp2 4 MODP l=3e-007 w=2.4e-006  $ (-9.25 -2.85 -8.95 -0.45)
M15 Temp1 A1_temp2 vdd 4 MODP l=3e-007 w=2.75e-006  $ (-5.4 -3 -5.1 -0.25)
M16 5 Temp1 vdd 4 MODP l=3e-007 w=3.3e-006  $ (-2.05 -2.9 -1.75 0.4)
M17 Temp Temp2 5 4 MODP l=3e-007 w=3.3e-006  $ (-0.75 -2.9 -0.45 0.4)
M18 out Temp vdd 4 MODP l=3e-007 w=2.75e-006  $ (2.65 -2.75 2.95 0)
M19 vdd A_temp2 Temp2 4 MODP l=3e-007 w=2.75e-006  $ (6.55 -3 6.85 -0.25)
M20 A_temp2 A vdd 4 MODP l=3e-007 w=2.4e-006  $ (10.4 -2.85 10.7 -0.45)
M21 vdd A_temp1 A_temp2 4 MODP l=3e-007 w=2.4e-006  $ (11.85 -2.85 12.15 -0.45)
M22 vdd B A_temp1 4 MODP l=3e-007 w=2.75e-006  $ (16.8 -2.75 17.1 0)

.tran 0.1ns 15ns

.print V(A) V(B) V(out)

.measure tran pHL_xor trig v(B)   val = '3.3/2' fall = 2
+					   targ v(out)    val = '3.3/2' rise = 2

.measure tran pLH_xor trig v(B)   val = '3.3/2' rise = 2
+ 					   targ v(out)    val = '3.3/2' fall = 2

.measure tran tR_xor trig v(out) val = '3.3*0.2' rise = 1
+					  targ v(out)    val = '3.3*0.8' rise = 1

.measure tran tF_xor trig v(out) val = '3.3*0.8' fall = 1
+ 					  targ v(out)    val = '3.3*0.2' fall = 1

.end
* Top level device count
* M(NMOS)		11
* M(PMOS)		11
* Number of devices:	22
* Number of nodes:	17


