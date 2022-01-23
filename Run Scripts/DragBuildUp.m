close all
clear all
%clc

% cd('C:\Users\grega\Documents\GitHub\Senior-Design\Run Scripts')

file = load('AVLdrag.csv');

fc = polyfit([0,.2,.4,.6,.8,1],[1.2,1.21,1.29,1.5,1.76,1.78],3);

err = std([.0202,.0192,.0295,.0346,.0329,.0291,.0319,.047,.026,.0312,.0218,.0223,.0247,.0297,.0270,.0355,.0255,.0254,.0287,.0488,.0680,.0174,.0189,.0320,.0373,.0258,.0389,.0237,.0445,.0559,.0247,.0233]);
j = 1;
for ii = 1:10

%% Wing Data from AVL

alpha = file(1,ii);
CL_W = file(2,:);
CDi_W = file(3,:);
CD0_W = file(4,:);
CL_HT = file(5,:);
CDi_HT = file(6,:);
CD0_HT = file(7,:);
CD0_VT = file(8,:);

cd('C:\Users\grega\Documents\GitHub\Senior-Design\Functions')

%% Flight Conditions

h = 7000;
dV = 60:10:150; %kts
V = dV(ii);
V_fps = V*1.69;
[T,P,rho] = ISA_english(h);

%% Geometric Inputs

S = 38.63;
SA = 4.743;
SC = 12.2804;
Scab = 1.7671;
Spx0 = 40.2806;
alphaB0 = -2.96;
diaB = 1.5;
w_LG = [1/6,1/6,1/8];
d_LG = [2/3,2/3,1/2];
Scam = 1.136;
Srad = 45.8/144;
nT = 5;
tc_T = 3.25/(.5*(29.9+11.97));
cT = 29.92/12;
A = .3061;
V2 = .9;
M = V*1.69*.3048/sqrt(1.4*296*278);
MC = M*sind(alpha);

%% Assumptions/Hand Calcs
Cf = (8.5-4.5*sqrt(ii/7))*10^-3;
dCDS_cab = .009;
k = .91;
K = 9;
F = 1.08;
eta = .675;
CDC = polyval(fc,MC);
CDS_LG = [.484,.484,.484]/2;
CDScam = .47;
FOScam = 1;
CDSrad = .47;
FOSrad = .5;

% Fuselage Lift - Drag
[CL_B(ii),~,CD0_B(ii),CDi_B(ii)] = FuselageLiftDrag(alpha,alphaB0,S,k,diaB,eta,CDC,Spx0,Cf,F,SA,SC,K,dCDS_cab,Scab);

% Landing Gear Drag
[CD_LG(ii)] = LandingGearDrag(CDS_LG,d_LG,w_LG,S);

% (Gimbal) Camera Drag
[CDcam(ii)] = ShapeDrag(CDScam,Scam,S,.5);

% (Gimbal) Radar Drag
[CDrad(ii)] = ShapeDrag(CDSrad,Srad/2,S,.5);

% Wing-Fuselage Interference Drag
[CD_WB(ii)] = .05*(CD0_B(ii)+CDi_B(ii));
 
% Tail-Fuselage Interference Drag
[CD_WT(ii)] = TailFuselageInterference(2,tc_T,cT,S);

% Air Intake Drag
CD_duct(ii) = DuctDrag(h,A,V,V*V2,S);

% Radar Interference
CD_BR1(ii) = .05*CDrad(ii);
dphi = atand(6.93/25.05)-atand(6.93/(25.05+52.7/2));
CD_BR(ii) = WashoutDrag(dphi,0,Srad/2,S,1.2);


% Camera Interference
CD_BC1(ii) = .05*CDcam(ii);
dphi = atand(6.44/(5.13-3.53))-atand(6.44/5.13);
CD_BC(ii) = WashoutDrag(dphi,0,Scam,S,1.5);


