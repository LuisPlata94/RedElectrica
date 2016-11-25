% Data structures in a population
% 
% evals        : number of function evaluations so far
%
% params
%           max: 0, 1 maximization flag
%          type: 'integer', 'real'
%             m: number of segments
%          N[m]: digits per segment
%       rMin[m]: min value of segments
%       rMax[m]: max value of segments
%     DeltaR[m]: rMax - rMin
%         pm[m]: mutation probability
%            pc: crossover mutation
%          B[m]: base of segments
%      delta[m]: mutation delta (width)
%          dist: 'exponential', 'uniform'  
%        digits: 'traditional', 'generalized'
%         alpha: fraction of population to be evaluated when inheritance 
%                is applied
%          beta: confidance constant
%      weighted: 0, 1 weighted inheritance flag
%         error: inheritance error
% minConfidance: minimal confidance to evaluate 
%         dBest: display best?
%       dChroms: display chromosomes?
% 	     dPhenos: display phenotypes?
%       
%
% best
%          r[m]: phenotype
%       fitness: evaluation
%         evals: number of evaluation when found
% 
%    
% individual[<population size>]
%          r[m]: phenotype
%       fitness: evaluation used for selection
%         fEsti: evaluation estimated by inheritance
%         fTrue: true evaluation by objective function
%         iCtrl: inheritance control 
%           age: remaining cycles towards maturity
% 
% mutclock
%     DeltaI[m]: individuals to next mutation
%      kPlus[m]: value where next mutation will occur
%       mMax[m]: maximum digit for mutation
%      mPlus[m]: value where next mutation will occur
%
% trace
%         nMuts: number of mutations
%        nCross: number of crossovers
%          nIPC: number of Inter Parameter (segment) Crossovers
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
