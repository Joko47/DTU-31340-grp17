#include <stdio.h>
#include <math.h>

typedef struct
{
/*controller state variables should be declared here*/
	short dummy,u;
}fixstatetype;


short mul16(short fac1,short fac2,short exp){
long f1;
f1=fac1;
f1*=fac2;
f1+=(1l<<(14-exp));
if (exp>15)
  f1<<=1;
else
  f1>>=(15-exp);
if (f1 > 32767l)
  f1=32767l;
else
  if (f1 < -32768l)
    f1=-32768l;
return(f1);
}

short add16(short add1,short add2){
long t;
t=add1;
t+=add2;
if (t > 32767l)
  t=32767l;
else
  if(t < -32768l)
    t=-32768l;
return(t);
}

short sub16(short min,short sub){
long t;
t=min;
t-=sub;
if (t > 32767l)
  t=32767l;
else
  if(t < -32768l)
    t=-32768l;
return(t);
}


void fixregul_init(fixstatetype *p)
{
/*  This function should initialise the state variables of the controller */
	p->dummy=0;
} 

void fixregul_out(fixstatetype *p, short e, float b0)
{ 
short val1 =0 ;
short val2 = 0;
short res = 0;
/*e is the input to the controller and  b0 is a parameter, more parameters may be added if necessary.*/ 
/* the function should return the controller output in the statetype */
	val1=mul16((b0/128)*32768.0+0.5,e,1);
	val2=p->dummy;
	//printf("val1: %d\n",val1);
	//printf("val2: %d\n",val2);
	res = add16(val1,val2);
	//printf("res: %d\n",res);
	p->u=res;
} 

void fixregul_update(fixstatetype *p, short e, float a1, float b1)
{ 
	short val1 =0 ;
	short val2 = 0;
	short val3 = 0;
/* this function should update the state variables of the controller */
	val1=mul16((b1/128)*32768.0+0.5,e,1);
	val2=mul16(a1*32768.0+0.5,p->u,0);
	val3=sub16(val1,val2);
	
	p->dummy=val3;
} 


