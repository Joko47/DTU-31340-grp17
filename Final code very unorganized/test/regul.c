typedef struct
{
/*controller state variables should be declared here*/
	double dummy,u;
}statetype;

void regul_init(statetype *p)
{
/*  This function should initialise the state variables of the controller */
	p->dummy=0;
} 

void regul_out(statetype *p, double e, double b0)
{ 
/*e is the input to the controller and  b0 is a parameter, more parameters may be added if necessary.*/ 
/* the function should return the controller output in the statetype */
	p->u=b0*e+p->dummy;
} 

void regul_update(statetype *p, double e, double a1, double b1)
{ 
/* this function should update the state variables of the controller */
     p->dummy=b1*e-a1*p->u;
} 
