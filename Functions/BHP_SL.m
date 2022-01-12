function [BHP_SL] = BHP_SL(BHP_req,h)
sigma = sigma0(h);
for ii = 1:length(BHP_req)
    BHP_SL(ii) = BHP_req(ii)/(sigma-(1-sigma)/7.55);
end
end

