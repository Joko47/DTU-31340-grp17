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

typedef struct
{
/*controller state variables should be declared here*/
SEM *semaphore;
	char run;
	double b0;
	double b1;
	double a1;
	double ref;
	double sticklength[20];
	int sticks;
	int stats;
	double b02;
	double b12;
	double a12;
	double ref2;
	int con;
}paramss;



void *Controller(void *data);
//void *Controller2(void *data);
void *Stats(void *data);

int main()
{

// Create shared structure
  paramss p2;
  p2.b0=85.96;
  p2.b1=-73.49;
  p2.a1=-0.4379;
  p2.ref=0;
  p2.b02=0;
  p2.b12=0;
  p2.a12=0;
  p2.ref2=0;
  p2.run=0;
  p2.sticks=0;
  p2.con=1;
  p2.stats=0;
	
	
	int choice = 0; // Variable for menu	
	int active = 1; // Variable for while loop

	printf("main\n");
	rt_allow_nonroot_hrt(); // Allow nonroot acces

	// Create thread objects
	pthread_t controller_task;
	//pthread_t controller2_task;
	pthread_t stats_task;

	//Start main task, with check on start
	RT_TASK *rt_task = rt_task_init(nam2num("h17ex1"),0,0,0);
	if (rt_task == NULL)
	{
		//rt_task_delete(rt_task);
		printf("Null pointer\n");
		return 1;
	}
		
	mlockall(MCL_CURRENT); // Setup memory lock
	

	// Setup scheduler
	struct sched_param p;
	p.sched_priority = sched_get_priority_max(SCHED_FIFO);
	sched_setscheduler(nam2num("h17ex1"),SCHED_FIFO,&p);
	rt_task_make_periodic_relative_ns(rt_task,0,1000000000);

	//Create tasks
	printf("creat tast\n");
	pthread_create(&controller_task,NULL,Controller,&p2);
	//pthread_create(&controller2_task,NULL,Controller2,&p2);
	//printf("create task\n");
	pthread_create(&stats_task,NULL,Stats,&p2);
	
	printf("sleeping\n");
			
	// Sleep to give tasks time to be created
	rt_sleep(count2nano(1700));
	printf("finished waiting\n");

	// While loop to make menu
	while(active){
		printf("        Menu        \n");
		printf("--------------------\n");
		printf("1. Change parameters\n");
		printf("2. See statistics   \n");
		printf("3. Set stick lenghts\n");
		printf("8. Stop Controller  \n");
		printf("9. Start controller \n");
		printf("0. EXIT		    \n");
		scanf("%d",&choice);
		printf("%.d\n",choice);	
		switch(choice){
		case 1:
			printf("Input Params b0 b1 a1:\n");
			scanf("%lf %lf %lf",&p2.b0,&p2.b1,&p2.a1);
			break;
		case 2:
			p2.stats = 1;
			break;
		case 8:
			p2.run = 0;
			break;
		case 9:
			p2.run = 1;
			//rt_sleep(count2nano(999999));
			//printf("b\n");
			//getchar();
			//getchar();
			//p2.run = 0;
			break;
		case 0:
			p2.con = 0;
			active = 0;
			break;
		default:
			printf("You chose: %.d\n",choice);
		}
	}

	// Wait for other tasks to end
	pthread_join(controller_task, NULL);
	pthread_join(stats_task, NULL);

	// End this task
	rt_task_delete(rt_task);
	return 0;
}

