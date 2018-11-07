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

int stop = 0;
int count[10]={0};

typedef struct
{
/*controller state variables should be declared here*/
SEM *semaphore;
	double b0;
	double b1;
	double a1;
	double ref;
}paramss;



void *Task2(void *data);

int main()
{

  paramss p2;
  p2.b0=0;
  p2.b1=0;
  p2.a1=0;
  p2.ref=0;

	printf("Input Params b0 b1 a1 ref:\n");
	scanf("%lf %lf %lf %lf",&p2.b0,&p2.b1,&p2.a1,&p2.ref);

	rt_allow_nonroot_hrt();
	pthread_t task2;

	RT_TASK *rt_task = rt_task_init(nam2num("h17ex1"),0,0,0);

	if (rt_task == NULL)
	{
		//rt_task_delete(rt_task);
		printf("Null pointer\n");
		return 1;
	}
	struct sched_param p;
	p.sched_priority = sched_get_priority_max(SCHED_FIFO);
	mlockall(MCL_CURRENT);
	sched_setscheduler(nam2num("h17ex1"),SCHED_FIFO,&p);


  
	//semaphore = rt_typed_sem_init(nam2num("h17se1"),1,BIN_SEM);


	pthread_create(&task2,NULL,Task2,&p2);

	
	rt_sleep(count2nano(100000));
	printf("finished waiting\n");
/*
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

*/

	stop =1;
	pthread_join(task2, NULL);
	rt_task_delete(rt_task);
	//rt_sem_delete(p2->semaphore);
	return 0;
}

void *Task2(void *data)
{
	
		printf("Task 2 started");	
		int error=0;

		double aux=0;
		double e=0;
		


		printf("task2\n");
		RT_TASK *rt_task = rt_task_init(nam2num("h17ex2"),0,0,0);
		rt_task_make_periodic_relative_ns(rt_task,0,1000000000);
		if (rt_task == NULL)
		{
			printf("Null pointer\n");
			return NULL;
		}

		statetype states;
		unsigned int samples=0;
		comedi_t* comedi=comedi_open("/dev/comedi2");



		//Assure correct transfor of parameters
		printf("b0 = %.f\n",((paramss*)data)->b0); 
		printf("b1 = %.f\n",((paramss*)data)->b1);
		printf("a1 = %.f\n",((paramss*)data)->a1);
		printf("ref = %.f\n",((paramss*)data)->ref);
			
		regul_init(&states);
		printf("regul_init\n");
		int i=0;
		while(i<10){
		i++;
		
		printf("before comedi\n");
		if(comedi_data_read_delayed(comedi,0,0,0,AREF_DIFF,&samples,50000)==-1)
	{
		printf("ERROR WHILE READING DATA\n" );
	}	
		printf("after comedi\n");
		aux = (double)samples;
		printf("test\n");
		printf("%.f\n",aux);
		e=((paramss*)data)->ref-aux;
		printf("test2\n");
		regul_out(&states,e,((paramss*)data)->b0);
		printf("Sample = %.f\n",aux);
		printf("output = %.f\n",states.u);
		if(comedi_data_write(comedi,1,0,0,AREF_GROUND,(unsigned int)states.u)==-1)
				{
					printf("ERROR WRITING DATA\n" );
				}

		printf("stuff\n");

		//rt_sem_wait(semaphore);

		//rt_sem_signal(semaphore);
		}
		printf("Errors: %d\n",error);
		if(comedi_close(comedi)==-1)
		{
		printf("connection not closed");
		}
		rt_task_delete(rt_task);
		return 0;
}
