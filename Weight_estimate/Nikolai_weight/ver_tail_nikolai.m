function [W_ver_tail] = ver_tail_nikolai(MTOW,S_v,bv,t_rv)
    %Sv = vertical tail area [ft^2]
    %bv=vertical tail span [ft]
    %tvr=vertical tail maximum root thickeness [in]
    t_rv=t_rv*12; %[in]
    N=1.5;
    W_ver_tail=98.5*((((MTOW*N)/(10^5))^.87)*((S_v/100)^1.2)*((bv/t_rv)^.5));
end