CD_cool = [0.001825 0.001564 0.001369 0.001217 0.001095 0.000996 0.000913 0.000842 0.000782 0.000730];



CD0(j) = CD0_W(ii) + CD0_HT(ii) + CD0_VT(ii) + CD0_B(ii) + CD_LG(ii) + CD_duct(ii) + CD_cool(ii)+CDcam(ii)+CDrad(ii);
CDi(j) =  CDi_W(ii) + CDi_HT(ii) + CDi_B(ii);
CD_int(j) = CD_WB(ii) + CD_WT(ii) + CD_BR(ii) + CD_BC(ii);
 %CD(j) = 1.05*CD0(j)+1.2*CDi(j)+1.1*CD_int(j);
%CD(j) = CD0(j)+CDi(j)+CD_int(j)+err;
CD(j) = CD0(j)+CDi(j)+CD_int(j);

CL(j) = CL_W(ii) + CL_HT(ii) + CL_B(ii);
L(j) = .5*S*rho*V_fps^2*CL(j);
D(j) = .5*S*rho*V_fps^2*CD(j);
E(j) = CL(j)/CD(j);
j = j+1;



end


j = 7;
x = [CD0_W(j)+CDi_W(j),CD0_HT(j)+CDi_HT(j)+CD0_VT(j),CD0_B(j)+CDi_B(j),CD_LG(j),CD_duct(j)+CD_cool(j),CDcam(j),CDrad(j),CD_int(j)];
pie(x*100);
legend('Wing','Tail','Fuselage','Landing Gear','Inlets','Camera','Radar','Interference','location','best')














% 
% 
% f1 = polyfit(CD0_W+CDi_W,CL_W,2);
% f2 = polyfit(CD0_HT+CDi_HT+CD0_VT,CL_HT,2);
% f3 = polyfit(CD0_B+CDi_B,CL_B,2);
% dx = linspace(.002,.042,100);
% figure 
% hold on
% plot(CD0_W+CDi_W,CL_W,'b','linewidth',2)
% plot(CD0_HT+CDi_HT+CD0_VT,CL_HT,'r','linewidth',2)
% plot(CD0_B+CDi_B,CL_B,'g','linewidth',2)
% % plot(dx,polyval(f1,dx),'b--','linewidth',2)
% % plot(dx,polyval(f2,dx),'r--','linewidth',2)
% % plot(dx,polyval(f3,dx),'g--','linewidth',2)
% grid on
% ylabel('CL')
% xlabel('CD')
% axis([0,.02,0,1])
% legend('Wing','Tail','Fuselage')
% alpha = file(1,:);
% % f1 = polyfit(alpha,CL_W,2);
% % f2 = polyfit(alpha,CL_HT,2);
% % f3 = polyfit(alpha,CL_B,2);
% dx = linspace(0,10,100);
% figure 
% hold on
% plot(alpha,CL_W,'b','linewidth',2)
% plot(alpha,CL_HT,'r','linewidth',2)
% plot(alpha,CL_B,'g','linewidth',2)
% grid on
% ylabel('CL')
% xlabel('AoA')
% axis([0,10,0,1])
% legend('Wing','Tail','Fuselage')



f = polyfit(CL,CD,2);
dy = linspace(0,2,100);
dx = polyval(f,dy);
CD0 = polyval(f,0);
E = dy/dx;
Emax = max(E);

