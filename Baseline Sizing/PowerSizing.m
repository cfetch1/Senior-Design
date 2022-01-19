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
    WS_land(ii) = round(dg/(1.938*.25*(2*MTOW/(rho_SL*40*CLmax))));
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

% [TW_lcvt_SL] = TW_lcvt/(sigma(1)^0.8);
% [TW_dcr_SL] = TW_dcr/(sigma(2)^0.8);
% [TW_dtod_SL] = TW_dtod/(sigma(3)^0.8);
% [TW_dca_SL] = TW_dca/(sigma(4)^0.8);
% [TW_sc_SL] = TW_sc/(sigma(5)^0.8);
% 
% TW_ = [TW_lcvt_SL; TW_dcr_SL; TW_dtod_SL; TW_dca_SL; TW_sc_SL];
% TWmin = max(TW_(:,index))
% 

dy = linspace(0,max(PW_(1,:)),length(PW_(1,:)));

if plots == 1
    figure
    hold on
    
    
    plot(WS,PW_(1,:),'r','linewidth',2)
    plot(WS,PW_(2,:),'b','linewidth',2)
    plot(WS,PW_(3,:),'g','linewidth',2)

    plot(WS,PW_(4,:),'m','linewidth',2)
    plot(WS,PW_(5,:),'c','linewidth',2)
    plot(WS_land,dy,'m','linewidth',2)
    
    hatchedline(WS,PW_(4,:),'r',pi/180,.5,1,1);
    hatchedline(WS,PW_(5,:),'b',pi/180,.5,1,1);
    hatchedline(WS_land,dy,'m',45*pi/180,.5,1,1);
    

    for ii = 1:round(length(WS_land)/1.4)
        plot([WS_land(1);WS_land(1)+1],[ii*1.4*.25/length(WS_land);ii*1.4*.25/length(WS_land)],'m')
    end
    
    
%     plot(WS_stall,dy,'k--','linewidth',2)
    scatter(WS(index),PWmin,'k*','linewidth',5);
    %text(WS(index)+.25,PWmin,['Minimum Required Power = ' num2str(round(PWmin,4)) ' hp per lbm'],'HorizontalAlignment','Left')
    text(WS(index)+.25,PWmin,'Design Point','HorizontalAlignment','Left') 
    grid on
    ax=gca;
    ax.XTick = 0:5:WS(end);
    ax.XAxis.MinorTick='on';
    ax.XAxis.MinorTickValues = 0:1:WS(end);
    ax.YTick = 0:.01:1;
    ax.YAxis.MinorTick='on';
    ax.YAxis.MinorTickValues = 0:.001:1;
    ylabel('P/W [brake horsepower/lbm]')
    xlabel('W/S [lbm/ft^2]')
    legend('Level Constant Velocity Turn','Desired Climb Rate','Desired Takeoff Distance','Desired Cruise Airspeed','Service Ceiling','Landing Distance','Stall Speed','location','best')
    legend('Required Takeoff Distance','Required Cruise Airspeed','Required Landing Distance','location','best')
    axis([WS(1),WS(end),0,.25])
end


end

