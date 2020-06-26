***Descricao de um inversor na forma de um subcircuito***

***Este arquivo Spice precisa ser executado na Ferramenta T-Spice V16.0 ou superior, pertencente ao pacote da Tanner.
***Ele não funciona na Ferramenta LTSpice em virtude dela não printar os valores do comando .measure.

.include NMOS_VTG.inc
.include PMOS_VTG.inc

.subckt inv in out vcc
M1 	vcc 	in 	out  	vcc   PMOS 	w='invWp'	l='length'
M2 	0 		in 	out   0     NMOS 	w='invWn' 	l='length'
.ends inv

X1 in out vcc inv

C1 out  0 1.5fF

vcc  vcc 0 dc 1.0

vin1 in 0 pwl (0N 	0	2N 	0		2.012N	1	4N		1	4.012N	0)


.tran 1ps 8n

.measure tran pHL_inv 	trig v(in)  	val=0.5 		rise = 1 
+               		  	targ v(out) 	val=0.5     fall = 1		
	 
.measure tran pLH_inv 	trig v(in) 	 	val=0.5 		fall = 1 
+                    	targ v(out) 	val=0.5     rise = 1

.measure tran consumoCaso1_HL integ 'p(vcc)*(3-1.1)' from=1.1N to=3N
.measure tran consumoCaso1_LH integ 'p(vcc)*(5-3.1)' from=3.1N to=5N
*.measure tran consumoCaso1_HL integ 'p(vcc)*(fimIntervJan1-inicioIntervJan1)' from=3.1N to=5N

.param length = '50n'

.param InvWp = '0.1u * 1.5'
.param InvWn = '0.1u'

.print v(in) v(out) i(vcc)