Rescoures for the artical "Gating kinetics of the nicotinic ACh receptor under time-varying ACh concentration"

About the code

ndwl.m and nd_ten.m respectively, the corresponding opening probability when [ACh] is a constant is calculated by inputting the corresponding parameter, at which point the solution is an exact solution.

jishuxishu.m is to compute the corresponding opening probability of [Ach](t) as a function of any time, e.g., linear or exponential, by entering the appropriate parameters

The first consideration is the probability decline phase, when the variation of the corresponding open probability is considered when the concentration shows a linear or exponential decay after the open probability reaches a stationary probability.

Linear decay:

ndxx.m is the computational code for calculating the open probability when [ACh](t) exhibits a linear decrease, at which point the linear decrease time is counted up to 0.4 ms.

decay_more04.m is the code for calculating the open probability when [ACh](t) exhibits a linear decline, when the maximum concentration as well as the linear decline time can be varied between, when the linear decline time can be any time greater than 0.4ms.

The exponential function decay:

ndke.m  is the code for calculating the open probability when [ACh](t) exhibits an exponential decrease, when the maximum concentration as well as the exponential rate of decrease, d, can be varied, and the larger d is the faster [ACh] decay.

The next consideration is the rising stage:

rising_stage_new.m At this point, the total time is set to 25ms, and the open probability is solved by considering different linear rise times as well as different maximum concentrations.

Finally considered is a complete variation of a vesicle releasing [ACh](t).

At this time, since the rising stage is very rapid, therefore, the concentration is set to rise by a linear step function for 0.1ms at this time, and the variation of the opening probability is observed by changing the concentration falling stage.

pre_linear_decay.m The case of a linear decrease in concentration is considered, where tt denotes that [ACh](t) is equal to the maximum concentration, the linear decrease time (delay time), and the time at which the concentration is zero.

pre_expon_decay.m The case of exponential decrease in concentration is considered, where tt denotes that [ACh](t) is equal to the maximum concentration, the exponential function decreases in time, and d denotes the rate of decrease.

exponential function fitting.py Fit single exponential as well as double exponential functions for the probability of opening via python
