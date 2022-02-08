close all
clear 
clc
addpath('.\Functions')
 
range = linspace(800,1400,13);
Vcruise = linspace(200,260,13);

for ii = 1:length(range)
    for jj = 1:length(Vcruise)
        [Wto,We,Wf,P,S,b,L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v] = InSizing(range(ii),Vcruise(jj));
        W1(ii,jj) = Wto;
        W2(ii,jj) = We;
        W3(ii,jj) = Wf;
        Preq(ii,jj) = P;
    end  
end

Carpet(range,Vcruise,W1,char('range'),char('airspeed'),char('nmi'),char('kts'),char('MTOW [lbs]'),0,200,50);
Carpet(range,Vcruise,W2,char('range'),char('airspeed'),char('nmi'),char('kts'),char('Empty Weight [lbs]'),0,100,25);
Carpet(range,Vcruise,W3,char('range'),char('airspeed'),char('nmi'),char('kts'),char('Fuel Weight [lbs]'),0,100,25);
Carpet(range,Vcruise,Preq,char('range'),char('airspeed'),char('nmi'),char('kts'),char('Power Required [BHP]'),0,200,50);

%%

for ii = 1:length(range)
    for jj = 1:length(Vcruise)
        [Wto,We,Wf,P,S,b,L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v] = InSizing(range(ii),Vcruise(jj));
        W1(ii,jj) = Wto;
        W2(ii,jj) = We;
        W3(ii,jj) = Wf;
        Preq(ii,jj) = P;
    end  
end

fW1(1,:) = polyfit(range,W1(1,:),2);
fW1(2,:) = polyfit(range,W1(5,:),2);
fW1(3,:) = polyfit(range,W1(9,:),2);
fW1(4,:) = polyfit(range,W1(13,:),2);

fW2(1,:) = polyfit(Vcruise,W1(1,:),2);
fW2(2,:) = polyfit(Vcruise,W1(5,:),2);
fW2(3,:) = polyfit(Vcruise,W1(9,:),2);
fW2(4,:) = polyfit(Vcruise,W1(13,:),2);

fP1(1,:) = polyfit(range,W1(1,:),2);
fP1(2,:) = polyfit(range,W1(5,:),2);
fP1(3,:) = polyfit(range,W1(9,:),2);
fP1(4,:) = polyfit(range,W1(13,:),2);

fP2(1,:) = polyfit(Vcruise,Preq(1,:),2);
fP2(2,:) = polyfit(Vcruise,Preq(5,:),2);
fP2(3,:) = polyfit(Vcruise,Preq(9,:),2);
fP2(4,:) = polyfit(Vcruise,Preq(13,:),2);

for ii = 1:4
    
    dW_dx(ii,:) = polyval([2*fW1(ii,1),fW1(ii,2)],range);
    dW_dV(ii,:) = polyval([2*fW2(ii,1),fW2(ii,2)],Vcruise);
    dP_dx(ii,:) = polyval([2*fP1(ii,1),fP1(ii,2)],range);
    dP_dV(ii,:) = polyval([2*fP2(ii,1),fP2(ii,2)],Vcruise);
    
    d2W_dx2(ii,:) = polyval(2*fW1(ii,1),range);
    d2W_dV2(ii,:) = polyval(2*fW2(ii,1),Vcruise);
    d2P_dx2(ii,:) = polyval(2*fP1(ii,1),range);
    d2P_dV2(ii,:) = polyval(2*fP2(ii,1),Vcruise);
    
end

figure
hold on
plot(range,dW_dx(1,:),'r','linewidth',2)
plot(range,dW_dx(2,:),'b','linewidth',2)
plot(range,dW_dx(3,:),'g','linewidth',2)
plot(range,dW_dx(4,:),'y','linewidth',2)
grid on
axis tight
ylabel('dW/dx')
xlabel('Range')
legend(['V_c = ' num2str(Vcruise(1))],['V_c = ' num2str(Vcruise(5))],['V_c = ' num2str(Vcruise(9))],['V_c = ' num2str(Vcruise(13))],'location','best')

