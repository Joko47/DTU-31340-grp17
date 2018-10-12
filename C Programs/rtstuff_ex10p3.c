// RT Task program
#include <rtai_shm.h>
#include <rtai_lxrt.h>
#include <rtai_sched.h>
#include <sys/mman.h>
#include <sched.h>
#include <pthread.h>
#include <rtai_sem.h>


int stop = 0; 			//stop flag
int count[10]={0};	//array

SEM *semaphore;			//the semaphore

int i=0; //used in loop
int n=0; //used in loop


void *Task2(void *data);//thread2s task

int main()
{
	rt_allow_nonroot_hrt();

	//thread for task 2
	pthread_t task2;

	//creates main task
	RT_TASK *rt_task = rt_task_init(nam2num("h17ex1"),0,0,0);


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

	//nInitializing the semaphore as 1
	semaphore = rt_typed_sem_init(nam2num("h17se1"),1,BIN_SEM);

	//starting thread
	pthread_create(&task2,NULL,Task2,semaphore);

	//waits cycles corresponding to 1000000 ns to give time to lauch second thread
	rt_sleep(count2nano(100000)); //I think it should be nano2count cuz rt_sleep receives clock cycles
	printf("finished waiting\n");

	//changes array 100 000 000 times
	for (i=0;i<100000000;i++)
	{
		//print to check if its still working
		if (i%1000000==0) {
			printf("main loop: %d\n",i);
		}

		rt_sem_wait(semaphore);	//protects the array from being used by another thread

		//changes the array
		for(n=0;n<10;n++){
			count[n]=i;
		}
		rt_sem_signal(semaphore);	//lets the array be used by another flag
	}

	stop = 1; //stops second program's loop

	//stops task 2 (probably unecessary)
	pthread_join(task2, NULL);

	//delete main task
	rt_task_delete(rt_task);

	//deletes semaphore
	rt_sem_delete(semaphore);

	return 0;
}

void *Task2(void *data)
{
		int x=0;	//used in the array
		int error=0; //used to count error
		printf("task2\n");

		//creates a second task
		RT_TASK *rt_task = rt_task_init(nam2num("h17ex2"),0,0,0);

		//set the period of the task
		rt_task_make_periodic_relative_ns(rt_task,0,1000000);

		//check if task was created successfully
		if (rt_task == NULL)
		{
			printf("Null pointer\n");
			return NULL;
		}


		printf("before while\n");

		while(stop==0){

		//waits a period
		rt_task_wait_period();

		rt_sem_wait(semaphore); //waits for the semaphore to unset

		//checks if all array elements are the same
		for(x=0;x<9;x++){
		if (count[0] != count[x+1]){
			error++;
			break;
			}
		}

		rt_sem_signal(semaphore); //finishes using semaphore
		}

		printf("Errors: %d\n",error);

		rt_task_delete(rt_task); //stops task2

		return 0;
}
