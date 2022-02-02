function [W_emp] = weight_empen(Semp,tmin,rho_mat)
%Femp empennage multiplation factor
%Fcont=factor for th control surfaces
%Semp=empennage planform area ft^2
%tmin=minimum gauge thickness [in]
Femp=1.3;
Fcont=1.2;


W_emp=(1/6)*Femp*Fcont*Semp*tmin*rho_mat; %[lb]

end

