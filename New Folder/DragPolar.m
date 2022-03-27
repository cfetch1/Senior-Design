function [f] = DragPolar(file,MTOW,S,c,b,c_root,c_tip,S_h,c_T,L_fuselage);

writecell(mat2cell(MTOW,1),file,'Sheet','Sheet1','Range','D6');
writecell(mat2cell(c,1),file,'Sheet','Sheet1','Range','J5');
writecell(mat2cell(b,1),file,'Sheet','Sheet1','Range','J6');
writecell(mat2cell(c_root,1),file,'Sheet','Sheet1','Range','J7');
writecell(mat2cell(c_tip,1),file,'Sheet','Sheet1','Range','J7');
writecell(mat2cell(S_h/S,1),file,'Sheet','Sheet1','Range','J14');
writecell(mat2cell(c_T/S,1),file,'Sheet','Sheet1','Range','J15');
writecell(mat2cell(L_fuselage,1),file,'Sheet','Sheet1','Range','J16');


file = readmatrix('Drag.xlsx', 'Range', 'B20:V29');
dV = 60:10:260;
j = 1;
fc = polyfit([0,.2,.4,.6,.8,1],[1.2,1.21,1.29,1.5,1.76,1.78],3);

% Iteratre throught velocity vector
for ii = 1:length(dV)

    %% Wing Data from AVL
    V = dV(ii);
    V_fps = file(1,ii);


    alpha = file(2,ii);
    CL_W = file(3,:);
    CDi_W = file(4,:);
    CD0_W = file(5,:);
    CL_HT = file(6,:);
    CDi_HT = file(7,:);
    CD0_HT = file(8,:);
    CD0_VT = file(9,:);

    %% Flight Conditions

    h = 18000;
    [~,~,rho] = ISA_english(h);

    %% Geometric Inputs

    kk = (S/40)^(1/3);
    SA = 4.743*kk^2;
    SC = 12.2804*kk^2;
    Scab = 1.7671;
    Spx0 = 40.2806*kk^2;
    alphaB0 = -5;
    diaB = 2*kk;
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
    dCDS_cab = 0; %.009;
    k = .91;
    K = 9;
    F = 1.08;
    eta = .675;
    CDC = polyval(fc,MC);
    CDS_LG = [.484,.484,.484]/2;
    CDScam = .47;
    FOScam = 1;
    CDSrad = .47;
    FOSrad = 1;

    % Fuselage Lift - Drag
    [CL_B(ii),~,CD0_B(ii),CDi_B(ii)] = FuselageLiftDrag(alpha,alphaB0,S,k,diaB,eta,CDC,Spx0,Cf,F,SA,SC,K,dCDS_cab,Scab);

    % Landing Gear Drag
    [CD_LG(ii)] = LandingGearDrag(CDS_LG,d_LG,w_LG,S);

    % (Gimbal) Camera Drag -> Merged with fuselage -> 0
    [CDcam(ii)] = ShapeDrag(0,Scam,S,FOScam);

    % (Gimbal) Radar Drag
    [CDrad(ii)] = ShapeDrag(CDSrad,Srad/2,S,FOSrad);

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


    %CD_cool = [0.001825 0.001564 0.001369 0.001217 0.001095 0.000996 0.000913 0.000842 0.000782 0.000730];
    CD_cool = linspace(0.001825,0.000730, length(dV));
    CD_cool = CD_cool(ii);


    CD0(j) = CD0_W(ii) + CD0_HT(ii) + CD0_VT(ii) + CD0_B(ii) + CD_LG(ii) + CD_duct(ii) + CD_cool(1)+CDcam(ii)+CDrad(ii);
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

f = polyfit(CL,CD,2);


end

