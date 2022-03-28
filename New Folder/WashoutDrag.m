function [CD] = WashoutDrag(dphi,alpha,SN,S,FOS)
CD=.00004*(dphi+alpha)*SN*FOS/S;
end

