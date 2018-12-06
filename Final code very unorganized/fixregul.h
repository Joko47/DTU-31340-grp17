typedef struct
{
/*controller state variables should be declared here*/
	short dummy,u;
}fixstatetype;


short mul16(short fac1,short fac2,short exp);
short add16(short add1,short add2);
short sub16(short min,short sub);
void fixregul_init(fixstatetype *p);
void fixregul_out(fixstatetype *p, short e, float b0);
void fixregul_update(fixstatetype *p, short e, float a1, float b1);
 


