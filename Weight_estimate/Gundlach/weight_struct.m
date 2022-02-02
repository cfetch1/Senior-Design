function [W_struct] = weight_struct(S_exp,Fskins)
%THis assumes that the structure is filled with foam, this is probably not
%very likely. 
%Variables
%S_exp=exposed skin area of the aircraft
%Fskins=weight per exposed area of the minimum gauge structure
%F_fill=ratio of the voilume filled by foam to the total volume
%W_struct= this is the weiht ofthe foam strcutur eof interesst
%Rho_foam=density of the foam
%F_cov=weight per area of covering

W_skins=S_exp*Fskins;
W_struct=F_fill*V_struct*rho_foam+S_exp*F_cov;
W_struct=W_struct+W_skins; 
end

