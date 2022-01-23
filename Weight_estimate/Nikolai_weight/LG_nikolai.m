function [W_lg] = LG_nikolai(MTOW, Wfuel,L_sm)
   %L_sm=length of main landing gear strut [in]
    %Wland=landing weight 
    %Nland=ultimate load factor at weight land
    L_sm=L_sm*12;
    Nland=2;
    Wland=MTOW-Wfuel;
    W_lg=.054*((L_sm)^.501)*(Wland*Nland)^.684;
end

