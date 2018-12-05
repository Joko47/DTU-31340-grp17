// RT Task program

#include <rtai_shm.h>
#include <rtai_lxrt.h>
#include <rtai_sched.h>
#include <sys/mman.h>
#include <sched.h>
#include <pthread.h>
#include <rtai_sem.h>
#include "./uge11/regul.h"
#include  <comedilib.h>

void *Controller(void *data);
void *Stats(void *data);

typedef struct
{
/*controller state variables should be declared here*/
SEM *semaphore;
	char run;
	double b0;
	double b1;
	double a1;
	double ref;
	double sticklenght[20];
	int sticks;
}paramss;




int main()
{
	
  paramss p2;
  p2.b0=85.96;
  p2.b1=73.49;
  p2.a1=0.4379;
  p2.ref=0;
  p2.run=0;
	rt_allow_nonroot_hrt();

	pthread_t controller_task;
	pthread_t stats_task;

	RT_TASK *rt_task = rt_task_init(nam2num("h17e1x"),0,0,0);
	if (rt_task == NULL)
	{
		//rt_task_delete(rt_task);
		printf("Null pointer\n");
		return 1;
	}
	struct sched_param p;
	p.sched_priority = sched_get_priority_max(SCHED_FIFO);
	
	mlockall(MCL_CURRENT && MCL_FUTURE);
	
	sched_setscheduler(nam2num("h17e1x"),SCHED_FIFO,&p);
  
	//semaphore = rt_typed_sem_init(nam2num("h17se1"),1,BIN_SEM);

	pthread_create(&controller_task,NULL,Controller,&p2);
	pthread_create(&stats_task,NULL,Stats,&p2);
	
	rt_sleep(count2nano(100000));
	printf("finished waiting\n");
	pthread_join(controller_task, NULL);
	pthread_join(stats_task, NULL);

	rt_task_delete(rt_task);
	//rt_sem_delete(p2->semaphore);
	return 0;
}

void *Controller(void *data)
{	
		
		printf("Controller started");	
		
		RT_TASK *rt_task = rt_task_init(nam2num("h17e2x"),0,0,0);
		rt_task_make_periodic_relative_ns(rt_task,0,1000000000);
		if (rt_task == NULL)
		{
			printf("Null pointer\n");
			return NULL;
		}

		rt_task_delete(rt_task);
		return 0;
}

void *Stats(void *data){
	printf("Stats thread\n");
	RT_TASK *rt_task = rt_task_init(nam2num("h17e3x"),0,0,0);
		rt_task_make_periodic_relative_ns(rt_task,0,1000000000);
		if (rt_task == NULL)
		{
			printf("Null pointer\n");
			return NULL;
		}
	rt_task_delete(rt_task);
	return 0;
}
