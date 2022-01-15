% weight estimation convergence

% secant method convergence - two initial weight guesses
% Wto_l = takeoff weight guess #1 - lower bound, summation of all fixed 
% Wto_u = takeoff weight guess #2 - upper bound
Wto_l = 436 ;
Wto_u = 436*2 ; % or pick any factor between 1.5-5

% Wcalc1 = equation that adds all components together (pretty much Wto_1)
% and add certain factors that are multiplied by Wto_1
% look at ch3 for these equations
Wcalc1 = summation of nonvarying weights + factors*Wto_l 
% get the weights of each component from kyle
Wcalc2 = summation of nonvarying weights + factors*Wto_2

% now incorporate difference functions:
diff1 = Wcalc1 - Wto_l ;
diff2 = Wcalc2 - Wto_u ;

tol = 0; % tolerance
count_max = 100;
count = 0;
W_TO1 = 436; %lbs
diff3=100;
Wto_new2 = 0 ;

while (diff3 > tol) && (count < count_max)
    count = count + 1;  

% new input weight
Wto_new1 = Wto_u - diff2*((Wto_u-Wto_l)/(diff2-diff1)) ;

% when diff3 = 0, the weights have converged
diff3 = Wto_new2 - Wto_new1 ;
Wto_new2 = Wto_new1 ;
 
end
Wto_new2
count


