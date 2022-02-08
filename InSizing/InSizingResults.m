close all
clear 
clc
addpath('.\Functions')
 
%% Carpet Plots

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

Carpet(range,Vcruise,W1,char('range'),char('airspeed'),char('nmi'),char('kts'),char('MTOW [lbs]'),0,200,500);
Carpet(range,Vcruise,W2,char('range'),char('airspeed'),char('nmi'),char('kts'),char('Empty Weight [lbs]'),0,100,25);
Carpet(range,Vcruise,W3,char('range'),char('airspeed'),char('nmi'),char('kts'),char('Fuel Weight [lbs]'),0,100,25);
Carpet(range,Vcruise,Preq,char('range'),char('airspeed'),char('nmi'),char('kts'),char('Power Required [BHP]'),0,200,50);

%% Derivatives

range = linspace(400,2000,21);
Vcruise = linspace(100,300,21);

for ii = 1:length(range)
    for jj = 1:length(Vcruise)
        [Wto,We,Wf,P,S,b,L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v] = InSizing(range(ii),Vcruise(jj));
        W1(ii,jj) = Wto;
        W2(ii,jj) = We;
        W3(ii,jj) = Wf;
        Preq(ii,jj) = P;
    end  
end

dx = range(2)-range(1);
dV = Vcruise(2)-Vcruise(1);
zz = 1;

for ii = round(linspace(1,length(range),4))

    for jj = 1:length(range)-2
        
        dW_dx(zz,jj) = (W1(ii,jj)+W1(ii,jj+2))/(2*dx);
        dW_dV(zz,jj) = (W1(ii,jj)+W1(ii,jj+2))/(2*dV);
        dP_dx(zz,jj) = (Preq(ii,jj)+Preq(ii,jj+2))/(2*dx);
        dP_dV(zz,jj) = (Preq(ii,jj)+Preq(ii,jj+2))/(2*dV);
     
    end
    
    for jj = 1:length(range)-3
    
        d2W_dx2(zz,jj) = (dW_dx(zz,jj+1)-dW_dx(zz,jj))/dx;
        d2W_dV2(zz,jj) = (dW_dV(zz,jj+1)-dW_dV(zz,jj))/dV;
        d2P_dx2(zz,jj) = (dP_dx(zz,jj+1)-dP_dx(zz,jj))/dx;
        d2P_dV2(zz,jj) = (dP_dV(zz,jj+1)-dP_dV(zz,jj))/dV;
  
    end
    
    zz = zz + 1;
    
end

Dx1 = linspace(range(1),range(end),length(range)-2);
Dx2 = linspace(range(1),range(end),length(range)-3);
DV1 = linspace(range(1),range(end),length(range)-2);
DV2 = linspace(range(1),range(end),length(range)-3);

ii = round(linspace(1,length(range),4));

figure
hold on
plot(Dx1,dW_dx(1,:),'r--','linewidth',2)
plot(Dx1,dW_dx(2,:),'b--','linewidth',2)
plot(Dx1,dW_dx(3,:),'g--','linewidth',2)
plot(Dx1,dW_dx(4,:),'y--','linewidth',2)
grid on
axis tight
ylabel('dW/dx')
xlabel('Range')
legend(['V_c = ' num2str(Vcruise(ii(1)))],['V_c = ' num2str(Vcruise(ii(2)))],['V_c = ' num2str(Vcruise(ii(3)))],['V_c = ' num2str(Vcruise(ii(4)))],'location','northwest')

figure
hold on
plot(Dx1,dP_dx(1,:),'r--','linewidth',2)
plot(Dx1,dP_dx(2,:),'b--','linewidth',2)
plot(Dx1,dP_dx(3,:),'g--','linewidth',2)
plot(Dx1,dP_dx(4,:),'y--','linewidth',2)
grid on
axis tight
ylabel('dP/dx')
xlabel('Range')
legend(['V_c = ' num2str(Vcruise(ii(1)))],['V_c = ' num2str(Vcruise(ii(2)))],['V_c = ' num2str(Vcruise(ii(3)))],['V_c = ' num2str(Vcruise(ii(4)))],'location','northwest')

