// RT Task program

#include <rtai_shm.h>
#include <rtai_lxrt.h>
#include <rtai_sched.h>
#include <sys/mman.h>
#include <sched.h>
#include <pthread.h>

//struct sched_param {
//	int sched_priority;
//	};

int stop = 0;

void *Task2(void *data);

int main()
{
	rt_allow_nonroot_hrt();
	pthread_t task2;
	char quit = 'a';
	mlockall(MCL_CURRENT);
	

		pthread_create(&task2,NULL,Task2,NULL);
		
		while (stop == 0)
		{
			quit = getchar();
			if (quit == 'q')
			{
				stop = 1;
			}
		}
		pthread_join(task2, NULL);
		
	return 0;
}

void *Task2(void *data)
{
		RT_TASK *rt_task = rt_task_init(nam2num("h17ex1"),0,0,0);
		struct sched_param p;
		p.sched_priority = sched_get_priority_max(SCHED_FIFO);
	
		
	
		sched_setscheduler(nam2num("h17ex1"),SCHED_FIFO,&p);
		rt_task_make_periodic_relative_ns(rt_task,1000000000,1000000000);
	
		RTIME period_old = rt_get_time_ns();
		if (rt_task == NULL)
		{
			printf("Null pointer");
			return NULL;
		}
	
		while (stop == 0)
		{
			printf("test");
	
			rt_task_wait_period();
			RTIME period = rt_get_time_ns();
			printf("Period: %llu\n",(period-period_old));
			period_old = period;
		}
		rt_task_delete(rt_task);
		return 0;
}
