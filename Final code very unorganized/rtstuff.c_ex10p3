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
int count[10]={0};
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

	semaphore = rt_typed_sem_init(nam2num("h17se1"),1,BIN_SEM);
	

	pthread_create(&task2,NULL,Task2,semaphore);
	printf("thread created\n");
	int i=0;
	int n=0;
	rt_sleep(count2nano(100000));
	printf("finished waiting\n");
	for (i=0;i<100000000;i++)
	{
		if (i%1000000==0) {
		printf("main loop: %d\n",i);
		}
		rt_sem_wait(semaphore);
		for(n=0;n<10;n++){
		count[n]=i;
		}
		rt_sem_signal(semaphore);
	}
	stop =1;
	pthread_join(task2, NULL);
	rt_task_delete(rt_task);
	rt_sem_delete(semaphore);
	return 0;
}

void *Task2(void *data)
{
		int val=0;
		int x=0;
		int error=0;
		printf("task2\n");
		RT_TASK *rt_task = rt_task_init(nam2num("h17ex2"),0,0,0);
		rt_task_make_periodic_relative_ns(rt_task,0,1000000);		
		if (rt_task == NULL)
		{
			printf("Null pointer\n");
			return NULL;	
		}
		
	
			
		printf("before while\n");
		
		while(stop==0){
		//if (rt_sem_wait(semaphore) == 0xFFFF){
		//	printf("failure\n");
		//	break;
		rt_task_wait_period();
		rt_sem_wait(semaphore);
		val = count[0];
		for(x=0;x<9;x++){
		if (val != count[x+1]){
			error++;
			break;
			}
		}
		rt_sem_signal(semaphore);
		}
		printf("Errors: %d\n",error);
		rt_task_delete(rt_task);
		return 0;
}
