***Este arquivo Spice precisa ser executado na Ferramenta T-Spice V16.0 ou superior, pertencente ao pacote da Tanner.
***Ele não funciona na Ferramenta LTSpice em virtude dela não printar os valores do comando .measure.

.include NMOS_VTG.inc
.include PMOS_VTG.inc


.subckt nand2 in in2 out vcc
M1 	vcc 	in 	out  	vcc   PMOS 	w='invWp'	l='length'
M2 	vcc 	in2 	out  	vcc   PMOS 	w='invWp'	l='length'
M3 	0 	in 	x   	0     NMOS 	w='invWn' 	l='length'
M4 	x 	in2 	out   	0     NMOS 	w='invWn' 	l='length'
.ends nand2


X1 in in2 out vcc nand2


C1 out  0 1.5fF

vcc  vcc 0 dc 1.0

vin1 in 0 pwl (0N  0  2N  0  2.012N  1	4N  1  4.012N  0)

vin2 in2 0 dc 1.0


.tran 1ps 8n

.measure tran t_HL 	trig v(in)  	val=0.5     fall = 1 
+               	targ v(out) 	val=0.5     rise = 1		
	 
.measure tran t_LH 	trig v(in) 	val=0.5     rise = 1 
+                    	targ v(out) 	val=0.5     fall = 1

.measure tran t_F 	trig v(out)  	val=0.9     fall = 1 
+               	targ v(out) 	val=0.1     fall = 1	

.measure tran t_R 	trig v(out)  	val=0.1     rise = 1 
+               	targ v(out) 	val=0.9     rise = 1	

*.measure tran consumo_HL integ 'p(vcc)*(fimIntervJan1-inicioIntervJan1)' from=3.1N to=5N
.measure tran consumo integ 'p(vcc)*(5-1.1)' from=1.1N to=5N

.param length = '50n'

.param InvWp = '0.02u * 1.5'
.param InvWn = '0.1u'

.print v(in) v(out) i(vcc)