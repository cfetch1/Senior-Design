function [Power,consumption] = engine_O360(RPM,MAP,altitude,temp,plotar)
% Lycoming engine power charts O-360-A series 8.5:1 Carburated
% Curve No. 10350-A
% 
% Power - hp
% consumption - US gal/hr
% RPM 
% MAP - inHg
% altitude - ft
% temp - F
% plotar - 0 - no plot - 1 plot

% Unit conversion
temp = (temp - 32) * 5/9; %(F to C)


% Vetores de correção da escala não linear em X do gráfico de potencia em
% altitude. O vetor correcao_x contem os valores na escala linear que
% correspondem a escala não-linear. O vetor x_graph contem os valores da
% escala não linear.
correcao_x = [0 1.30745 2.6149 3.88273 5.07132 6.2599 7.44849 8.59746 9.70681 10.8162 11.8463 12.9161 13.9065 14.9366 15.8875 16.7988 17.7497 18.6609 19.4929 20.3645 21.1569 21.9494 22.7813 23.5341 24.2868 25];
x_graph = [0:1:25];
% Vetor de curvas de rotação
rpm_graph = [2700 2600 2400 2200 2000 ];
% Vetor de curvas de MAP
map_graph = [28 26 24 22 20 18 16 14 12];

% Plota as curvas de rotação do gráfico de potencia em altitude,ajustando
% os valroes das abicissas para a escala não linear e ajustando suas
% abicissas para os valores [0 25] que são so limites deste gráfico
if (plotar==1)
    fig = figure(99);
end
x = interp1(correcao_x,x_graph,[0:1:25],'linear','extrap'); % Este é o vetor não linear do eixo das abscissas deste gráfico
if (plotar==1)
    subplot(1,2,2); ylim ([20 220]); grid on;
    set(fig,'defaultAxesColorOrder',[[0 0 0]; [0 0 1]]);
end
curve = [0.0396197,185.147; 25.0396,69.4137];
ALT_RPM (1,:) = interp1(curve(:,1),curve(:,2),[0:1:25],'linear','extrap');
if (plotar==1)
    plot(x,ALT_RPM(1,:),'k'); hold on;
end
curve = [-7.10543e-15,180.814; 25.0396,67.557];
ALT_RPM (2,:) = interp1(curve(:,1),curve(:,2),[0:1:25],'linear','extrap');
if (plotar==1)
    plot(x,ALT_RPM(2,:),'k'); hold on;
end
curve = [-7.10543e-15,174.007; 25.0396,65.7003];
ALT_RPM (3,:) = interp1(curve(:,1),curve(:,2),[0:1:25],'linear','extrap');
if (plotar==1)
    plot(x,ALT_RPM(3,:),'k'); hold on;
end
curve = [-7.10543e-15,163.795; 25,61.987];
ALT_RPM (4,:) = interp1(curve(:,1),curve(:,2),[0:1:25],'linear','extrap');
if (plotar==1)
    plot(x,ALT_RPM(4,:),'k'); hold on;
end
curve = [-7.10543e-15,151.107; 25,56.7264];
ALT_RPM (5,:) = interp1(curve(:,1),curve(:,2),[0:1:25],'linear','extrap');
if (plotar==1)
    plot(x,ALT_RPM(5,:),'k'); hold on;
end

% interpolar estas coordenadas para o RPM desejado, criando uma nova reta
% para este valor ded RPM.
ALT_RPM_FINAL = interp1(rpm_graph,ALT_RPM(:,:),RPM,'linear','extrap');
if (plotar==1)
    plot(x,ALT_RPM_FINAL(:),'b','LineWidth',2); hold on;
end

