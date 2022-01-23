function [W_h_tail] = Hor_tail_nikolai(MTOW, S_h,lt,t_rh,bh)
    %S_h horizontal tail area [ft^2]
    %lt= dustance from wing one fourth mac to tail onforth mac
    %bh=horizontal tail span [ft]
    %t_hr=horizontal tail maximum root thickness [in]
    N=1.5;
    W_h_tail=127*((((MTOW*N)/(10^5))^.87)*((S_h/100)^1.2)*((lt/10)^.483)*((bh/t_rh)^.5))^.458;
end