x1 = [0.0350000000000000,0.0350033423453112,0.0350133693812448,0.0350300811078008,0.0350534775249791,0.0350835586327799,0.0351203244312030,0.0351637749202486,0.0352139100999165,0.0352707299702068,0.0353342345311195,0.0354044237826546,0.0354812977248121,0.0355648563575920,0.0356550996809943,0.0357520276950189,0.0358556403996660,0.0359659377949354,0.0360829198808272,0.0362065866573415,0.0363369381244781,0.0364739742822371,0.0366176951306185,0.0367681006696223,0.0369251908992484,0.0370889658194970,0.0372594254303679,0.0374365697318613,0.0376203987239770,0.0378109124067151,0.0380081107800757,0.0382119938440586,0.0384225615986639,0.0386398140438915,0.0388637511797416,0.0390943730062141,0.0393316795233089,0.0395756707310262,0.0398263466293658,0.0400837072183279,0.0403477524979123,0.0406184824681191,0.0408958971289483,0.0411799964803999,0.0414707805224739,0.0417682492551702,0.0420724026784890,0.0423832407924301,0.0427007635969937,0.0430249710921796,0.0433558632779879,0.0436934401544186,0.0440377017214717,0.0443886479791472,0.0447462789274451,0.0451105945663654,0.0454815948959081,0.0458592799160731,0.0462436496268606,0.0466347040282704,0.0470324431203026,0.0474368669029572,0.0478479753762342,0.0482657685401336,0.0486902463946554,0.0491214089397996,0.0495592561755662,0.0500037881019551,0.0504550047189665,0.0509129060266002,0.0513774920248563,0.0518487627137349,0.0523267180932358,0.0528113581633591,0.0533026829241048,0.0538006923754728,0.0543053865174633,0.0548167653500762,0.0553348288733114,0.0558595770871691,0.0563910099916491,0.0569291275867515,0.0574739298724763,0.0580254168488235,0.0585835885157931,0.0591484448733851,0.0597199859215995,0.0602982116604363,0.0608831220898954,0.0614747172099769,0.0620729970206809,0.0626779615220072,0.0632896107139559,0.0639079445965270,0.0645329631697205,0.0651646664335364,0.0658030543879747,0.0664481270330354,0.0670998843687184,0.0677583263950239,0.0684234531119517,0.0690952645195019,0.0697737606176745,0.0704589414064696,0.0711508068858870,0.0718493570559268,0.0725545919165890,0.0732665114678735,0.0739851157097805,0.0747104046423098,0.0754423782654616,0.0761810365792357,0.0769263795836322,0.0776784072786511,0.0784371196642924,0.0792025167405561,0.0799745985074422,0.0807533649649507,0.0815388161130816,0.0823309519518348,0.0831297724812105,0.0839352777012085,0.0847474676118289,0.0855663422130717,0.0863919015049369,0.0872241454874245,0.0880630741605345,0.0889086875242669,0.0897609855786217,0.0906199683235988,0.0914856357591984,0.0923579878854203,0.0932370247022646,0.0941227462097314,0.0950151524078205,0.0959142432965320,0.0968200188758659,0.0977324791458222,0.0986516241064008,0.0995774537576019,0.100509968099425,0.101449167131871,0.102395050854939,0.103347619268630,0.104306872372943,0.105272810167878,0.106245432653436,0.107224739829616,0.108210731696419,0.109203408253844,0.110202769501891,0.111208815440561,0.112221546069853,0.113240961389768,0.114267061400305,0.115299846101464,0.116339315493246,0.117385469575650,0.118438308348676];
y1 = [0,0.0100000000000000,0.0200000000000000,0.0300000000000000,0.0400000000000000,0.0500000000000000,0.0600000000000000,0.0700000000000000,0.0800000000000000,0.0900000000000000,0.100000000000000,0.110000000000000,0.120000000000000,0.130000000000000,0.140000000000000,0.150000000000000,0.160000000000000,0.170000000000000,0.180000000000000,0.190000000000000,0.200000000000000,0.210000000000000,0.220000000000000,0.230000000000000,0.240000000000000,0.250000000000000,0.260000000000000,0.270000000000000,0.280000000000000,0.290000000000000,0.300000000000000,0.310000000000000,0.320000000000000,0.330000000000000,0.340000000000000,0.350000000000000,0.360000000000000,0.370000000000000,0.380000000000000,0.390000000000000,0.400000000000000,0.410000000000000,0.420000000000000,0.430000000000000,0.440000000000000,0.450000000000000,0.460000000000000,0.470000000000000,0.480000000000000,0.490000000000000,0.500000000000000,0.510000000000000,0.520000000000000,0.530000000000000,0.540000000000000,0.550000000000000,0.560000000000000,0.570000000000000,0.580000000000000,0.590000000000000,0.600000000000000,0.610000000000000,0.620000000000000,0.630000000000000,0.640000000000000,0.650000000000000,0.660000000000000,0.670000000000000,0.680000000000000,0.690000000000000,0.700000000000000,0.710000000000000,0.720000000000000,0.730000000000000,0.740000000000000,0.750000000000000,0.760000000000000,0.770000000000000,0.780000000000000,0.790000000000000,0.800000000000000,0.810000000000000,0.820000000000000,0.830000000000000,0.840000000000000,0.850000000000000,0.860000000000000,0.870000000000000,0.880000000000000,0.890000000000000,0.900000000000000,0.910000000000000,0.920000000000000,0.930000000000000,0.940000000000000,0.950000000000000,0.960000000000000,0.970000000000000,0.980000000000000,0.990000000000000,1,1.01000000000000,1.02000000000000,1.03000000000000,1.04000000000000,1.05000000000000,1.06000000000000,1.07000000000000,1.08000000000000,1.09000000000000,1.10000000000000,1.11000000000000,1.12000000000000,1.13000000000000,1.14000000000000,1.15000000000000,1.16000000000000,1.17000000000000,1.18000000000000,1.19000000000000,1.20000000000000,1.21000000000000,1.22000000000000,1.23000000000000,1.24000000000000,1.25000000000000,1.26000000000000,1.27000000000000,1.28000000000000,1.29000000000000,1.30000000000000,1.31000000000000,1.32000000000000,1.33000000000000,1.34000000000000,1.35000000000000,1.36000000000000,1.37000000000000,1.38000000000000,1.39000000000000,1.40000000000000,1.41000000000000,1.42000000000000,1.43000000000000,1.44000000000000,1.45000000000000,1.46000000000000,1.47000000000000,1.48000000000000,1.49000000000000,1.50000000000000,1.51000000000000,1.52000000000000,1.53000000000000,1.54000000000000,1.55000000000000,1.56000000000000,1.57000000000000,1.58000000000000];

