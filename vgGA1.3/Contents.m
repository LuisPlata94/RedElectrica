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
% @population/
%    Population class
%    
% Documentation/
%    Still empty; should contain documentation about the vgGA.
%
% Gfuns/
%    Functions that operate on integers with generalized digits.
%
% Ifuns/
%    Functions that operate on integers with traditional digits.
% 
% conemax
%    Implements the consecutive one max function
%
% convert
%    Converts a vector of digits and a vector of deltas
%    into a number.  Both digit and delta must be integers.
%
% crossAt
%    Performs crossover of r1 and r2 at value k. The numbers 
%    r1 and r2 take a minimal value or rMin.
%
% crossPoint
%    Returns the crossover point for a vgGA
%  
% debf1
%    Implements Deb's function F1 (used to test sharing)
%
% debf2
%    Implements Deb's function F2 (used to test sharing)
%
% digit
%    Digit of weight n/B, base B, of number p. Works only
%    for integers.
%
% generalized
%    Truncates to traditional digits.
%
% high
%    High part of number r starting with value k. The number 
%    r takes a minimal value of rMin. 
%   
% highh
%    Hard to explain but the analoguos of the digits of the
%    high part of number r up to value k. The number r
%   takes a minimal value of rMin.
%
% logB
%    Returns the log_B(x,B) 
% 
% low
%    Low part of number r up to value k. The number r
%    takes a minimal value of rMin.
%  
% mutate
%    Returns the mutation of r at value k. The number r 
%    takes a minimal value of rMin (default = 0). Works for 
%    integers and reals.
%  
% mutateGen
%    Returns the mutation of r at value k which is a generalized
%    digit value. This function implements the gamma correction. 
% 
% mutValues
%    Returns a vector of all the possible results of the 
%    mutation of r at value k. The number r takes a minimal 
%    value of rMin (default = 0). Works for integers and 
%    reals.
%  
% onemax
%   Implements the function onemax(x(1),B) + onemax(x(2),B) + ...
%
% plotGA
%    This function repeatedly calls runGA to generate a 
%    best-found curve, where n is the number of runs to be
%    performed and seed is the random generator seed. 
%    See population for a description of the parameters.
%    
% segment
%    Segment of width delta starting at, and incluiding,
%    value k. (delta >= 2). Works for integer and reals.
%
% testBtour
%    Function used to test btournament
%
% testscale
%    Function is used to demonstrate the need for fitness
%    scaling.
%
% traditional
%   Truncates to traditional digits.
%
% X
%   Implements the function x(1) + x(2) + ...
%      
% X2Y2
%   Implements the function x(1)^2 + x(2)^2 + ...
%
% zeromax
%   Implements the function zeromax(x(1),B) + zeromax(x(2),B) + ...
