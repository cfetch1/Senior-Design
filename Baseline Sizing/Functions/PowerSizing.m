function [PW_,PWmin_,PWmin,index] = PowerSizing(WS,CDmin,CDto,MTOW,CLmax,AR,V,ROC,h,dg,eta,plots)
% V = [Vturn, Vclimb, Vto, Vc, Vs] input as kts
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
[TW_dtod] = Desired_Takeoff_Distance(WS, V(3), 33.2, dg, q(V(3),rho(h(3))), CDto, .03, MTOW);
[TW_dca] = Desired_Cruise_Airspeed(WS, q(V(4),rho(h(4))), CDmin, k);
[TW_sc] = Service_Ceiling(WS, 1.667, rho(h(5)), k, CDmin);

[PW_lcvt_SL] = (TW_lcvt*V(1))/((sigma(1)^0.8)*eta(1));
[PW_dcr_SL] = (TW_dcr*V(2))/((sigma(2)^0.8)*eta(2));
[PW_dtod_SL] = (TW_dtod*V(3))/((sigma(3)^0.8)*eta(3));
[PW_dca_SL] = (TW_dca*V(4))/((sigma(4)^0.8)*eta(4));
[PW_sc_SL] = (TW_sc*V(4))/((sigma(5)^0.8)*eta(5));


PW_ = [PW_lcvt_SL; PW_dcr_SL; PW_dtod_SL; PW_dca_SL; PW_sc_SL]/550;



for ii = 1:length(WS)
    PWmin_(ii) = max(PW_(:,ii));
    WS_land(ii) = round(dg/(1.938*.25*2/(rho_SL*CLmax)));

    WS_land2(ii) = round(WS_landing(0, 1600, 2));

    WS_stall(ii) = round(V(5)^2*rho_SL*CLmax/2); 
end


PWmin = min(PWmin_);

for ii = 1:length(WS)
    if PWmin_(ii) == PWmin
        index = ii;
    end
end

limWS = min([WS_land(1,1),WS_stall(1,1)]);

if WS(index) > limWS
  for ii = 1:length(WS)
    if PWmin_(ii) == limWS
        index = ii;
    end
  end
end

dy = linspace(0,max(PW_(4,:)),length(PW_(1,:)));

%% Plot constrain lines
if plots == 1
    figure
    hold on
    plot(WS,PW_(3,:),'r','linewidth',2) % Takeoff Distance
    plot(WS,PW_(4,:),'b','linewidth',2) % Cruise Airspeed
    plot(WS_land,dy,'Color','#77AC30','linewidth',2)
    hatchedline(WS,PW_(3,:),'r',pi/180,.5, 0.5, 0.5);
    hatchedline(WS,PW_(4,:),'b',pi/180,.5, 0.5, 0.5);    

%   Add hatchline for vertical line
    ii = 1;
    while ii < 50
        plot([WS_land(1); WS_land(1)+0.25],...
            [ii*0.75*.25/length(WS_land); (ii-0.75)*0.75*.25/length(WS_land)],...
            'Color','#77AC30', 'LineWidth',2)
        ii = ii + 1;
    end 
    
    scatter(WS(index),PWmin,'pentagram','m','linewidth',5);
    text(WS(index)+.25,PWmin,'Design Point','HorizontalAlignment','Left') 
    grid on
    ylabel('P/W [brake horsepower/lbm]')
    xlabel('W/S [lbm/ft^2]')
%     legend('Required Takeoff Distance','Required Cruise Airspeed','Required Landing Distance','location','best')
    axis([WS(1),WS(end),0,.25])
    xlim([10 16])
    ylim([0.04 0.1])
    set(gca,'FontSize',15)
end


end

