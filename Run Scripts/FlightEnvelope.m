close all
clear all
clc

addpath('C:\Users\grega\Documents\GitHub\Senior-Design\Functions')

yy1 = [
 23.8719
   15.9376
   11.9995
    9.6778
    8.1834
    7.1816
    6.5085
    6.0756
    5.8325
    5.7494
    5.8086
    5.9997
    6.3172
    6.7587
    7.3240
    8.0144
    8.8324
    9.7812
   10.8649
   12.0877
   13.4544
   14.9699
   16.6396
   18.4688
   20.4630
   22.6281
   24.9697
   27.4937
   30.2060
   33.1127
   36.2197
   39.5330
   43.0589
   46.8034
   50.7727];

yy2 = [ 1.7730
    2.9933
    4.0603
    5.0070
    5.8624
    6.6524
    7.3988
    8.1202
    8.8314
    9.5437
   10.2648
   10.9990
   11.7466
   12.5046
   13.2665
   14.0220
   14.7572
   15.4549
   16.0940
   16.6500
   17.0948
   17.3966
   17.5201
   17.4264
   17.0731
   16.4141
   15.3997
   13.9768
   12.0884
    9.6742
    6.6702
    3.0089
   -1.3809
   -6.5740
  -12.6487];

yy3 = [   21.4164
   14.3044
   10.7824
    8.7171
    7.4024
    6.5400
    5.9843
    5.6578
    5.5169
    5.5367
    5.7029
    6.0080
    6.4486
    7.0244
    7.7369
    8.5890
    9.5846
   10.7284
   12.0256
   13.4818
   15.1029
   16.8952
   18.8650
   21.0190
   23.3638
   25.9063
   28.6533
   31.6118
   34.7887
   38.1913
   41.8266
   45.7017
   49.8239
   54.2003
   58.8382];

yy4 = [
    1.9376
    3.3312
    4.5457
    5.6205
    6.5906
    7.4866
    8.3347
    9.1565
    9.9693
   10.7858
   11.6142
   12.4586
   13.3181
   14.1878
   15.0581
   15.9150
   16.7401
   17.5105
   18.1987
   18.7730
   19.1971
   19.4302
   19.4271
   19.1382
   18.5094
   17.4820
   15.9930
   13.9751
   11.3561
    8.0596
    4.0049
   -0.8934
   -6.7251
  -13.5845
  -21.5702];


dh = 18000;
dV = 10:5:180;
W = 447;
S = 38.19;
FOS = 1;
BHP0 = 40;
ROC = 500;
throttle = 1;
Vc = 120;
CLmax = 1.5;
for jj = 1:length(dh)
    h = dh(jj);
    rho = density(h);
for ii = 1:length(dV)
%     if dV(ii)<=120
%         eta = .85*(dV(ii)/120)^1.5;
%     else
%         eta = .85*(120/dV(ii))^1.5;
%     end
    eta = TR640(dV(ii),Vc);
    rho = density(h);
    V_fps = dV(ii)*1.69;
    [CL,CD] = DragSLF2(dV(ii),W,h,S,0,FOS);
    P_req(ii) = .5*rho*V_fps^3*S*CD/550;
    sig = sigma0(h);
    P_eng(ii) = throttle*BHP0*(sig-(1-sig)/7.55);
    P_avail(ii) = throttle*BHP0*(sig-(1-sig)/7.55)*eta;  
    [CLc,CDc] = DragSLF2(dV(ii),W,h,S,ROC,FOS);
    Pc_req(ii) = (.5*rho*V_fps^3*S*CD+W*ROC/60)/(550);
 
end
dy = linspace(0,100,100);
vs = zeros(100,1);
vs(:,1) = round(sqrt(2*W/(rho*S*CLmax))/1.69);
hold on

plot(dV,P_req,'r','linewidth',2)
plot(dV,P_avail,'b','linewidth',2)
plot(dV,yy3,'r--','linewidth',2);
plot(dV,yy4,'b--','linewidth',2)
plot(dV,P_eng,'k--','linewidth',2)
plot(vs,dy,'k','linewidth',2)
%plot(dV,Pc_req,'g','linewidth',2)
grid on
ax = gca;
ax.FontSize = 14;
axis([0,max(dV),0,80])
xlabel('Airspeed [kts]')
ylabel('Power [Hp]')
legend('Power Required (refined sizing)','Power Available(refined sizing)','Power Required (initial sizing)','Power Available(initial sizing)','Engine Output','Stall Speed','location','northwest')
% legend('Power Required','Power Available','Engine Output','Stall Speed','location','northwest')
text(10,55,['h = ' num2str(h) ' ft'],'background','white','FontSize',14)
% text(10,50,['throttle = ' num2str(throttle*100) '%'],'background','white')
pbaspect([2,1,1])
ax.XTick = 0:25:1000;
ax.XAxis.MinorTick='on';
ax.XAxis.MinorTickValues = 0:5:1000;
ax.YTick = 0:10:100;
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues = 0:2:100;
end