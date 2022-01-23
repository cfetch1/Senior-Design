function[W_struct] = structure_nikolai(MTOW, AR, sweep, S, lambda, t_c, VeqMax)
    %inputs
    %MTOW=take off weight [lb]
    %N= ultimate load factor
    N=1.5;
    %AR= aspect ratio
    %Sweep= wing quarter chord sweep
    %Sw=wing area [ft^2]
    %lambda=wing taper ratio
    %t_c=maximum wing thickness ratio
    %Ve=equivalent maximum airpseed at sea level in knots
    W_struct=96.948*((((MTOW*N)/(10^5))^.65)*((AR/cosd(sweep))^.57)*((S/100)^.61)*(((1+lambda)/(2*t_c))^.36)*((1+(VeqMax/500))^.5))^.993;
    
end

