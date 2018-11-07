#include <stdio.h>
int main()
{
	float dummy = 0;
	float e,u = 0;
	float b0 = 85.96;
	float b1 = -73.49;
	float a1 = -0.4379;
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


