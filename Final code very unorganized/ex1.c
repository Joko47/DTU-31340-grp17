// RT Task program

#include <rtai_shm.h>
#include <rtai_lxrt.h>
#include <rtai_sched.h>
#include <sys/mman.h>
#include <sched.h>

int main()
{
	rt_allow_nonroot_hrt();
	RT_TASK *rt_task = rt_task_init(nam2num("h17ex1"),0,0,0);
	if (rt_task == NULL)
	{
		printf("Null pointer");
		
	}
	else
	{
		printf("Press enter");
		unsigned long long start = rt_get_time_ns();
		char pressed = getchar();
		unsigned long long time = rt_get_time_ns();
		printf("Time is: %llu us\n",(time-start)/1000000);
		rt_task_delete(rt_task);
	}
	return 0;
}
