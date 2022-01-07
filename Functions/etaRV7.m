function [eta] = etaRV7(h,V0,Vc)
dV = 5;
V = 40:dV:180; % kts, TAS
%Vc = V(index);
%h_ = 0:2000:28000;
h_=h;


for jj=1:length(h_)
      h = h_(jj);
    

    
  

[T_SL,P_SL,rho_SL] = ISA_english(0);
[T_inf,P_inf,rho_inf] = ISA_english(h);

EAS_mph = V*1.15*sqrt(rho_inf/rho_SL);
MAP = 29.92*(P_inf/P_SL);

    P = 35*550*(rho_inf/rho_SL)^0.8;

for ii = 1:length(V)
    
    u(1) = MAP;
    u(2) = EAS_mph(ii);
    u(3) = h;
    u(4) = K2F(T_inf);
    
    p = engine_propeller(u);
    
    x1(ii) = V(ii); 
    y1(ii) = p(3);

%     if x1(ii) == V
%         index = ii;
%     end
   %  if jj ==1
    if y1(ii) == max(y1)
       index = ii;
    end
    % end
              
end


x2 = linspace(V(1),Vc,index); 
f = polyfit(x2,y1(1:index),2);
eta = polyval(f,V0);



end

