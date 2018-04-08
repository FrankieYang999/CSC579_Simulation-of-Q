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
are also measuring Ns(t). To this end, whenever there is an ‘event’ (arrival or departure), update
this 1/0-valued process Ns(t) and obtain the duration of idle and busy periods. You have seen this
already in Problem 4 of the midterm exam, in which we used Ii,Bi to denote the i-th idle/busy
periods. Note that depending on  values (μ = 1 throughout still), out of N customer departure,
the number of idle/busy period samples may be well less than N. Say, you obtain M samples for
Bi (i = 1, 2, . . . ,M) by the end of your simulation (N-th departure). Then, you can obtain your
empirical distribution (histogram and then converted into ccdf)for B.
Specifically, do the following:
• Set N = 10, 000. For each of  value (out of 4 choices), repeat your simulations K = 10
times using different initial random seed. This way, you will obtain K = 10 datasets that are
presumably independent and identically distributed.
• For each of  value chosen and for each sample path (out of K independent runs), collect
X(ti) samples, 1  i  N. From this N-dimensional array for the histogram, convert this
into CCDF (another N-dimensional array) to estimate the probability that the number of
customers seen by an arrival is  n, for different (suitably chosen) values of n. You then
repeat this K − 1 more times, obtaining total K such CCDF plots (for the same value n).
Take average over K values (for a given n) and plot this estimated CCDF on a semi-log scale
(y-axis is log, x-axis is linear).
• Repeat the above for Di, the number of customers seen by i-th departure.
• For each of  value and for each run of your simulations (out of K independent runs), you
will obtain a number of samples for Bi (B1,B2, . . .). Once you have obtained K such set of
samples, compute the sample average and sample variance, and plot the CCDF on a semi-log
scale.
You should be able to measure all the quantities and obtain the empirical CCDF out of the
same simulation run, instead of running separately for X(ti),Di,Bi each. Then, answer/report the
following:
1. There will be total 8 plots (X(ti) and Di for 4 different values of ). Plot all these on the
same semi-log plot, and overlay another plot for the theoretical result as learned in class, i.e.,
P{X  k} = k, k = 0, 1, 2, . . . where X here is the number of customers in the system in
the steady-state (time average). What do you see here? Does PASTA property hold in your
simulation? Do your simulation results match well with the theory? If not, why? Discuss,
and suggest some ways to reduce the errors from simulations.
2. Plot 4 different cases (for 4 different  values) of CCDF of the busy-period on the same semi-
log scale. As seen in the midterm exam, you (will) know how to derive the Laplace transform
for the busy-period B for M/M/1 system. Although it is non-trivial to find the corresponding
distribution (inverse-Laplace transform), you can find E{B},Var{B} by differentiating the
Laplace transform properly. Compare this theoretical results with your numerical simulations.
Do they match well? Is B exponentially distributed? If not, what can you say about the
shape of the distribution (CCDF) of B based on your simulation results?
2 Plot Thickens: Multiple Queues with Scheduling (50 points +
20 extra points)
In this section, we will attempt to simulate a more realistic scenario with m multiple queues. These
m ‘servers + queues’ can model a data center or cloud, which is basically nothing but a collection
of servers (including buffer/queue) in a cluster (datacenter) or all over the places (cloud). Each
arriving customer (your ‘click’ or a file being uploaded to the cloud, etc) will be assigned to one of
m queues according to some scheduling policy.

First, consider the system in Figure 1, where each of Poisson arrivals is routed to one of m
queues with probability pi (p1 + p2 + · · · + pm = 1), independently of all others, and i-th queue
has infinite buffer and a single server with service time exponentially distributed with rate μi. As
you’ve learned in class and also from Problem 2 in the Midterm, you know that this system becomes
a collection of m independent M/M/1 queues, where the i-th queue has Poisson arrival of rate pi
and service rate of μi. For stability, we need to ensure pi < μi for i = 1, 2, . . . ,m.
In this setup as in Figure 1, answer the following (no simulation required) with your derivation
and explanations (up to 10 extra points):
1. Express the average waiting time (delay) of an arriving customer in terms of , pi, μi.
2. For what values of pi do we have minimum average waiting time in the whole system? Express
this optimal p
i in terms of , μi. This may require your self-study on some optimization
problem or inequality techniques. (give it a try!)
3. When μi = μ (all the same), what is the optimal values of pi to minimize the total average
waiting time? Is this expected?
From now on, let’s consider a more complicated system as depicted in Figure 2. Let Xi(t) be
the total number of customers (jobs) in Queue-i at time t, i = 1, 2, . . . ,m. An arriving customer at
time t will join Queue-i with probability proportional to f(Xi(t)), i.e., with probability f(Xi(t))
Pm
j=1 f(Xj (t))
for some pre-defined function f : Z+ ! R+. For instance, we can set f(x) = e−ax, a > 0, to denote
a system where the ‘scheduler’ assigns an arriving job more likely to a ‘less-crowded’ queue, to
control the maximal load out of m queues. If we set f(·) to be a constant function (not depending
on Xi(t)), then it reduces to the system in Figure 1.

