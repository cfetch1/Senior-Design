function [PW,WS,ROC] = ConstraintDiagram(Vc,hc,throttle,Sg,CL_max,AR,f,VE,plots)
WS_ = 5:.1:45;
WS_lg = f_WS_landing(Sg,CL_max,f);
if WS_lg > 40
    WS_lg = 40;
end
PW_to = f_PW_takeoff(WS_,Sg,CL_max)/.8;
PW_cr = .98*f_PW_cruise(AR, WS_, Vc, f(3), hc, throttle);
dt=.5;
error = 1000;
range = 200;
while error>1
    phi = atand(hc/(dt*VE*5280*1.15));
    DT = fzero(@(dt) range - Vc*(2-dt) + VE*cosd(phi)*dt,dt);
    error = 100*abs((DT-dt)/DT);
    dt = DT;
end
ROC = hc/(dt*60);
PW_cl = .99*PW_climb(AR, WS_, VE, ROC, f(3), hc/2,Vc);







for ii = 1:length(WS_)
    PW_min(ii) = max([PW_to(ii),PW_cr(ii),PW_cl(ii)]);
    if PW_min(ii) == min(PW_min)
        if WS_(ii)<=WS_lg
            WS = WS_(ii);
            PW = PW_min(ii);
        end
    end
end


if plots == 1 
    figure
        hold on
        ii=1;
        plot(WS_,PW_cr,'b','linewidth',3)
        plot(WS_,PW_cl,'g','linewidth',3)
        plot(WS_,PW_to,'r','linewidth',3)
        dy = linspace(0,2*max([PW_cr,PW_to]),100);
        dx = zeros(100,1);
        dx(:,1) = WS_lg;
        axis([0,WS_lg+5,min([PW_cr,PW_to]),max([PW_cr,PW_to])])
        plot(dx,dy,'k','linewidth',3)

% Insert Hatchline
        hatchedline(WS_,PW_cr,'b',pi/180,.5,1,1);
        hatchedline(WS_,PW_to,'r',pi/180,.5,1,1);
        hatchedline(WS_,PW_cl,'g',pi/180,.5,1,1);
        for ii = 1:3:round(length(dx)/1.4)
            plot([dx(ii,1); dx(ii,1)+0.75],[dy(ii); dy(ii)-0.025],'k','LineWidth',3)
        end
        
%         scatter(21.4,.1023,'filled','pentagram','SizeData',800)
        scatter(WS,PW,'y','filled','pentagram','SizeData',800)

        xlabel('Wing Loading [lb/ft^{2}]')
        xlim([5 45])
        ylim([0 0.2])
        ylabel('Power Loading [hp/lb]')
        grid on
        ax=gca;
        ax.XAxis.Exponent = 0;
        ax.XTick = 0:5:1000;
        ax.XAxis.MinorTick='on';
        ax.XAxis.MinorTickValues = 0:1:1000;
        ax.YAxis.Exponent = 0;
        ax.YTick = 0:.1:30000;
        ax.YAxis.MinorTick='on';
        ax.YAxis.MinorTickValues = 0:.025:30000;
        ax.FontSize=20;
end


end