% Plota as curvas de MAP do gráfico de potencia em altitude,ajustando
% os valroes das abicissas para a escala não linear, interpolando um
% polinômio de segunda ordem sobre estes pontos e encontra a interseção
% destes polinômios com a reta de RPM obtida anteriormente. O conjunto
% destes pontos será utilizado para a interpolação do MAP desejado.
% Observe que o ajuste dos polinômios é feito com os eixos trocados para
% uma melhor adaptação do ajuste.
curve = [0.950872,181.124; 1.30745,168.436; 1.50555,157.606; 1.58479,144.919];
% curve(:,1) = interp1(correcao_x,x_graph,curve(:,1),'linear','extrap');
p = polyfit(curve(:,2),curve(:,1),2);
a = p(1);
b = p(2);
c = p(3);
d = 25./(ALT_RPM_FINAL(:,end)-ALT_RPM_FINAL(:,1));
e = -d.*ALT_RPM_FINAL(:,1);
ALT_MAP(1,2,:) = -((b-d)-((b-d).^2-4.*a.*(c-e)).^0.5)./(2.*a);
ALT_MAP(1,1,:)=polyval(p,ALT_MAP(1,2,:));
if (plotar==1)
    plot(interp1(correcao_x,x_graph,curve(:,1),'linear','extrap'),curve(:,2),'m'); hold on;
    plot(interp1(correcao_x,x_graph,ALT_MAP(1,1),'linear','extrap'),ALT_MAP(1,2),'*r');
end
curve = [3.64501,168.436; 3.76387,163.795; 3.92235,157.296; 4.0412,147.394; 4.16006,135.326];
% curve(:,1) = interp1(correcao_x,x_graph,curve(:,1),'linear','extrap');
p = polyfit(curve(:,2),curve(:,1),2);
a = p(1);
b = p(2);
c = p(3);
d = 25./(ALT_RPM_FINAL(:,end)-ALT_RPM_FINAL(:,1));
e = -d.*ALT_RPM_FINAL(:,1);
ALT_MAP(2,2,:) = -((b-d)-((b-d).^2-4.*a.*(c-e)).^0.5)./(2.*a);
ALT_MAP(2,1,:)=polyval(p,ALT_MAP(2,2,:));
if (plotar==1)
    plot(interp1(correcao_x,x_graph,curve(:,1),'linear','extrap'),curve(:,2),'m'); hold on;
    plot(interp1(correcao_x,x_graph,ALT_MAP(2,1),'linear','extrap'),ALT_MAP(2,2),'*r');
end
curve = [6.2599,156.678; 6.29952,152.655; 6.37876,146.466; 6.458,137.492; 6.49762,126.352];
% curve(:,1) = interp1(correcao_x,x_graph,curve(:,1),'linear','extrap');
p = polyfit(curve(:,2),curve(:,1),2);
a = p(1);
b = p(2);
c = p(3);
d = 25./(ALT_RPM_FINAL(:,end)-ALT_RPM_FINAL(:,1));
e = -d.*ALT_RPM_FINAL(:,1);
ALT_MAP(3,2,:) = -((b-d)-((b-d).^2-4.*a.*(c-e)).^0.5)./(2.*a);
ALT_MAP(3,1,:)=polyval(p,ALT_MAP(3,2,:));
if (plotar==1)
    plot(interp1(correcao_x,x_graph,curve(:,1),'linear','extrap'),curve(:,2),'m'); hold on;
    plot(interp1(correcao_x,x_graph,ALT_MAP(3,1),'linear','extrap'),ALT_MAP(3,2),'*r');
end
curve = [8.83518,144.609; 8.91442,140.586; 9.0729,134.707; 9.19176,126.661; 9.23138,116.14];
% curve(:,1) = interp1(correcao_x,x_graph,curve(:,1),'linear','extrap');
p = polyfit(curve(:,2),curve(:,1),2);
a = p(1);
b = p(2);
c = p(3);
d = 25./(ALT_RPM_FINAL(:,end)-ALT_RPM_FINAL(:,1));
e = -d.*ALT_RPM_FINAL(:,1);
ALT_MAP(4,2,:) = -((b-d)-((b-d).^2-4.*a.*(c-e)).^0.5)./(2.*a);
ALT_MAP(4,1,:)=polyval(p,ALT_MAP(4,2,:));% plot(curve(:,1),curve(:,2),'m'); hold on
if (plotar==1)
    plot(interp1(correcao_x,x_graph,curve(:,1),'linear','extrap'),curve(:,2),'m'); hold on;
    plot(interp1(correcao_x,x_graph,ALT_MAP(4,1),'linear','extrap'),ALT_MAP(4,2),'*r');
