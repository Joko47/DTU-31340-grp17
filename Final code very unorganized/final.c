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
#include "fixregul.h"

#define Ts 5249300 // Sample time in ns
#define CHUTEMID 3180 // Bit value for shute in middle

typedef struct
{
/*controller state variables should be declared here*/
SEM *semaphore;
	char run;
	float b0;
	float b1;
	float a1;
	float ref;
	double sticklength[100];
	double sticktime[100];
	int sticks;
	int stats;
	double b02;
	double b12;
	double a12;
	double ref2;
	int con;
	double l1;
	double l2;
	double l3;
}paramss;



void *Controller(void *data);
void *Controller2(void *data);
void *Stats(void *data);

int main()
{

// Create shared structure
  paramss p2;
  //Shute params
  p2.b0=85.96;
  p2.b1=-73.49;
  p2.a1=-0.4379;
  p2.ref=3180;
  //Belt params
  p2.b02=1.071;
  p2.b12=-0.9286;
  p2.a12=-1;
  p2.ref2=0.8;
  //Others
  p2.run=0;
  p2.sticks=0;
  p2.con=1;
  p2.stats=0;
  //Stick lengths
  p2.l1 = 5;
  p2.l2 = 7.5;
  p2.l3 = 10;
  
	
	
	int choice = 0; // Variable for menu	
	int active = 1; // Variable for while loop

	printf("main\n");
	rt_allow_nonroot_hrt(); // Allow nonroot acces
	
	// Create thread objects
	pthread_t controller_task;
	pthread_t controller2_task;
	pthread_t stats_task;

	//Start main task, with check on start
	RT_TASK *rt_task = rt_task_init(nam2num("h17ex1"),0,0,0);
	if (rt_task == NULL)
	{
		//rt_task_delete(rt_task);
		printf("Null pointer\n");
		return 1;
	}
		
	mlockall(MCL_CURRENT||MCL_FUTURE); // Setup memory lock
	

	// Setup scheduler
	struct sched_param p;
	p.sched_priority = sched_get_priority_max(SCHED_FIFO);
	sched_setscheduler(nam2num("h17ex1"),SCHED_FIFO,&p);
	rt_task_make_periodic_relative_ns(rt_task,0,1000000000);

	//Create tasks
	printf("creat tast\n");
	pthread_create(&controller_task,NULL,Controller,&p2);
	pthread_create(&controller2_task,NULL,Controller2,&p2);
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
		printf("4. Set Speed        \n");
		printf("8. Stop Controller  \n");
		printf("9. Start controller \n");
		printf("0. EXIT		    \n");
		scanf("%d",&choice);
		//printf("%.d\n",choice);	
		switch(choice){
		case 1:
			printf("Input Params b0 b1 a1:\n");
			printf("Chute regulator\n");
			scanf("%f %f %f",&p2.b0,&p2.b1,&p2.a1);
			printf("Belt regulator\n");
			scanf("%lf %lf %lf",&p2.b02,&p2.b12,&p2.a12);
			
			break;
		case 2:
			p2.stats = 1;
			break;
		case 3:
			printf("Input lengths short medium long:\n");
			scanf("%lf %lf %lf",&p2.l1,&p2.l2,&p2.l3);
			break;
		case 4:
			printf("Set speed [m/s]:\n");
			scanf("%lf",&p2.ref2);
			break;
		case 8:
			p2.run = 0;
			break;
		case 9:
			p2.run = 1;
			break;
		case 0:
			p2.run = 0;
			p2.con = 0;
			active = 0;
			break;
		default:
			printf("You chose: %.d\nInvalid option\n",choice);
		}
	}

	// Wait for other tasks to end
	pthread_join(controller_task, NULL);
	pthread_join(controller2_task, NULL);
	pthread_join(stats_task, NULL);

	// End this task
	rt_task_delete(rt_task);
	return 0;
}