void *Controller(void *data)
{	
		printf("Controller started\n");	
		paramss *my_data  = (paramss*)data;
		//double aux=0; // Variable to hold sample
		//double e=0; // Varialbe to hold error
		//unsigned int samples=0; // Variable to hold raw sample
		
		// Create the task, and make periodic
		RT_TASK *rt_task = rt_task_init(nam2num("h17ex2"),0,0,0);
		rt_task_make_periodic_relative_ns(rt_task,0,1000000000);
		if (rt_task == NULL)
		{
			printf("Null pointer\n");
			return NULL;
		}
		
		statetype states;

		// Open link to comedi
		//comedi_t* comedi=comedi_open("/dev/comedi2");

		// Initialise the controller
		regul_init(&states);
		//printf("regul_init\n");
		
		// While loop for controller
		// con = controller on, run = controller start
		while(my_data->con){
		rt_task_wait_period();
		while(my_data->run){
		
		// show parameters
		printf("b0 = %.f\n",my_data->b0); 
	//	printf("b1 = %.f\n",my_data->b1);
	//	printf("a1 = %.f\n",my_data->a1);
	//	printf("ref = %.f\n",my_data->ref);
		/*	
		// Read samples
		printf("before comedi\n");
		if(comedi_data_read_delayed(comedi,0,0,0,AREF_DIFF,&samples,50000)==-1)
		{
			printf("ERROR WHILE READING DATA\n" );
		}	
		printf("after comedi\n");
		
		aux = (double)samples;
		printf("%.f\n",aux);
		
		e=my_data->ref-aux; // Calculate error
		printf("%.f\n",e);
		
		// Calculate control signal
		regul_out(&states,e,my_data->b0);
		regul_update(&states,e,my_data->a1,my_data->b1);
		printf("output = %.f\n",states.u);
		
		// Output the control signal
		if(comedi_data_write(comedi,1,0,0,AREF_GROUND,(unsigned int)states.u)==-1)
				{
					printf("ERROR WRITING DATA\n" );
				}
		*/
		
		}
		}
		// Close comedi connection
		/*if(comedi_close(comedi)==-1)
		{
		printf("connection not closed");
		}
		*/
		// Delete the task
		rt_task_delete(rt_task);
		return 0;
}

void *Controller2(void *data)
{	
		printf("Controller2 started\n");	
		paramss *my_data  = (paramss*)data;
		double aux=0; // Variable to hold sample
		double e=0; // Varialbe to hold error
		unsigned int samples=0; // Variable to hold raw sample
		
		// Create the task, and make periodic
		RT_TASK *rt_task = rt_task_init(nam2num("h17ex4"),0,0,0);
		rt_task_make_periodic_relative_ns(rt_task,0,1000000000);
		if (rt_task == NULL)
		{
			printf("Null pointer\n");
			return NULL;
		}
		
		statetype states;

		// Open link to comedi
		comedi_t* comedi=comedi_open("/dev/comedi2");

		// Initialise the controller
		regul_init(&states);
		printf("regul_init\n");
		
		// While loop for controller
		// con = controller on, run = controller start
		while(my_data->con){
		rt_task_wait_period();
		while(my_data->run){
		
		// show parameters
		printf("b0 = %.f\n",my_data->b02); 
		printf("b1 = %.f\n",my_data->b12);
		printf("a1 = %.f\n",my_data->a12);
		printf("ref = %.f\n",my_data->ref2);
			
		// Read samples
		printf("before comedi\n");
		if(comedi_data_read_delayed(comedi,0,0,0,AREF_DIFF,&samples,50000)==-1)
		{
			printf("ERROR WHILE READING DATA\n" );
		}	
		printf("after comedi\n");
		
		aux = (double)samples;
		printf("%.f\n",aux);
		
		e=my_data->ref-aux; // Calculate error
		printf("%.f\n",e);
		
		// Calculate control
		regul_out(&states,e,my_data->b02);
		regul_update(&states,e,my_data->a12,my_data->b12);
		printf("output = %.f\n",states.u);
		
		// Output the control signal
		/*if(comedi_data_write(comedi,1,0,0,AREF_GROUND,(unsigned int)states.u)==-1)
				{
					printf("ERROR WRITING DATA\n" );
				}
		*/
		
		}
		}
		// Close comedi connection
		if(comedi_close(comedi)==-1)
		{
		printf("connection not closed\n");
		}
		
		// Delete the task
		rt_task_delete(rt_task);
		return 0;
}

void *Stats(void *data){
	paramss *my_data  = (paramss*)data;
	// Create task
	RT_TASK *rt_task = rt_task_init(nam2num("h17ex3"),0,0,0);
	rt_task_make_periodic_relative_ns(rt_task,0,1000000000);
	if (rt_task == NULL)
	{
		printf("Null pointer\n");
		return NULL;
	}

//	printf("Stats thread\n");
	
	// While loop for statistics
	while(my_data->con){
	rt_task_wait_period();
	if(my_data->stats == 1){
	printf("sticks = %.d\n",my_data->sticks);
	my_data->stats = 0;
	}
	}
	
	// Delete task
	rt_task_delete(rt_task);
	
	return 0;
}