end
curve = [11.4897,132.231; 11.6086,128.518; 11.6878,123.257; 11.8463,115.521; 11.9651,105.928];
% curve(:,1) = interp1(correcao_x,x_graph,curve(:,1),'linear','extrap');
p = polyfit(curve(:,2),curve(:,1),2);
a = p(1);
b = p(2);
c = p(3);
d = 25./(ALT_RPM_FINAL(:,end)-ALT_RPM_FINAL(:,1));
e = -d.*ALT_RPM_FINAL(:,1);
ALT_MAP(5,2,:) = -((b-d)-((b-d).^2-4.*a.*(c-e)).^0.5)./(2.*a);
ALT_MAP(5,1,:)=polyval(p,ALT_MAP(5,2,:));
if (plotar==1)
    plot(interp1(correcao_x,x_graph,curve(:,1),'linear','extrap'),curve(:,2),'m'); hold on;
    plot(interp1(correcao_x,x_graph,ALT_MAP(5,1),'linear','extrap'),ALT_MAP(5,2),'*r');
end
curve = [14.3027,119.235; 14.4216,115.831; 14.5008,111.189; 14.58,104.691; 14.6197,96.0261];
% curve(:,1) = interp1(correcao_x,x_graph,curve(:,1),'linear','extrap');
p = polyfit(curve(:,2),curve(:,1),2);
a = p(1);
b = p(2);
c = p(3);
d = 25./(ALT_RPM_FINAL(:,end)-ALT_RPM_FINAL(:,1));
e = -d.*ALT_RPM_FINAL(:,1);
ALT_MAP(6,2,:) = -((b-d)-((b-d).^2-4.*a.*(c-e)).^0.5)./(2.*a);
ALT_MAP(6,1,:)=polyval(p,ALT_MAP(6,2,:));
if (plotar==1)
    plot(interp1(correcao_x,x_graph,curve(:,1),'linear','extrap'),curve(:,2),'m'); hold on;
    plot(interp1(correcao_x,x_graph,ALT_MAP(6,1),'linear','extrap'),ALT_MAP(6,2),'*r');
end
curve = [17.1949,106.238; 17.2345,103.143; 17.3138,99.1205; 17.3534,93.241; 17.393,85.5049];
% curve(:,1) = interp1(correcao_x,x_graph,curve(:,1),'linear','extrap');
p = polyfit(curve(:,2),curve(:,1),2);
a = p(1);
b = p(2);
c = p(3);
d = 25./(ALT_RPM_FINAL(:,end)-ALT_RPM_FINAL(:,1));
e = -d.*ALT_RPM_FINAL(:,1);
ALT_MAP(7,2,:) = -((b-d)-((b-d).^2-4.*a.*(c-e)).^0.5)./(2.*a);
ALT_MAP(7,1,:)=polyval(p,ALT_MAP(7,2,:));
if (plotar==1)
    plot(interp1(correcao_x,x_graph,curve(:,1),'linear','extrap'),curve(:,2),'m'); hold on;
    plot(interp1(correcao_x,x_graph,ALT_MAP(7,1),'linear','extrap'),ALT_MAP(7,2),'*r');
end
curve = [20.0079,92.9316; 20.0872,90.1466; 20.1268,87.0521; 20.1664,81.4821; 20.206,74.6743];
% curve(:,1) = interp1(correcao_x,x_graph,curve(:,1),'linear','extrap');
p = polyfit(curve(:,2),curve(:,1),2);
a = p(1);
b = p(2);
c = p(3);
d = 25./(ALT_RPM_FINAL(:,end)-ALT_RPM_FINAL(:,1));
e = -d.*ALT_RPM_FINAL(:,1);
ALT_MAP(8,2,:) = -((b-d)-((b-d).^2-4.*a.*(c-e)).^0.5)./(2.*a);
ALT_MAP(8,1,:)=polyval(p,ALT_MAP(8,2,:));
if (plotar==1)
    plot(interp1(correcao_x,x_graph,curve(:,1),'linear','extrap'),curve(:,2),'m'); hold on;
    plot(interp1(correcao_x,x_graph,ALT_MAP(8,1),'linear','extrap'),ALT_MAP(8,2),'*r');
