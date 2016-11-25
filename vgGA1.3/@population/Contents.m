% vgGA toolbox
%
%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved                      *
%*   Manuel Valenzuela-Rendón                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Tecnológico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************
%
% Contents of @population/
%
% population/btournament
%    pop = btournament(pop,compare_function)
%    Implements binary tournament selection with a user provided
%    function that compares two individuals and returns true if
%    the first individual is beter or equal to the second individual.
%
% population/Contents
%    This file
%
% population/crossInheritance
%    pop = crossInheritance(pop)
%    Applies crossover with inheritance to members of a population.
%
% population/convergence
%    divergence = convergence(pop,type='phenotypic')
%    Calculates the diversity of the population given a type of convergence
%    used to measure it.
%
% population/crossover
%    pop = crossover(pop)
%    Applies crossover to members of a population.
%   
% population/display
%    display(pop)
%    Displays a population.
%   
% population/eraseWeak
%    pop = eraseWeak(pop,N=1)
%    Erases the weakest N individuals in the population.
%
% population/evaluate
%    pop = evaluate(pop,objective_function)
%    Evaluates population with objective_function
%
% population/evaluateInheritance
%    pop = evaluate(pop,objective_function,type='fixed')%
%    Evaluates population with objective_function and inheritance of type
%    type: 'c(onfidance)' 'e(rror)' 'f(ixed)' (default)
% 
% population/evaluateLast
%    pop = evaluateLast(pop,objective_function,N=1,setBestFlag=1)
%    Evaluate the last N individuals in the population.
%
% population/expRanking
%    pop = expRanking(pop,alpha=1)
%    Implements exponential ranking.
%
% population/fill
%    pop = nextMut(pop, value=0)
%    Fills the population with value at all individuals.
%
% population/generationalMOO
%    pop = generationalMOO(pop, cm, cd, sigma, w=1, alpha=1)
%    Evaluates a population for multiobjetive optimization. Does not evaluate 
%    the objective functions but rather it calculates the fitness of each 
%    individual as cm*m + cd*d where m es the niche count defined by a 
%    sharing function sh over objective functions space, and d is the number 
%    of individuals in the population that dominate the inidividual. w is a 
%    vector that weighs each objective function when calculating the niche 
%    count.
%
% population/get
%    value = get(pop,fieldname)
%    Returns the value of a given field.
%
% population/init
%    pop = init(pop)
%    Erases all the inidividuals and resets best.
%
% population/injection
%    pop = injection(pop,fraction,objective_function)
%    Retains the (fraction) best individuals and completes the 
%    population with random individuals which are evaluated with
%    objective_function.
%
% population/linRanking
%    pop = linRanking(pop,cMult=2)
%    Implements linear ranking.
%
% population/max
%    pop = max(pop)
%    Sets the population to maximization.
%
% population/min
%    pop = min(pop)
%    Sets the population to minimization.
%
% population/multiEvaluate
%    pop = multievaluate(pop,objective_functions)
%    Evaluates population with a list of objective_functions.
%
% population/multiEvaluateLast
%    pop = multiEvaluateLast(pop,objective_functions,N=1)
%    Evaluate the last N individuals in the population with a list of
%    objective_functions.
%
% population/mutation
%    pop = mutation(pop)
%    Applies mutation to all the members of a population.
%
% population/nextMut
%    pop = nextMut(pop,i)
%    Generates value to next mutation, over component i.
%
% population/nicheCount
%    pop = nicheCount(pop, sigma, type, alpha=1)
%    Calculates the niche count of type 'phenotypic'(default) or by
%    'fitness' with given sigma.
%
% population/plot
%    plot(pop)
%    Plots the individuals of a population
%    (Under contruction; do not use)

% population/population Class constructor
%    pop = population('integer',N,pm,pc,delta,dist,digits,B)
%    pop = population('real',R,N,pm,pc,delta,dist,digits,B)
%    Constructs a population of a given type ('integer' or 'real'). 
%
% population/random
%    pop = random(pop,n)
%    Generates a random population of size n.
%
% population/report
%    report(pop, fileID)
%    report(pop)
%    Reports a population to a file or to the screen.
%
% population/roulette
%    Implements roulette wheel selection.
%
% population/runGA
%    [pop, B] = runGA(pop, objective_function, generations)
%    [pop, B] = runGA(pop, objective_function, generations, report_file_name)
%    [pop, B] = runGA(pop, objective_function, generations,
%    report_file_name, permission)
%    Runs the GA cycle (selection, crossover, mutation) over a
%    population for the given number of generations.  A report of the
%    best found is displayed on screen and filed in the report_file.  If no
%    report_file_name is given, results are reported only to the screen. 
%    The default permission to open the report file is 'w'.
%
% population/scale
%    Implements linear scaling.
%
% population/set
%    pop = set(pop,fieldname,value)
%    Sets the value of a given field.
%
% population/share
%    pop = share(pop, sigma, type, alpha=1)
%    Implements sharing of type 'phenotypic'(default) or by 'fitness' with 
%    given sigma.
%
% population/sort
%    pop = sort(pop,type='phenotype',order='direct')
%    Sorts the population by phenotype or by fitness.
%
% population/startMut
%    pop = startMut(pop)
%    Starts or restarts the mutation clock.
%
% population/structures
%    Data structures in a population.
%
% population/SUS
%    Implements stochastic universal selection.
%
% population/tournament
%    pop = tournament(pop, m=2)
%    Implements tournament selection of size m.
%

