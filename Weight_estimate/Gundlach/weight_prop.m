function [w_prop] = weight_prop(Nprop,D,N_blades,P_max)
%Variables
%Kprop=multiplication factor
Kprop=15;
%Nprop=number of propellers
%D=propeller diameter in feet
%N_blades=number of blades for each propeller
%P_max=max shaft horseppwoer
w_prop=Kprop*Nprop*N_blades^.391*((D*P_max)/(1000*Nprop))^.782; %[lb]

end

