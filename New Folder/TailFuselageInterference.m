function [CD] = TailFuselageInterference(n,tc,cj,S)
CD = n*(.8*tc^3-.0005)*cj^2/S;
end

