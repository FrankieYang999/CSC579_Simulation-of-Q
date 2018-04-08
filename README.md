# my-project

1 Warming Up: M/M/1 queue (50 points)
In this section, as a warm-up, you will generate a Poisson process with rate  and simulate the
M/M/1 queueing system with service rate μ, based only on the standard uniform random number
generator from [0, 1]. (See Appendix on how to draw a random number from a given distribution
FX(x) from the uniform random number generator.) Equivalently, you will simulate the birth-
death Markov chain X(t) 2 
 for M/M/1 model based on the state transition diagram as covered
in class, where 
 = 0, 1, 2, . . . throughout in this project. The arrivals may represent aggregated
calls, HTTP requests, or ‘clicks’ on html links, etc. from a large population, which are all known
to follow a Poisson process (extension of the law of small numbers!). Each of the arrival is placed
in queue if the server is busy, and served on a first-come-first-serve (FCFS) basis.
Throughput, we assume that the buffer size is infinite (i.e., an arriving customer/job/packet is
never lost). For your actual simulation, you will have to assign a large enough memory space for
the buffer to ensure that nothing is lost there.
Define  = /μ < 1 for stability. For simplicity, set μ = 1 and we will vary  =  from
 2 {0.7, 0.8, 0.9, 0.95} (total 4 different values).
Your simulation program will terminate once N customers have completed their services. For initial
conditions, assume that at time t = 0 the system is empty. Draw a random number from exp() to
decide when the first arrival will occur, and then start your simulation by locating the first event,
then draw another random number to decide the next event, and so on.
You may want to keep the following information for each customer entering the system:
• ti, 1  i  N: the time instant at which the i-th customer arrives to the system.
• wi, 1  i  N: the total waiting time of the i-th customer in the system (queue + server).
Note that this i-th customer departs the system at ti + wi.
• X(ti), 1  i  N: the number of customers in the system seen by the i-th arrival. For
instance, X(t1) = 0 since the first customer arrives to (initially) empty system.
• Di, 1  i  N: the number of customers seen (left behind) by the i-th departure. Note
that you may have to generate more than N arrivals to ensure that N customers will have
departed by the end of your simulation (and some customers are still left in the queue!).
Using these values, you will measure the empirical distribution (ccdf) of the number of customers
in the system seen by the arrivals and departures based on N observations (events) and compare
them with the theoretical results you learned in class. In addition, while you are running the
simulations, you will also keep a record of whether or not the system is empty. In other words, you
There should be no library or module in your source code. You can only use the uniformly distributed random
number generator over [0, 1] that should be available in any program language. In other words, you will have to write
your code from scratch.
1