void *Controller(void *data)
{	
		printf("Controller started\n");	
		paramss *my_data  = (paramss*)data;
		float aux=0; // Variable to hold sample
		float e=0; // Varialbe to hold error
		short em=0;
		float out=0;
		unsigned int samples=0; // Variable to hold raw sample
		int initoffset =0;
		
		// Create the task, and make periodic
		RT_TASK *rt_task = rt_task_init(nam2num("h17ex2"),0,0,0);
		rt_task_make_periodic_relative_ns(rt_task,0,Ts);
		if (rt_task == NULL)
		{
			printf("Null pointer\n");
			return NULL;
		}
		
		fixstatetype states;

		// Open link to comedi
		comedi_t* comedi=comedi_open("/dev/comedi2");
		if(comedi_data_read_delayed(comedi, 0, 1, 0, AREF_DIFF, &samples, 50000)==-1)
		{
			printf("ERROR WHILE READING DATA\n" );
		}
		initoffset = samples;
		// Initialise the controller
		fixregul_init(&states);
		//printf("regul_init\n");
		
		// While loop for controller
		// con = controller on, run = controller start
		while(my_data->con){
		rt_task_wait_period();
		while(my_data->run){
		rt_task_wait_period();
		// show parameters
	//	printf("b0 = %.f\n",my_data->b0); 
	//	printf("b1 = %.f\n",my_data->b1);
	//	printf("a1 = %.f\n",my_data->a1);
	//	printf("ref = %.f\n",my_data->ref);
			
		// Read samples
		//printf("before comedi\n");
		if(comedi_data_read_delayed(comedi,0,0,0,AREF_DIFF,&samples,50000)==-1)
		{
			printf("ERROR WHILE READING DATA\n" );
		}	
		//printf("after comedi\n");
		
		aux = (float)samples;
		//printf("Input: %.f\n",aux);
		
		e=my_data->ref-aux; // Calculate error
		em = (short)e;
		//printf("Error: %.f\n",e);
		
		// Calculate control signal
		fixregul_out(&states,em,my_data->b0);
		fixregul_update(&states,em,my_data->a1,my_data->b1);
		//printf("output = %.f\n",states.u);
		out=states.u*16;
		if (out < -2048){
			out = -2048;
		}
		else if(out > 2047){
			out = 2047;
		}
		
		printf("%lf\n",out);
		//else{
		//	states.u= states.u;
		//}
		//printf("out: %lf %d\n",states.u, (unsigned int)states.u);
		// Output the control signal
		if(comedi_data_write(comedi,1,0,0,AREF_GROUND,(unsigned int)out+2048)==-1)
				{
					printf("Chute ERROR WRITING DATA\n" );
				}
		
		
		}
		if(comedi_data_write(comedi,1,0,0,AREF_GROUND,2048)==-1)
				{
					printf("Chute ERROR WRITING DATA\n");
				}
		}
		// Close comedi connection
		if(comedi_close(comedi)==-1)
		{
		printf("connection not closed");
		}
		
		// Delete the task
		rt_task_delete(rt_task);
		return 0;
}

