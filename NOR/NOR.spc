********************************************************************************
* SPICE netlist generated by HiPer Verify's NetList Extractor
*
* Extract Date/Time:	Mon Jul 01 14:59:14 2019
* L-Edit Version:		L-Edit Win64 16.01.20130408.01:22:50
*
* Rule Set Name:
* TDB File Name:		C:\Users\vinig\Downloads\arquivos leiaute\inversor.tdb
* Command File:		C:\Users\vinig\Downloads\arquivos leiaute\ams035.ext
* Cell Name:			NOR
* Write Flat:			NO
********************************************************************************



****************************************
.include ams35ps_T-Spice.lib

V1 vdd 0 DC 3.3V

VinA A gnd pulse (3.3 0 0 0.1ns 0.1ns 4ns 8ns)
VinB B gnd pulse (3.3 0 0 0.1ns 0.1ns 2ns 4ns)

M1 gnd A out 1 MODN l=3e-007 w=1.2e-006  $ (-7.55 -5.35 -7.25 -4.15)
M2 out B gnd 1 MODN l=3e-007 w=1.2e-006  $ (-6.25 -5.35 -5.95 -4.15)
M3 2 A vdd 3 MODP l=3e-007 w=3.3e-006  $ (-7.55 -2.6 -7.25 0.7)
M4 out B 2 3 MODP l=3e-007 w=3.3e-006  $ (-6.25 -2.6 -5.95 0.7)

.tran 0.1ns 10ns

.print v(B) v(A) v(out)

.measure tran pHL_nor trig v(B) val = '3.3/2' rise = 1
+							targ v(out) val = '3.3/2' fall = 1

.measure tran pLH_nor trig v(B) val = '3.3/2' fall = 2
+ 							targ v(out) val = '3.3/2' rise = 2

.measure tran tR_nor trig v(out) val = '3.3*0.2' rise = 1
+							targ v(out) val = '3.3*0.8' rise = 1

.measure tran tF_nor trig v(out) val = '3.3*0.8' fall = 1
+ 							targ v(out) val = '3.3*0.2' fall = 1

.end

* Top level device count
* M(NMOS)		2
* M(PMOS)		2
* Number of devices:	4
* Number of nodes:	8


