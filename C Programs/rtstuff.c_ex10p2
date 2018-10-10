// RT Task program

#include <rtai_shm.h>
#include <rtai_lxrt.h>
#include <rtai_sched.h>
#include <sys/mman.h>
#include <sched.h>
#include <pthread.h>
#include <rtai_sem.h>

//struct sched_param {
//	int sched_priority;
//	};

int stop = 0;
SEM *semaphore;

void *Task2(void *data);

int main()
{
	printf("start main\n");
	rt_allow_nonroot_hrt();
	pthread_t task2;
	
	printf("test\n");
	RT_TASK *rt_task = rt_task_init(nam2num("h17ex1"),0,0,0);
	printf("test2\n");
	if (rt_task == NULL)
	{	
		//rt_task_delete(rt_task);
		printf("Null pointer\n");
		return 1;
	}
	printf("if done\n");
	struct sched_param p;
	p.sched_priority = sched_get_priority_max(SCHED_FIFO);
	mlockall(MCL_CURRENT);
	sched_setscheduler(nam2num("h17ex1"),SCHED_FIFO,&p);
	printf("Starting task\n");
	rt_task_make_periodic_relative_ns(rt_task,1000000000,1000000000);
	semaphore = rt_typed_sem_init(nam2num("h17se1"),0,BIN_SEM);
	

	pthread_create(&task2,NULL,Task2,semaphore);
	printf("thread created\n");
	int i=0;
	for (i=0;i<17;i++)
	{
		printf("main loop: %d\n",i);
		rt_task_wait_period();
		
			switch(i){
			case 0:
			case 8:
			case 12:
			case 14:
			case 15:
			rt_sem_signal(semaphore);
			break;
			case 16:
			stop = 1;
			}
	}
	pthread_join(task2, NULL);
	rt_task_delete(rt_task);
	rt_sem_delete(semaphore);
	return 0;
}

void *Task2(void *data)
{
		printf("task2\n");
		RT_TASK *rt_task = rt_task_init(nam2num("h17ex2"),0,0,0);
		
		if (rt_task == NULL)
		{
			printf("Null pointer\n");
			return NULL;	
		}
		RTIME period_old = rt_get_time_ns();
		
		printf("before while\n");
		/*while (stop == 0)
		{
			printf("whileloop\n");
			rt_sem_wait(semaphore);
			RTIME period = rt_get_time_ns();
			printf("Period: %llu\n",(period-period_old));
			period_old = period;
		}*/
		while(stop==0){
		if (rt_sem_wait(semaphore) == 0xFFFF){
			printf("failure\n");
			break;
		}
		RTIME period = rt_get_time_ns();
		printf("Period: %llu\n",(period-period_old));	
		period_old = period;
		}
		rt_task_delete(rt_task);
		return 0;
}