y2 = linspace(0,2,100);
x2 = 0.02429 + 0.07169*y2.^2;

y3 = linspace(0,2,100);
x3 = 0.033 + 0.035*(y3-.14).^2;

ff = [0.0092   -0.0054    0.0203];

figure 
hold on
%plot(CD,CL,'g','linewidth',2)
plot(dx,dy,'g','linewidth',2)
plot(x1,y1,'r','linewidth',2)
plot(x2,y2,'b','linewidth',2)
plot(x3,y3,'m','linewidth',2)
ylabel('C_L')
xlabel('C_D')
grid on
axis([0,max(CD),0,max(CL)])
ax=gca;
ax.XAxis.Exponent = 0;
ax.XTick = 0:.025:1000;
ax.XAxis.MinorTick='on';
ax.XAxis.MinorTickValues = 0:.005:1000;
ax.YAxis.Exponent = 0;
ax.YTick = 0:.25:30000;
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues = 0:.05:30000;
legend('Current Drag Estimate','Initial Drag Estimate','RV7','Cessna 172','location','best')
% 
% figure 
% hold on
% plot(x2,y2,'b','linewidth',2)
% plot(polyval(ff,y2),y2,'r','linewidth',2)
% grid on
% axis([0,max(CD),0,max(CL)])






% plot(file(1,1:ii),CL)
% ylabel('CL')
% xlabel('alpha')
% grid on
% axis([min(file(1,1:ii)),max(file(1,1:ii)),0,max(CL)])

cd('C:\Users\grega\Documents\GitHub\Senior-Design\Run Scripts')
%close all
% clc