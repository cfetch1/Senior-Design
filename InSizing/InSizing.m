function [MTOW,We,Wf,P,S,b,L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v] = InSizing(range,Vcruise,opt)

% No flap take off
Cl_to = 1.3;


%% Initial Values (arbitrary)
err = 1000;
MTOW = 200;
S = 40*(range/550)*(Vcruise/120);
Wf = 50*(range/550)*(Vcruise/120);
res = Wf*.25;
WS = 5:.1:30;

%% Constants
h = 18000;
k =.1794;
[~,CD0] = DragSLF(1,0,0,S,0);
rho_cl = (density(0)+density(h))/2;
%f = [0.0212   -0.0022    0.0286]; 
f = [0.0351   -0.0029    0.0210];
Sg = 1000;

% Vclimb = (sqrt((2*dX1/(rho_cl*S)))*(k/(CD0))^.25)/1.69;
% V_fps = Vclimb*1.69;
% Vclimb = .6*Vcruise;
%
% sigma = fsigma0(h/2);
% P_eng = P1*.85*(sigma-(1-sigma)/7.55);
% eta_prop = TR640(Vclimb,Vcruise);
% P_avail = P_eng*eta_prop*550;
%
% % for gamma << 1
% CL = X1/(.5*rho_cl*V_fps^2*S);
% CD = f(1)*(CL)^2 + f(2)*CL + f(3);
% D = .5*rho_cl*V_fps^2*S*CD;
% P_req = D*V_fps;
%
% gamma = asin((P_avail-P_req)/(X1*V_fps));
%
% ROC = V_fps*60*sin(gamma);
%
% % correct CL for gamma
% CL = X1*cos(gamma)/(.5*rho_cl*V_fps^2*S);
% CD = f(1)*(CL)^2 + f(2)*CL + f(3);
% D = .5*rho_cl*V_fps^2*S*CD;
% P_req = D*V_fps;
%
% gamma = asin((P_avail-P_req)/(X1*V_fps));
%
% ROC = V_fps*60*sin(gamma);
Vclimb = 85;
ROC = 900;

[CL1,CD1] = DragSLF(Vclimb,MTOW,0,S,ROC);
E1 = CL1/CD1;
% E1 = 13.9;

[CL2,CD2] = DragSLF(Vcruise,.98*MTOW,h,S,0);
E2 = CL2/CD2;
% E2 = 9.12;
E3 = E2;
%
% [CL3,CD3] = DragSLF(Vcruise,dX3,2000,S,0);

Vs = sqrt(2*MTOW*.9/(.0024*S*Cl_to))/1.69;
% [CL4,CD4] = DragSLF(Vs,MTOW*.8,0,S,0);

% WE HAVE NO IDEA PLEASE GIVE THIS VARIABLE A NAME PLEASE
CL4= 1.3;
% E4=CL4/CD4;
% E4 = CL4/CD4;



PSFC(1) = fTSFC(h/2,Vclimb);
PSFC(2) = fTSFC(h,Vcruise);
PSFC(3) = fTSFC(h,Vcruise);
 eta(1) = TR640(Vclimb,Vcruise);
eta(2) = TR640(Vcruise,Vcruise);
% eta = [.555,.8335];

[MTOW,We,Wf,~,Wrs]=RangeSizing(66.4,MTOW,range,0,[E1,E2,E3],[PSFC(1),PSFC(2),PSFC(3)],[Vclimb,Vcruise,Vcruise],ROC,h,[eta(1),eta(2)],1,res);

for ii=1:length(Wrs)
    y(ii) = (1-(Wrs(ii)))/(prod(Wrs(1:ii)));
end
yy = (Wf-res)/sum(y);
y = y*yy;

dX1 = MTOW;
dX2 = MTOW-sum(y(1:3));
dX3 = MTOW-sum(y(1:4));
dX4 = MTOW;
dX5 = MTOW-sum(y(1:7));
res = .25*sum(y(1:7));

P2 = MTOW*.3;





while err>1
    
    X1 = MTOW;
    P1 = P2;
    S1 = S;
    
[CL1,CD1] = DragSLF(Vclimb,dX1,0,S,ROC);
E1 = CL1/CD1;
% E1 = 13.9;