figure
hold on
plot(range,dP_dx(1,:),'r','linewidth',2)
plot(range,dP_dx(2,:),'b','linewidth',2)
plot(range,dP_dx(3,:),'g','linewidth',2)
plot(range,dP_dx(4,:),'y','linewidth',2)
grid on
axis tight
ylabel('dP/dx')
xlabel('Range')
legend(['V_c = ' num2str(Vcruise(1))],['V_c = ' num2str(Vcruise(5))],['V_c = ' num2str(Vcruise(9))],['V_c = ' num2str(Vcruise(13))],'location','best')

figure
hold on
plot(Vcruise,dW_dV(1,:),'r','linewidth',2)
plot(Vcruise,dW_dV(2,:),'b','linewidth',2)
plot(Vcruise,dW_dV(3,:),'g','linewidth',2)
plot(Vcruise,dW_dV(4,:),'y','linewidth',2)
grid on
axis tight
ylabel('dW/dV')
xlabel('V_c_r_u_i_s_e')
legend(['X = ' num2str(range(1))],['X= ' num2str(range(5))],['X = ' num2str(range(9))],['X = ' num2str(range(13))],'location','best')

figure
hold on
plot(Vcruise,dP_dV(1,:),'r','linewidth',2)
plot(Vcruise,dP_dV(2,:),'b','linewidth',2)
plot(Vcruise,dP_dV(3,:),'g','linewidth',2)
plot(Vcruise,dP_dV(4,:),'y','linewidth',2)
grid on
axis tight
ylabel('dP/dV')
xlabel('V_c_r_u_i_s_e')
legend(['X = ' num2str(range(1))],['X= ' num2str(range(5))],['X = ' num2str(range(9))],['X = ' num2str(range(13))],'location','best')

figure
hold on
plot(range,d2W_dx2(1,:),'r','linewidth',2)
plot(range,d2W_dx2(2,:),'b','linewidth',2)
plot(range,d2W_dx2(3,:),'g','linewidth',2)
plot(range,d2W_dx2(4,:),'y','linewidth',2)
grid on
axis tight
ylabel('d^2W/dx^2')
xlabel('Range')
legend(['V_c = ' num2str(Vcruise(1))],['V_c = ' num2str(Vcruise(5))],['V_c = ' num2str(Vcruise(9))],['V_c = ' num2str(Vcruise(13))],'location','best')

figure
hold on
plot(range,d2P_dx2(1,:),'r','linewidth',2)
plot(range,d2P_dx2(2,:),'b','linewidth',2)
plot(range,d2P_dx2(3,:),'g','linewidth',2)
plot(range,d2P_dx2(4,:),'y','linewidth',2)
grid on
axis tight
ylabel('d^2P/dx^2')
xlabel('Range')
legend(['V_c = ' num2str(Vcruise(1))],['V_c = ' num2str(Vcruise(5))],['V_c = ' num2str(Vcruise(9))],['V_c = ' num2str(Vcruise(13))],'location','best')

figure
hold on
plot(Vcruise,d2W_dV2(1,:),'r','linewidth',2)
plot(Vcruise,d2W_dV2(2,:),'b','linewidth',2)
plot(Vcruise,d2W_dV2(3,:),'g','linewidth',2)
plot(Vcruise,d2W_dV2(4,:),'y','linewidth',2)
grid on
axis tight
ylabel('d^2W/dV^2')
xlabel('V_c_r_u_i_s_e')
legend(['X = ' num2str(range(1))],['X= ' num2str(range(5))],['X = ' num2str(range(9))],['X = ' num2str(range(13))],'location','best')

figure
hold on
plot(Vcruise,d2P_dV2(1,:),'r','linewidth',2)
plot(Vcruise,d2P_dV2(2,:),'b','linewidth',2)
plot(Vcruise,d2P_dV2(3,:),'g','linewidth',2)
plot(Vcruise,d2P_dV2(4,:),'y','linewidth',2)
grid on
axis tight
ylabel('d^2P/dV^2')
xlabel('V_c_r_u_i_s_e')
legend(['X = ' num2str(range(1))],['X= ' num2str(range(5))],['X = ' num2str(range(9))],['X = ' num2str(range(13))],'location','best')





