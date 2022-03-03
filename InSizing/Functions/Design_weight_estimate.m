function [MTOW_calc, Wcomp] = Design_weight_estimate(S_v,S_h,S, b, P,Wf, Vcruise,b_v,b_h,L_fuselage)
   

%Weigth esimate code
    %The idea is that this will take all the inputs from other engine stuff and
    %with the estimate MTOW, will determine the actual MTOW by iterating until
    %the numbers converge within a certain tolerance.
    %This will be th
    %initial guess for our plane
    disp("Our PLane");
    MTOW_in1=(500); %[lb]
    MTOW_in2=MTOW_in1*5;
    MTOW_in=[MTOW_in1,MTOW_in2];


    %Variables
    Scs=3; %[ft^2]  %Control surface planform area  
    %b=41.8;    %wingspan %[ft]
    VeqMax=Vcruise*1.35; %Max veloicty in [KEAS]
    p_pay=320; %Max payload power [Watts]
    L_f=L_fuselage; %lengyth of the fuselage [ft^2]
    L_f=10.5;
    ratio=L_f/14.9;
    Wpay=90; %payload weight [lb]
    Nprop=1;    %Number of props
    D=3.56;    %Propeller diameter %[ft]
    N_blades=4;     %Number of blades
    %P=578;  %Max shaft horsepower
    Wengine=.484*(P^.7956); %Engine weight [lb]
    Wengine= 110;
    %Wf=232;   %Fuel weight %[lb]
    %S=117;    %Wing area %[ft^2]
    AR=15;  %Aspect 
    fuse_width=(1.5)*ratio; %fuselage width %[ft}
    fuse_width=2;
    fuse_diam=(1.5)*ratio; %fuselage diameter%[ft
    fuse_diam=2;
    pmax=2*pi*(fuse_width/2);  %Corss sectional circumference%[ft^2]
    Npax=.001;    %Number of pax, this will be estimated
    %S_h=12;   %Horizontal Tail area %[ft^2]
    A_h=3;    %Horizontal tair AR
    t_rh=.16;  %t_rh = horizontal tail maximum root thickness in ft
    %S_v=17.9;   %vertical tail area in ft^2 %[ft^2]
    %b_v=6.21;   %Span of vertical tail

    %Span of horizontal tail
    %b_h=7; %[ft%dustance from wing one fourth mac to tail onforth mac
    lt=3.5;   %dustance from wing one fourth mac to tail onforth mac
    sweep=0;    %wing quarter chord sweep
    lambda=.5;  %wing taper ratio
    fuse_height=2.75*ratio;%Fueselage height%Ft
    fuse_height=1.83;
    V_d=VeqMax*1.25;    %max dive speed
    N_bar=180;
    A_v=.38; %vertical tail aspect ratio
    t_rv=.16;  %vertical tail maximum root thickness in ft
    sw_a=1;    %vertical tail quarter cord sweep angle
    L_sm=14; %shock strut length for main gear[in]
    L_sn=14; %shock strut length for nose gear[in]
    v_d=VeqMax*1.25;    %mAX DIVE SPEED
    t_c=.14;    %Wing thickness
    L_D=17.4; %This is an estimate(14), bigger high L/d
    S_f=2*pi*(fuse_diam/2)*L_f+2*pi*(fuse_diam/2)^2;  %Sf fuselage area ft^2
    S_f=8;
    q=47.74;   %dynamic press
    N_z=6;    %Safety factor
    %TTail stuff
    sweep_ht=3.7;
    taper_ht=.67;
    sweep_vt=3.7;
    taper_vt=.67;

    %% Main Code


    eps=2; 
    err=abs(MTOW_in(2)-MTOW_in(1));
%     prompt='Which Method do you want';
%     disp("1:Roskam");
%     disp("2:Nicolai");
%     disp("3:Howe");
%     disp("4:Raymer");
%     disp(" ");
%     str=input(prompt,'s');
    str = char('4');
    if str == "1"
            disp("Roskam");
            for i=1:length(MTOW_in)

                [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, L_f);
                [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
                [w_prop(i)] = weight_prop(Nprop,D,N_blades,P);
                [W_fuel_sys(i)] = weight_fuel_system(Wf);
                [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, L_f, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wf, L_sm, L_sn);    
                [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wf,L_sm,S_v,b_v,t_rv,VeqMax,fuse_width, fuse_diam, L_f,S_h,lt,t_rh,b_h,AR, sweep, S, lambda, t_c);
                [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),L_f,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
                [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wf,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
                 MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wf+W_struct_roskam(i)+Wengine;
                Diff(i)=MTOW_calc(i)-MTOW_in(i);
                if i == 2
                    MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
                    err(i)=abs(MTOW_in(i+1)-MTOW_in(i));
                end
            end

            while err(i)>eps
                i=i+1;

                [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, L_f);
                [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
                [w_prop(i)] = weight_prop(Nprop,D,N_blades,P);
                [W_fuel_sys(i)] = weight_fuel_system(Wf);
                [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, L_f, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wf, L_sm, L_sn);    
                [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wf,L_sm,S_v,b_v,t_rv,VeqMax,fuse_width, fuse_diam, L_f,S_h,lt,t_rh,b_h,AR, sweep, S, lambda, t_c);
                [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),L_f,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
                [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wf,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
                MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wf+W_struct_roskam(i)+Wengine;
                Diff(i)=MTOW_calc(i)-MTOW_in(i);
                MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
                err(i)=abs(MTOW_in(i+1)-MTOW_in(i));  
                comp_int=[(W_prop_sys(end)+Wengine(end)+w_prop(end));(W_fuel_sys(end)+Wf(end));W_feq(end);(W_feq(end)+W_prop_sys(end)+w_prop(end)+W_fuel_sys(end)+Wf(end)+Wengine(end))];
                comp_var=["Propulsion Sys";"Fuel Sys";"Fixed Eq";"Total internal/avionics"];
                comp=[comp_var,comp_int];
                Wcomp_rosk=cat(1,Wcomp_rosk,comp);
            end

            disp(Wcomp_rosk);
            disp(real(MTOW_calc(end)));
    elseif str == "2"
            disp("Nicolai");
            for i=1:length(MTOW_in)

                [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, L_f);
                [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
                [w_prop(i)] = weight_prop(Nprop,D,N_blades,P);
                [W_fuel_sys(i)] = weight_fuel_system(Wf);
                [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, L_f, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wf, L_sm, L_sn);    
                [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wf,L_sm,S_v,b_v,t_rv,VeqMax,fuse_width, fuse_diam, L_f,S_h,lt,t_rh,b_h,AR, sweep, S, lambda, t_c);
                [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),L_f,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
                [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wf,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
                 MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wf+W_airframe(i)+Wengine;
                Diff(i)=MTOW_calc(i)-MTOW_in(i);
                if i == 2
                    MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
                    err(i)=abs(MTOW_in(i+1)-MTOW_in(i));
                end
            end

            while err(i)>eps
                i=i+1;
                [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, L_f);
                [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
                [w_prop(i)] = weight_prop(Nprop,D,N_blades,P);
                [W_fuel_sys(i)] = weight_fuel_system(Wf);
                [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, L_f, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wf, L_sm, L_sn);    
                [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wf,L_sm,S_v,b_v,t_rv,VeqMax,fuse_width, fuse_diam, L_f,S_h,lt,t_rh,b_h,AR, sweep, S, lambda, t_c);
                [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),L_f,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
                [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wf,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
                MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wf+W_airframe(i)+Wengine;
                Diff(i)=MTOW_calc(i)-MTOW_in(i);
                MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
                err(i)=abs(MTOW_in(i+1)-MTOW_in(i));  
                comp_int=[(W_prop_sys(end)+Wengine(end)+w_prop(end));(W_fuel_sys(end)+Wf(end));W_feq(end);(W_feq(end)+W_prop_sys(end)+w_prop(end)+W_fuel_sys(end)+Wf(end)+Wengine(end))];
                comp_var=["Propulsion Sys";"Fuel Sys";"Fixed Eq";"Total internal/avionics"];
                comp=[comp_var,comp_int];
                Wcomp_nic=cat(1,Wcomp_nic,comp);

            end

            disp(Wcomp_nic);
                    disp(real(MTOW_calc(end)));
    elseif str =="3"
            disp("Howe");
            for i=1:length(MTOW_in)

                [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, L_f);
                [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
                [w_prop(i)] = weight_prop(Nprop,D,N_blades,P);
                [W_fuel_sys(i)] = weight_fuel_system(Wf);
                [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, L_f, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wf, L_sm, L_sn);    
                [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wf,L_sm,S_v,b_v,t_rv,VeqMax,fuse_width, fuse_diam, L_f,S_h,lt,t_rh,b_h,AR, sweep, S, lambda, t_c);
                [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),L_f,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
                [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wf,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
                 MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wf+Howe_weight(i)+Wengine;
                Diff(i)=MTOW_calc(i)-MTOW_in(i);
                if i == 2
                    MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
                    err(i)=abs(MTOW_in(i+1)-MTOW_in(i));
                end
            end

            while err(i)>eps
                i=i+1;
                [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, L_f);
                [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
                [w_prop(i)] = weight_prop(Nprop,D,N_blades,P);
                [W_fuel_sys(i)] = weight_fuel_system(Wf);
                [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, L_f, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wf, L_sm, L_sn);    
                [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wf,L_sm,S_v,b_v,t_rv,VeqMax,fuse_width, fuse_diam, L_f,S_h,lt,t_rh,b_h,AR, sweep, S, lambda, t_c);
                [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),L_f,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
                [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wf,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
                MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wf+Howe_weight(i)+Wengine;
                Diff(i)=MTOW_calc(i)-MTOW_in(i);
                MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
                err(i)=abs(MTOW_in(i+1)-MTOW_in(i));  
                comp_int=[(W_prop_sys(end)+Wengine(end)+w_prop(end));(W_fuel_sys(end)+Wf(end));W_feq(end);(W_feq(end)+W_prop_sys(end)+w_prop(end)+W_fuel_sys(end)+Wf(end)+Wengine(end))];
                comp_var=["Propulsion Sys";"Fuel Sys";"Fixed Eq";"Total internal/avionics"];
                comp=[comp_var,comp_int];
                Wcomp_howe=cat(1,Wcomp_howe,comp);

            end

            disp(Wcomp_howe);
                    disp(real(MTOW_calc(end)));
    elseif str=="4"
            disp("Raymer")
            for i=1:length(MTOW_in)

                [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, L_f);
                [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
                [w_prop(i)] = weight_prop(Nprop,D,N_blades,P);
                [W_fuel_sys(i)] = weight_fuel_system(Wf);

                [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, L_f, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wf, L_sm, L_sn);    
                [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wf,L_sm,S_v,b_v,t_rv,VeqMax,fuse_width, fuse_diam, L_f,S_h,lt,t_rh,b_h,AR, sweep, S, lambda, t_c);
                [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),L_f,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
                [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wf,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
                 MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wf+W_aircraft(i)+Wengine;
                Diff(i)=MTOW_calc(i)-MTOW_in(i);
                if i == 2
                    MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
                    err(i)=abs(MTOW_in(i+1)-MTOW_in(i));
                end
            end

            while err(i)>eps
                i=i+1;
                [W_feq(i)] = weight_fixed_equip(MTOW_in(i),Wpay, Scs, b , VeqMax, p_pay, L_f);
                [W_prop_sys(i)] = weight_propulsion_sys(Wengine);
                [w_prop(i)] = weight_prop(Nprop,D,N_blades,P);
                [W_fuel_sys(i)] = weight_fuel_system(Wf);
                [W_struct_roskam(i),Wcomp_rosk] = roskam_weights(MTOW_in(i), S, AR, L_f, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wf, L_sm, L_sn);    
                [W_airframe(i),Wcomp_nic] = Weight_Nikolai(MTOW_in(i), Wf,L_sm,S_v,b_v,t_rv,VeqMax,fuse_width, fuse_diam, L_f,S_h,lt,t_rh,b_h,AR, sweep, S, lambda, t_c);
                [Howe_weight(i),Wcomp_howe] = HOWE_WEIGHT_fun(MTOW_in(i),L_f,fuse_width,fuse_height,v_d,AR,S,sweep,lambda,N_bar,t_c);
                [W_aircraft(i),Wcomp_raymer] = raymer_weight(S,Wf,AR,sweep,lambda,t_c,MTOW_in(i),S_h,S_v,S_f,lt,L_D,L_sm,L_sn,q,sweep_ht,taper_ht,sweep_vt,taper_vt,N_z);
                MTOW_calc(i)=W_feq(i)+W_prop_sys(i)+w_prop(i)+W_fuel_sys(i)+Wf+W_aircraft(i)+Wengine;
                Diff(i)=MTOW_calc(i)-MTOW_in(i);
                MTOW_in(i+1)=MTOW_in(i)-Diff(i)*((MTOW_in(i)-MTOW_in(i-1))/(Diff(i)-Diff(i-1)));
                err(i)=abs(MTOW_in(i+1)-MTOW_in(i));  
                comp_int=real([(W_prop_sys(end)+Wengine(end)+w_prop(end));(W_fuel_sys(end)+Wf(end));W_feq(end);(W_feq(end)+W_prop_sys(end)+w_prop(end)+W_fuel_sys(end)+Wf(end)+Wengine(end))]);
                comp_var=["Propulsion Sys";"Fuel Sys";"Fixed Eq";"Total internal/avionics"];
                comp=[comp_var,real(comp_int)];
                Wcomp_raymer=cat(1,Wcomp_raymer,comp);

            end

            disp(Wcomp_raymer);
                    disp(real(MTOW_calc(end)));
    else
            disp("Wrong input dummy");
    end
    if str == "4"
        Wcomp=Wcomp_raymer;
    elseif str =="3"
        Wcomp=Wcomp_howe;
    elseif str == "2"
        Wcomp=Wcomp_nic;;
    elseif str == "1"
        Wcomp=Wcomp_rosk;
    else
        disp("Code is messed up somewhere");
    end
end