figure
hold on
plot(DV1,dW_dV(1,:),'r--','linewidth',2)
plot(DV1,dW_dV(2,:),'b--','linewidth',2)
plot(DV1,dW_dV(3,:),'g--','linewidth',2)
plot(DV1,dW_dV(4,:),'y--','linewidth',2)
grid on
axis tight
ylabel('dW/dV')
xlabel('V_c_r_u_i_s_e')
legend(['X = ' num2str(range(ii(1)))],['X = ' num2str(range(ii(2)))],['X = ' num2str(range(ii(3)))],['X = ' num2str(range(ii(4)))],'location','northwest')

figure
hold on
plot(DV1,dP_dV(1,:),'r--','linewidth',2)
plot(DV1,dP_dV(2,:),'b--','linewidth',2)
plot(DV1,dP_dV(3,:),'g--','linewidth',2)
plot(DV1,dP_dV(4,:),'y--','linewidth',2)
grid on
axis tight
ylabel('dP/dV')
xlabel('V_c_r_u_i_s_e')
legend(['X = ' num2str(range(ii(1)))],['X = ' num2str(range(ii(2)))],['X = ' num2str(range(ii(3)))],['X = ' num2str(range(ii(4)))],'location','northwest')

figure
hold on
plot(Dx2,d2W_dx2(1,:),'r--','linewidth',2)
plot(Dx2,d2W_dx2(2,:),'b--','linewidth',2)
plot(Dx2,d2W_dx2(3,:),'g--','linewidth',2)
plot(Dx2,d2W_dx2(4,:),'y--','linewidth',2)
grid on
axis tight
ylabel('d^2W/dx^2')
xlabel('Range')
legend(['V_c = ' num2str(Vcruise(ii(1)))],['V_c = ' num2str(Vcruise(ii(2)))],['V_c = ' num2str(Vcruise(ii(3)))],['V_c = ' num2str(Vcruise(ii(4)))],'location','northwest')

figure
hold on
plot(Dx2,d2P_dx2(1,:),'r--','linewidth',2)
plot(Dx2,d2P_dx2(2,:),'b--','linewidth',2)
plot(Dx2,d2P_dx2(3,:),'g--','linewidth',2)
plot(Dx2,d2P_dx2(4,:),'y--','linewidth',2)
grid on
axis tight
ylabel('d^2P/dx^2')
xlabel('Range')
legend(['V_c = ' num2str(Vcruise(ii(1)))],['V_c = ' num2str(Vcruise(ii(2)))],['V_c = ' num2str(Vcruise(ii(3)))],['V_c = ' num2str(Vcruise(ii(4)))],'location','northwest')

figure
hold on
plot(DV2,d2W_dV2(1,:),'r--','linewidth',2)
plot(DV2,d2W_dV2(2,:),'b--','linewidth',2)
plot(DV2,d2W_dV2(3,:),'g--','linewidth',2)
plot(DV2,d2W_dV2(4,:),'y--','linewidth',2)
grid on
axis tight
ylabel('d^2W/dV^2')
xlabel('V_c_r_u_i_s_e')
legend(['X = ' num2str(range(ii(1)))],['X = ' num2str(range(ii(2)))],['X = ' num2str(range(ii(3)))],['X = ' num2str(range(ii(4)))],'location','northwest')

figure
hold on
plot(DV2,d2P_dV2(1,:),'r--','linewidth',2)
plot(DV2,d2P_dV2(2,:),'b--','linewidth',2)
plot(DV2,d2P_dV2(3,:),'g--','linewidth',2)
plot(DV2,d2P_dV2(4,:),'y--','linewidth',2)
grid on
axis tight
ylabel('d^2P/dV^2')
xlabel('V_c_r_u_i_s_e')
legend(['X = ' num2str(range(ii(1)))],['X = ' num2str(range(ii(2)))],['X = ' num2str(range(ii(3)))],['X = ' num2str(range(ii(4)))],'location','northwest')





