% power(lines 50-54 on fcruise fn)
clear;
clc;
close all;
% h=linspace(0,18000,19);
h=linspace(0,18000,1000);
for ii=1:length(h)
    rho(ii) = density(h(ii));
    sigma(ii) = sigma0(h(ii));
%     eta = TR640(V(ii)+Vw,Vc);
%     eta(ii) = TR640(160,120);
    eta(ii)=1; %assuming 100% prop efficiency
%     P_max = P0*550*(sigma-(1-sigma)/7.55)*eta;
    P_max(ii) = 100*(sigma(ii)-(1-sigma(ii))/7.55)*eta(ii);
    
    
    [SFC(ii)] = fTSFC(h(ii),160);%160 kts ingress speed
end

figure(1)
plot(P_max, h)
xlabel('Power [Hp]')
ylabel('Altitude [Ft]')

figure(2)
plot(SFC,h)
xlabel('SFC [lb/lb/hr]')
ylabel('Altitude [Ft]')