end
curve = [22.9002,79.6254; 23.019,77.1498; 23.1379,73.7459; 23.1775,69.4137; 23.2171,63.2248];
% curve(:,1) = interp1(correcao_x,x_graph,curve(:,1),'linear','extrap');
p = polyfit(curve(:,2),curve(:,1),2);
a = p(1);
b = p(2);
c = p(3);
d = 25./(ALT_RPM_FINAL(:,end)-ALT_RPM_FINAL(:,1));
e = -d.*ALT_RPM_FINAL(:,1);
ALT_MAP(9,2,:) = -((b-d)-((b-d).^2-4.*a.*(c-e)).^0.5)./(2.*a);
ALT_MAP(9,1,:)=polyval(p,ALT_MAP(9,2,:));
if (plotar==1)
    plot(interp1(correcao_x,x_graph,curve(:,1),'linear','extrap'),curve(:,2),'m'); hold on;
    plot(interp1(correcao_x,x_graph,ALT_MAP(9,1),'linear','extrap'),ALT_MAP(9,2),'*r');
end
% interpolar estas coordenadas para o MAP desejado - definindo o PONTO A
ALT_MAP_FINAL = interp1(map_graph,ALT_MAP(:,1:2),MAP,'linear','extrap');
if (plotar==1)
    plot(interp1(correcao_x,x_graph,ALT_MAP_FINAL(1),'linear','extrap'),ALT_MAP_FINAL(2),'*g'); hold on;
end
% Plota as curvas de rotação do gráfico de potencia ASL  ajustando suas
% abicissas para os valores [12 30] que são so limites deste gráfico
if (plotar==1)
    subplot(1,2,1); ylim ([20 220]);
    set(fig,'defaultAxesColorOrder',[[0 0 1]; [0 0 0]]);
end
curve = [17.4792,92.0116; 28.7473,184.236];
SEA_RPM (1,:) = interp1(curve(:,1),curve(:,2),[12 30],'linear','extrap');
if (plotar==1)
    plot([12 30],SEA_RPM(1,:),'k'); hold on;
end
curve = [17.502,89.5358; 28.8625,179.903];
SEA_RPM (2,:) = interp1(curve(:,1),curve(:,2),[12 30],'linear','extrap');
if (plotar==1)
    plot([12 30],SEA_RPM(2,:),'k'); hold on;
end
curve = [17.5012,83.9652; 29.0237,174.023];
SEA_RPM (3,:) = interp1(curve(:,1),curve(:,2),[12 30],'linear','extrap');
if (plotar==1)
    plot([12 30],SEA_RPM(3,:),'k'); hold on;
end
curve = [17.5003,77.4662; 29.1381,164.12];
SEA_RPM (4,:) = interp1(curve(:,1),curve(:,2),[12 30],'linear','extrap');
if (plotar==1)
    plot([12 30],SEA_RPM(4,:),'k'); hold on;
end
curve = [17.4992,70.0387; 29.0898,150.503];
SEA_RPM (5,:) = interp1(curve(:,1),curve(:,2),[12 30],'linear','extrap');
if (plotar==1)
    plot([12 30],SEA_RPM(5,:),'k'); hold on;
end

% interpolar estas coordenadas para o RPM e MAP desejado - definindo o PONTO B
SEA_RPM_FINAL = interp1(rpm_graph,SEA_RPM(:,1:2),RPM,'linear','extrap');
if (plotar==1)
    plot([12 30],SEA_RPM_FINAL(:),'b','LineWidth',2); hold on;
end
SEA_MAP_FINAL = ((SEA_RPM_FINAL(:,2)-SEA_RPM_FINAL(:,1))./(30-12)).*MAP + ((SEA_RPM_FINAL(:,1)*30-SEA_RPM_FINAL(:,2)*12)./(30-12));
if (plotar==1)
    plot(MAP,SEA_MAP_FINAL,'*g'); hold on;
    plot([MAP 30],[SEA_MAP_FINAL SEA_MAP_FINAL],'c'); grid on;
end

% interpola na linha que liga o ponto C ao ponto A para a altitude desejada
ALT_FINAL = ((ALT_MAP_FINAL(:,2)-SEA_MAP_FINAL(:))./(ALT_MAP_FINAL(:,1)-0)).*interp1(x_graph,correcao_x,altitude./1000,'linear','extrap') + ((SEA_MAP_FINAL(:).*ALT_MAP_FINAL(:,1)-ALT_MAP_FINAL(:,2).*0)./(ALT_MAP_FINAL(:,1)-0));
if (plotar==1)
    subplot(1,2,2);
    plot(altitude/1000,ALT_FINAL,'*m'); hold on; grid on;
    plot([0 altitude/1000],[SEA_MAP_FINAL ALT_FINAL],'c'); hold on; grid on;
    plot([0 interp1(correcao_x,x_graph,ALT_MAP_FINAL(1),'linear','extrap')],[SEA_MAP_FINAL ALT_MAP_FINAL(2)],'c'); hold on; grid on;