void *Controller2(void *data)
{	
		printf("Controller2 started\n");	
		paramss *my_data  = (paramss*)data;
		//double aux=0; // Variable to hold sample
		double e=0; // Varialbe to hold error
		int ref=0;
		lsampl_t samples=0; // Variable to hold raw sample
		
		// Create the task, and make periodic
		RT_TASK *rt_task = rt_task_init(nam2num("h17ex4"),0,0,0);
		rt_task_make_periodic_relative_ns(rt_task,0,Ts);
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
		rt_task_wait_period();
		if(comedi_data_read_delayed(comedi, 0, 1, 0, AREF_DIFF, &samples, 50000)==-1)
		{
			printf("ERROR WHILE READING DATA\n" );
		}
		ref = my_data->ref2 * 204.8*4.138 + 2048;
		e = (double)(ref-(int)samples);
		regul_out(&states, e, my_data->b02);
		
		//unsigned int data = round(states.u);
		unsigned int data = states.u;
		
		// output limit [2048;4095]
		if (data > 4095)
		data = 4095;
		else if(data < 2048)
		data = 2048;
		else 
		data = data;
		
		comedi_data_write(comedi, 1, 1, 0, AREF_GROUND, data);
		
		regul_update(&states, e, my_data->a12, my_data->b12);

		}
		comedi_data_write(comedi, 1, 1, 0, AREF_GROUND, 2048);
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
	printf("stats\n");
	int i = 0;
	double l = 0;
	int sticksort = 1;
	double a = 0;
	double dev = 0;
	int sorts, sortm, sortl;
	sorts = 0;
	sortm = 0;
	sortl = 0;
	paramss *my_data  = (paramss*)data;
	// Create task
	RT_TASK *rt_task = rt_task_init(nam2num("h17ex3"),0,0,0);
	rt_task_make_periodic_relative_ns(rt_task,0,Ts);
	if (rt_task == NULL)
	{
		printf("Null pointer\n");
		return NULL;
	}

	lsampl_t photo;
	comedi_t* comedi= comedi_open("/dev/comedi2");
//	printf("Stats thread\n");
	
	// While loop for statistics
	while(my_data->con){
	rt_task_wait_period();
	if(my_data->stats == 1){
	printf("sticks sorted: %.d\n",sticksort);
	printf("Stick deviation: ");
	for(i=1;i<sticksort+1;i++){
		a = my_data->sticklength[i];
		if (a < (my_data->l1+my_data->l2)/2){
			dev =(a-my_data->l1)/a;
		}
		else if(a > (my_data->l2+my_data->l3)/2){
			dev =(a-my_data->l3)/a;
		}
		else{
			dev =(a-my_data->l2)/a;
		}
		printf("%.2lf%% ",dev);
		
	}
	printf("\n");
	printf("    Sticks sorted into boxes   \n");
	printf("-------------------------------\n");
	printf("|  Short  |  Medium  |  Long  |\n");
	printf("|   %02d    |    %02d    |   %02d   |\n",sorts, sortm, sortl);
	printf("-------------------------------\n");
	my_data->stats = 0;
	}
	else
	{
		comedi_data_read_delayed(comedi, 0, 2, 0, AREF_DIFF, &photo, 500);
		if (photo >= 3000){
			i++;
		}
		else if(i != 0){
			l = ((Ts) / 10000000.0) * i * my_data->ref2;
					  
			my_data->sticks ++;
			my_data->sticklength[my_data->sticks] = l;
			my_data->sticktime[my_data->sticks] = (double)rt_get_cpu_time_ns()+(1/(my_data->ref2/1000000000)*0.34); //Get time for shute to move
			//printf("Length [cm]: %lf    i: %d   ref: %lf\n", l, i, my_data->ref2);
			//printf("%lf\n",(double)rt_get_cpu_time_ns());
			//printf("%lf\n",rt_get_cpu_time_ns());
			//printf("%lf\n",my_data->sticktime[my_data->sticks]);
			
			i=0; 
		}
		if (((double)rt_get_cpu_time_ns() >= my_data->sticktime[sticksort]) && (my_data->sticks >= sticksort)){			
			a = my_data->sticklength[sticksort];
			if (a < (my_data->l1+my_data->l2)/2){
				my_data->ref = CHUTEMID-180;
				sorts++;
			}
			else if(a > (my_data->l2+my_data->l3)/2){
				my_data->ref = CHUTEMID+180;
				sortl++;
			}
			else{
				my_data->ref = CHUTEMID;
				sortm++;
			}
			sticksort++;
			//printf("Ref: %lf\n", my_data->ref);
		}	
		
	}
	}
	
	
	// Delete task
	rt_task_delete(rt_task);
	
	return 0;
}

