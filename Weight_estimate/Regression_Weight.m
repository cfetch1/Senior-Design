clc
clear
close all

%plot the regressino lines
%[AR5 Rq2 Reaper Cessna Predator Tiger Shark RQ 7 Selex Virus

%Raymer
actual=[396.5,392,1661,2290,515,375,1323]';
raym_calc=[662.08,392.14,1269,2744,501.36,334.10,949.9696]';
tbl=table(actual, raym_calc);
mdl_raym=fitlm(tbl,'actual ~ raym_calc')
figure
plot(mdl_raym, 'LineWidth',2.5)
xlabel('Raymer MTOW Estimation [lbs]','FontSize',14,'FontWeight','bold')
ylabel('Actual Aircraft MTOW [lbs]','FontSize',14,'FontWeight','bold')
title("Linear Regression Model: Actual MTOW vs Raymer MTOW Estimation")
grid on
set(gca,'FontWeight','bold','FontSize',18,'FontWeight','bold')
legend('Location','northwest')


% plotregression(actual,raym_calc,'Regression')
% title("Raymer")
% xlabel("Actual")
% ylabel("Calculated")
err_raym=immse(raym_calc,actual)
%Roskam
rosk_calc=[1130.5,666.95,1527.6,4287.9,882.36,750.33,2703]';
tbl=table(actual, rosk_calc);
mdl_rosk=fitlm(tbl,'actual ~ rosk_calc')
figure
plot(mdl_rosk);
err_rosk=immse(rosk_calc,actual)
%nikolai
nik_calc=[572.59,351.79,1222.4,2067.5,482.1154,328.75,912.2161]';
tbl=table(actual, nik_calc);
mdl_nik=fitlm(tbl,'actual ~ nik_calc')
figure
plot(mdl_nik);
err_nik=immse(nik_calc,actual)

%howe
howe_calc=[580.67,408.3374,1269,2169,502.1611,380.554,1031.7]';
tbl=table(actual, howe_calc);
mdl_howe=fitlm(tbl,'actual ~ howe_calc')
figure
plot(mdl_howe);
err_howe=immse(howe_calc,actual)

for i=1:length(actual)
    raym_ratio(i)=raym_calc(i)/actual(i);
    rosk_ratio(i)=rosk_calc(i)/actual(i);
    nik_ratio(i)=nik_calc(i)/actual(i);
    howe_ratio(i)=howe_calc(i)/actual(i);
end
std_dev=[std(raym_ratio);std(rosk_ratio);std(nik_ratio);std(howe_ratio)];
ratio=[mean(raym_ratio);mean(rosk_ratio);mean(nik_ratio);mean(howe_ratio)];
label=["Raymer";"Roskam";"Nikolai";"Howe"];
disp(table(label,ratio,std_dev));