Now, answer the following with your ‘detailed’ explanation (no simulation required) (up to 10
extra points):
1. Let f(x) = e−ax for some a > 0. In this case, for each i, is Xi(t) 2 
 a Markov chain?
Provide your reasoning.
2. How about a new process Y (t) = [X1(t),X2(t), · · · ,Xm(t)] 2 
m? Is Y (t) a Markov chain?
Provide your reasoning.
From this point on, we assume that μ1 = μ2 = · · · = μm = μ. Set m = 10 and μ = 1. One
trivial (not so bad!) policy would be f(·) = 1/m, i.e., each arrival is routed to one of m = 10
queues uniformly at random, independently of all others. The stability criterion in this case then
becomes  < mμ = 10μ. If we choose very large a > 0 (going to infinity) in f(x) = e−ax, you
can see that the policy reduces to choosing the queue with smallest number of customers at time
t, i.e., join the shortest queue policy. This would work out, hoping that the maximum queue size
(among m queues) is controlled in some sense (smaller than the case of f(·) = 1/m, but will
become a real problem with heavy-computational burden if m is very large. Imagine a realistic
cloud or server farm, which typically has thousands or tens of thousands of servers in a cluster, with
millions of arrivals per second and if one has to find the smallest queue for each of those arrivals
by sweeping/checking all m queues. Thus, as a practical compromise, more popular and recently
proposed policy is so-called power-of-two-choices policy. In this policy, for each arrival, we choose
two queues out of m uniformly at random (choose one from m and another from remaining m−1,
all uniformly at random), say, queue i and j. Then, this arriving job is routed to one of these
two queues (i or j) that has smaller number of customers therein (smaller of the randomly chosen
two). This way, one can quickly assign each arriving job to one of m queues without checking all m
queues, hoping that this power-of-two policy mimics the performance of the join-the-smallest-queue
policy.
Specifically, perform the following simulations and answer/report the questions (total 50
points):
1. Set m = 10 and μi = μ = 1. Choose  2 {7, 8, 9, 9.5} (4 different values). For each of , you
will run the simulation until total N = 50, 000 arrivals to the system, and repeat each of your
run K = 10 times and take the average over 10 independent runs as before.

2. Simulate the ‘join-the-shortest-queue’ policy and measure the CCDF of the total waiting
time in the whole system. Specifically, for each arrival, measure how long this job stays in
the system, and you will then get N measurements (for N customers total). Out of this
N-dimensional array, get CCDF (another N-dim array), and take average over K = 10 such
arrays to report. Plot your results on the same semi-log scale figure as before.
3. Repeat the above under the ‘power-of-two-choices’ policy.
4. For each choice of , plot all the CCDF results on a same figure (total 8 plots, 4 from each
policy). Overlay onto these figures the theoretical results for ‘uniform-random policy’ in which
an arriving customer is assigned to one of m queues uniformly at random (i.e., f(·) = 1/m),
for which we know that the total waiting time becomes exponentially distributed with rate
μ − /m > 0. When comparing all the figures, make sure to use semi-log scale (log y-axis,
linear x-axis).
5. Then, discuss your results. Which scheduling policy performs the best (smaller waiting time)?
Are the CCDF ‘ordered’ everywhere (or the plot ‘cross-over’)? Does the power-of-two-choices
policy perform similar to the ‘join-the-shortest-queue’ policy, or to the uniform-random pol-
icy? Does this similarity (if any) depend on the choice of ? Discuss. Do you have any better
idea to control the maximum load (maximum number of customers waiting among m queues)
without too much computational burden?
General Guidelines:
• This is an individual simulation project. Use computer-generated plot to report your simula-
tion results. Hand-drawn figures for your simulation results are not allowed.
• You can use MS-word or latex or any other standard word-processor to make your report.
Convert (or print) your report into pdf. In your report, for each figure you plot, make sure
to clearly indicate the scale and label for x, y axis, along with your explanation or legend to
indicate which curve is for which setting.
• For submission, email me your pdf report attachment and your source code as attachments
by the midnight on the date it’s due. At this moment, I do not know how to set up the online
submission system in Moodle, but I will let you know if I figure it out. Until then, by default,
please submit your report and source codes by email. In case you have multiple source codes,
zip them and name it using your unity in the form of login-ID-project1.zip. Same for your
report in pdf.
• Within a week after your submission, I will set up an individual meeting with each of you
during my office hours (or any other time frame of your choice if agreed), during which you
will demonstrate that your simulation is running as in your report. This will probably take
no more than 15 minutes of your time.
• Whenever possible, please use the standard programming language, e.g., C, C++, Matlab,
etc. Again, other than the standard random number generator, no library or module is
allowed in your simulation.
