function [CD] = RadarFuselageInterference(phi_tip,phi_MGC)
CD=.00004*(phi_tip-phi_MGC);
end

