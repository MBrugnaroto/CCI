********************************************************************************
* SPICE netlist generated by HiPer Verify's NetList Extractor
*
* Extract Date/Time:	Mon Jul 01 13:32:07 2019
* L-Edit Version:		L-Edit Win64 16.01.20130408.01:22:50
*
* Rule Set Name:
* TDB File Name:		C:\Users\vinig\Downloads\arquivos leiaute\inversor.tdb
* Command File:		C:\Users\vinig\Downloads\arquivos leiaute\ams035.ext
* Cell Name:			AND
* Write Flat:			NO
********************************************************************************



****************************************
.include ams35ps_T-Spice.lib

V1 vdd 0 DC 3.3V

VinA A gnd pulse (3.3 0 0 0.1ns 0.1ns 4ns 8ns)
VinB B gnd pulse (3.3 0 0 0.1ns 0.1ns 2ns 4ns)

M1 B_temp1 B gnd 1 MODN l=3e-007 w=3.45e-006  $ (26.35 19 26.65 22.45)
M2 2 A gnd 1 MODN l=3e-007 w=2.4e-006  $ (31.35 19.55 31.65 21.95)
M3 B_temp2 B_temp1 2 1 MODN l=3e-007 w=2.4e-006  $ (32.3 19.55 32.6 21.95)
M4 out B_temp2 gnd 1 MODN l=3e-007 w=3.45e-006  $ (36.6 19 36.9 22.45)
M5 B_temp1 B vdd 3 MODP l=3e-007 w=2.75e-006  $ (26.35 23.55 26.65 26.3)
M6 B_temp2 A vdd 3 MODP l=3e-007 w=2.4e-006  $ (31.35 23.45 31.65 25.85)
M7 vdd B_temp1 B_temp2 3 MODP l=3e-007 w=2.4e-006  $ (32.75 23.45 33.05 25.85)
M8 out B_temp2 vdd 3 MODP l=3e-007 w=2.75e-006  $ (36.6 23.3 36.9 26.05)

.tran 0.1ns 10ns

.print v(A) V(B) v(B_temp1) v(out)

.end
* Top level device count
* M(NMOS)		3
* M(PMOS)		3
* Number of devices:	6
* Number of nodes:	9
