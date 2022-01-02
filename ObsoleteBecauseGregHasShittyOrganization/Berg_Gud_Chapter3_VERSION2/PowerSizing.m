function [PW_,PWmin_,PWmin,index] = PowerSizing(WS,CDmin,CDto,CLto,AR,V,ROC,h,dg,eta,plots)
% V = [Vturn, Vclimb, Vto, Vc] input as kts
% h = [hturn, hclimb, hto, hc, hmax]
% ROC inputs as ft/min
V = V.*1.68781;
q = @(V, rho) (1/2)*rho*V^2;
rho = @(h) rho_us(h);
e = 1.78*(1-0.045*AR^0.68)-0.64;
k = 1/(pi*AR*e);

rho_SL = rho(0);

sigma = [rho(h(1))/rho_SL,rho(h(2))/rho_SL,rho(h(3))/rho_SL,rho(h(4))/rho_SL,rho(h(5))/rho_SL];

[TW_lcvt] = Level_Constant_Velocity_Turn(WS,CDmin, k, q(V(1),rho(h(1))), 1.8);
[TW_dcr] = Desired_Climb_Rate(WS,ROC/60, V(2), q(V(2),rho(h(2))), CDmin, k);
[TW_dtod] = Desired_Takeoff_Distance(WS, V(3), 33.2, dg, q(V(3),rho(h(3))), CDto, .04, CLto);
[TW_dca] = Desired_Cruise_Airspeed(WS, q(V(4),rho(h(4))), CDmin, k);
[TW_sc] = Service_Ceiling(WS, 1.667, rho(h(5)), k, CDmin);

[PW_lcvt_SL] = ((TW_lcvt*V(1))/(sigma(1)^0.8))/eta(1);
[PW_dcr_SL] = ((TW_dcr*V(2))/(sigma(2)^0.8))/eta(2);
[PW_dtod_SL] = ((TW_dtod*V(3))/(sigma(3)^0.8))/eta(3);
[PW_dca_SL] = ((TW_dca*V(4))/(sigma(4)^0.8))/eta(4);
[PW_sc_SL] = ((TW_sc*V(4))/(sigma(5)^0.8))/eta(5);

PW_ = [PW_lcvt_SL; PW_dcr_SL; PW_dtod_SL; PW_dca_SL; PW_sc_SL]/550;

for ii = 1:length(WS)
    PWmin_(ii) = max(PW_(:,ii));
end

PWmin = min(PWmin_);

for ii = 1:length(WS)
    if PWmin_(ii) == PWmin
        index = ii;
    end
end

if plots == 1
    figure
    hold on
    plot(WS,PW_(1,:),'r')
    plot(WS,PW_(2,:),'b')
    plot(WS,PW_(3,:),'g')
    plot(WS,PW_(4,:),'m')
    plot(WS,PW_(5,:),'y')       
end


end

