function [T_std,P_std,rho_std] = ISA_english(Hp)

% Hp [ft]
% T_std [K]
% P_std [lbf/ft^2]
% rho_std [slug/ft^3]

if Hp <= 36089.2
    
    A = 288.15;
    B = -1.9812*10^-3;
    C = 4.2927085;
    D = -29.514885*10^-6;
    E = 5.2558797;
    I = 0.24179285;
    J = -1.6624675*10^-6;
    L = 4.2258797;
        
    T_std = A+B*Hp;
    P_std = (C+D*Hp)^E;
    rho_std = (I+J*Hp)^L;

elseif Hp <= 65616.8
    
    F = 2678.4420;
    G = -48.063462*10^-6;
    M = 4.001212*10^-3;
    N = -48.063462*10^-6;
    
    T_std = 216.65;
    P_std = F*exp(G*Hp);
    rho_std = M*exp(N*Hp);
    
elseif Hp <= 104987
    
    A = 196.65;
    B = .3048*10^-3;
    C = 0.79011202;
    D = 1.2246435*10^-6;
    E = -34.163218;
    I = 1.1616564;
    J = 1.8005232*10^-6;
    L = -35.163218; % check sign

    T_std = A+B*Hp;
    P_std = (C+D*Hp)^E;
    rho_std = (I+J*Hp)^L;

elseif Hp <= 154199
    
    A = 139.05;
    B = 0.85344*10^-3;
    C = 0.47958369;
    D = 2.943516*10^-6;
    E = -12.201149;
    I = 1.3544167;
    J = 8.3129335*10^-6;
    L = -13.201149;
    
    T_std = A+B*Hp;
    P_std = (C+D*Hp)^E;
    rho_std = (I+J*Hp)^L;

elseif Hp <= 164042
    
    F = 873.64072;
    G = -38.473855*10^-6;
    M = 1.044660*10^-3;
    N = -38.473*10^-6;
    
    T_std = 270.65;
    P_std = F*exp(G*Hp);
    rho_std = M*exp(N*Hp);
    
else
    
    disp('ERROR: PRESSURE HEIGHT EXCEEDS ISA')
    
end

    
end

