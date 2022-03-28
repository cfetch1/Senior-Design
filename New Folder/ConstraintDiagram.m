function [PW,WS] = ConstraintDiagram(Vc,hc,throttle,Sg,CL_max,AR,f)
WS_ = 5:.1:40;
WS_lg = f_WS_landing(Sg,CL_max,f);
PW_to = f_PW_takeoff(WS_,Sg,CL_max);
PW_cr = f_PW_cruise(AR, WS_, Vc, f(3), hc, throttle);
for ii = 1:length(WS_)
    PW_min(ii) = max([PW_to(ii),PW_cr(ii)]);
    if PW_min(ii) == min(PW_min)
        if WS_(ii)<=WS_lg
            WS = WS_(ii);
            PW = PW_min(ii);
        end
    end
end

end

