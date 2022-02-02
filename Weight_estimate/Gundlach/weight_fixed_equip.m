function [W_feq] = weight_fixed_equip(Wto,Wpay, Scs, b , VeqMax, p_pay, Ltot)
   
    %Ppower draw is going to be around f350
    %avionics weight from Gundlach
    %There are two ways to calculate, jsut need to comment out th eother
    %1: THis uses a take off weight and multiplication factor
    %2: THis adds the weights of each of the items of the avionics

    %Variables
    %favion=multiplication factor (.06-.16), recommended is .1

    %Inputs
    %Wto=weight takeoff
    %Wpay
    %Scs= control surface planform area in ft^2

    %Outputs 
    %Wavion= weight of the avionics

    %Variables
    favion=.1;


%     %Method 1
%     W_avion=favion*Wto;

    %Method 2
    %Weight of autopilot for tactical UAS, with autopilots, VMS, INS (5-10)
    Wauto=5; %lbs
    %Weight of air data system, putot tubes, 1 lb each
    Wads=1;
    %Weight of the gps, rough estimate is 2 lbs
    Wgps=2;
    %Processor weight, super broad guess
    Wproc=10; %lbs
    Wav=Wauto+Wads+Wgps +Wproc;

    %Communication weight
    %Comms https://www.l3harris.com/sites/default/files/2021-01/cs-bcs-mini-t2-transceiver-sell-sheet.pdf
    Wcomm=5.5;
    %Wiring harness weight
    %fwiring range .2-.35
    fwiring=.2;
    Wwiring=fwiring*(Wav+Wpay+Wcomm);

    W_avion=Wav+Wwiring+Wcomm;
    
    %Flight control system (flight control actuators and mechanisms)
    %Ffcs = multiplication factor .00007-.0002 We are probably around .000095
    Ffcs=.000095;
    %Scs=control surface planform area [ft]

    %VeqMax = maximum equivalent airspeed in KEAS  ***[KEAS]

    Wfcs=Ffcs*Scs*VeqMax^2;

    %hydraulis and pneumatic system weights are accoutned for in the flight
    %controls
    %Need to make sure that the weight output from that is reasonble


    %ECS
    %fmod"modiication factor .5 for a tactical uas
    fmod=.5;
    Wecs=fmod*202*((W_avion+Wpay)/1000)^.75; %[lb]

    %Electrical system weight
    %p_pay=maimum payload power draw [watts]
    %***Need to calculate 
    %Wavion=weight of the avionics
        %This is going to be pulled from the summation of all the data above
    %Ltot=total uav length in feet [ft]
    %b=wingspan
   
    Welec=.003*(p_pay+15*W_avion)^.08*(Ltot+b)^.7; %[lb]
    %This is for a hundred amp hour battery 
    W_bat=50; 
    W_feq=Welec+Wecs+Wfcs+W_avion+Wpay+W_bat;
    %Technology increment
    
end   


