#include <stdio.h>
int main()
{
	float dummy = 0;
	float e,u = 0;
	float b0 = 3.0;
	float b1 = -2.4;
	float a1 = -0.99;
	float dummy2 = 0;
	float f0,f1 = 0;

	int i = 0;
	for (i = 0;i<10;i++)
	{
		e = 1 - 0;
		f0 = e-dummy;
		u = b0*f0+dummy2;
		printf("%.3f\n",u);
		f1 = f0;
		dummy = (a1*f1);
		dummy2 = (b1*f1);
	}
return 0;
}