[CL2,CD2] = DragSLF(Vcruise,dX2,h,S,0);
E2 = CL2/CD2;
% E2 = 9.12;
E3 = E2;
    %% calculate ROC
    
    Vs = sqrt(2*dX5/(.0024*S1*Cl_to))/1.69;
    [CL4,CD4] = DragSLF(Vs,dX4,0,S,0);
    CL4 = 1.3;
    
    %[MTOW,We,Wf,~,Wrs]=RangeSizing_cus(66.4,X1,range,0,[E1,E2,E3],[PSFC(1),PSFC(2),PSFC(3)],[Vclimb,Vcruise,Vcruise],ROC,h,[eta(1),eta(2)],1,res,P1,S);
    [MTOW,We,Wf,~,Wrs]=RangeSizing(66.4,X1,range,0,[E1,E2,E3],[PSFC(1),PSFC(2),PSFC(3)],[Vclimb,Vcruise,Vcruise],ROC,h,[eta(1),eta(2)],1,res);
    X2 = MTOW;
    AR = 15;
    for ii=1:length(Wrs)
        y(ii) = (1-(Wrs(ii)))/(prod(Wrs(1:ii)));
    end
    yy = (Wf-res)/sum(y);
    y = y*yy;
    [~,CD0] = DragSLF(1,0,0,S,0);
    PW_cruise2 = PW_cruise(AR, WS, Vcruise, CD0, h,.75);
    PW_to = PW_takeoff(AR,WS,Sg,0,CL4,[0.0351,   -0.0029,    0.0210],Vcruise*1.69);
    WS_ = WS_landing(0,Sg,CL4)*(X2/dX5);
    index = 0;
    for ii = 1
        for jj = 1:length(WS)
            PWmin(ii,jj) = max([dX2*PW_cruise2(ii,jj),dX1*PW_to(ii,jj)]);
            if PWmin(ii,jj) == min([PWmin(ii,1:jj)])
                if WS(jj) <= WS_
                    index = jj;
                end
            end
        end
    end
    if index < 1
        index = 1;
    end
    
    P2 = PWmin(index); %shaft horsepower
    S = MTOW/WS(index); %planform area, ft^2
    c = sqrt(S/15);
    b = S/c;
    
    
    err = 100*max([abs(X1-X2)/X1,abs(P1-P2)/P1,abs(S1-S)/S1]);
    
    if err>1
        dX1 = MTOW;
        dX2 = MTOW-sum(y(1:3));
        dX3 = MTOW-sum(y(1:4));
        dX4 = MTOW;
        dX5 = MTOW-sum(y(1:7));
        res = .25*sum(y(1:7));
        clear y PWmin
    else
        if opt == 1
        figure
        hold on
        ii=1;
        plot(WS,PW_cruise2(ii,:),'b','linewidth',2)
        plot(WS,PW_to(ii,:),'r','linewidth',2)
        dy = linspace(0,2*max([PW_cruise2(ii,:),PW_to(ii,:)]),100);
        dx = zeros(100,1);
        dx(:,1) = WS_;
        axis([0,max(WS),min([PW_cruise2(ii,:),PW_to(ii,:)]),max([PW_cruise2(ii,:),PW_to(ii,:)])])
        plot(dx,dy,'k','linewidth',2)

% Insert Hatchline
        hatchedline(WS,PW_cruise2(ii,:),'b',pi/180,.5,1,1);
        hatchedline(WS,PW_to(ii,:),'r',pi/180,.5,1,1);
   
        for ii = 1:3:round(length(dx)/1.4)
            plot([dx(ii,1); dx(ii,1)+0.75],[dy(ii); dy(ii)-0.025],'k','LineWidth',2)
        end
        
        scatter(23.8, 0.0927,'filled','pentagram','SizeData',800)

        xlabel('Wing Loading [lb/ft^{2}]')
        xlim([10 25])
        ylim([0 0.3])
        ylabel('Power Loading [hp/lb]')
        grid on
        ax=gca;
        ax.XAxis.Exponent = 0;
        ax.XTick = 0:2:1000;
        ax.XAxis.MinorTick='on';
        ax.XAxis.MinorTickValues = 0:2:1000;
        ax.YAxis.Exponent = 0;
        ax.YTick = 0:.1:30000;
        ax.YAxis.MinorTick='on';
        ax.YAxis.MinorTickValues = 0:.025:30000;
        ax.FontSize=14;
    legend(['V_{cruise} = ' num2str(Vcruise) ' kts'],'Takeoff Requirement','Landing Requirement','location','best')

%          scatter(397/36,30/397,'mo','filled')
%                  legend(['V_c_r_u_i_s_e = ' num2str(Vcruise) ' kts'],'Takeoff Requirement','Landing Requirement','Tekever AR5','location','best')
% 
% %         text(397/36*.98,40/397*1.1,'Tekever AR5 (actual)','FontSize',14,'HorizontalAlignment','right')
%        clc
        end
        
    end
    
end

P=P2;
[L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v] = WingDimensions(S,b,c);
% [MTOW, Wcomp] = Design_weight_estimate(S_v,S_h,S, b, P,Wf, Vcruise,b_v,b_h,L_fuselage);

end