end
% executa a correção de temperatura do ar
Ts = ((9/5).*((288.15 -1.9812e-3.*altitude)-273.15))+32;
temp = ((9/5).*temp)+32;
Power = ALT_FINAL.*((460+Ts)./(460+temp)).^0.5;

% Power = ALT_FINAL;
if (plotar==1)
    plot(altitude/1000,Power,'or','LineWidth',2); hold on;
    plot([altitude/1000 altitude/1000],[ALT_FINAL Power],'c'); hold on;
    subplot(1,2,1); ylim([0 200]); xlabel ('MAP [inHg]'); ylabel('Power [hp]'); grid on;
    subplot(1,2,2); ylim([0 200]); xlabel ('Alt [kft]'); ylabel('Power [hp]'); grid on;
end

MAP_fuel = interp1(SEA_RPM_FINAL(:),[12 30],Power,'linear','extrap');

if (plotar==1)
    subplot(1,2,1);
    plot([MAP_fuel 30],[Power Power],'c'); grid on;
    plot(MAP_fuel,Power,'or','LineWidth',2);
end

cons_curve = [17.5147,8.19678
18.2542,8.60133
19.5021,9.31692
20.7038,10.0633
22.7605,11.4623
24.2626,12.6121
25.5105,13.6372
26.6197,14.6311
27.4979,15.4695
28.6996,16.6803];
cons(1) = interp1(cons_curve(:,1),cons_curve(:,2),MAP_fuel,'linear','extrap');

if (plotar==1)
    subplot(1,2,1);
    yyaxis right
    plot(cons_curve(:,1),cons_curve(:,2),'-b');
end

cons_curve = [17.4916,7.73232
18.6008,8.23079
20.0105,9.00875
21.7668,10.0044
23.2689,11.0303
24.7479,12.0871
26.2269,13.2368
27.2437,14.0756
27.9832,14.7587
28.9769,15.6594];
cons(2) = interp1(cons_curve(:,1),cons_curve(:,2),MAP_fuel,'linear','extrap');

if (plotar==1)
    subplot(1,2,1);
    yyaxis right
    plot(cons_curve(:,1),cons_curve(:,2),'-b');
end

cons_curve = [17.4916,7.0512
19.4097,7.95443
20.8193,8.63951
21.7899,9.16856
22.9685,9.88395
24.1008,10.6302
25.5105,11.5939
26.7353,12.5261
27.9832,13.5204
29,14.3591];
cons(3) = interp1(cons_curve(:,1),cons_curve(:,2),MAP_fuel,'linear','extrap');

if (plotar==1)
    subplot(1,2,1);
    yyaxis right
    plot(cons_curve(:,1),cons_curve(:,2),'-b');
end

cons_curve = [17.5147,6.40111
18.855,7.02408
20.8193,8.02032
22.5525,8.98495
24.2626,10.0114
25.7647,11.0373
27.1282,12.0009];
cons(4) = interp1(cons_curve(:,1),cons_curve(:,2),MAP_fuel,'linear','extrap');

if (plotar==1)
    subplot(1,2,1);
    plot(cons_curve(:,1),cons_curve(:,2),'-b');
end

cons_curve = [17.9538,6.03083
20.2647,7.02805
22.4832,8.025
24.0546,8.77246
25.0021,9.27048];
cons(5) = interp1(cons_curve(:,1),cons_curve(:,2),MAP_fuel,'linear','extrap');

if (plotar==1)
    subplot(1,2,1);
    yyaxis right
    plot(cons_curve(:,1),cons_curve(:,2),'-b');
    ylim([6 31]);
end


consumption = interp1(rpm_graph,cons(:),RPM,'linear','extrap');

if (plotar==1)
    subplot(1,2,1);
    yyaxis right
    plot(MAP_fuel,consumption,'or','LineWidth',2);
    plot([MAP_fuel MAP_fuel],[consumption (Power/200*(31-6))+6],'-c');
    ylim([6 31]);
    ylabel('Fuel Consumption [USgal/hr]')
end


