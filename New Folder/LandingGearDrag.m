function [CD] = LandingGearDrag(CDS,d,w,S)
for ii = 1:length(CDS)
    CD(ii) = CDS(ii)*d(ii)*w(ii)/S;
end
CD = sum(CD);
end

