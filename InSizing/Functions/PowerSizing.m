function [PW,AR,WS] = PowerSizing(AR_,WS_,Wto,Wcruise,Vc,CL_to,CLmax,Sg,dg,h,f,pct)

%% POWER SIZING

% Set Constants/Anonymous Function

% Begin Power Sizing Loop

% Calculate PWcruise
PWcruise = PW_cruise(AR_, WS_, Vc, f(3), h, pct);

% Calculate PWtakeoff
PWto = PW_takeoff(AR_,WS_,Sg,0,CL_to,f,Vc*1.69);

% Calculate PWclimb (derived)

% Calculate WSlanding
WSlim = WS_landing(h,dg,CLmax);

for ii = 1:length(AR_)
        PW_AR(ii) = max([Wcruise*PWcruise(ii,:),Wto*PWto(ii,:)]);
        if PW_AR(ii) == min(PW_AR)
            index1 = ii;
        end
end

jj = 1;
while WS_(jj)<WSlim
        PW_WS(jj) = max([Wcruise*PWcruise(:,jj);Wto*PWto(:,jj)]);
        if PW_WS(jj) == min(PW_WS)
            index2 = jj;
        end
        jj = jj+1;
end
    

PW = PW_AR(index1);
AR = AR_(index1);
WS = WS_(index2);






end

