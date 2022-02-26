function [rho] = density(hp)
    if hp<36089.2 
        I=.24179285;
        J=-1.6624675E-6;
        L=4.2558797;
        rho=(I+J*hp)^L;
    elseif hp<65616.8
        M=4.0012122E-3;
        N=-48.063462E-6;
        rho=M*exp(N*hp);
    else
        I=1.1616564;
        J=1.8005232E-6;
        L=-35.163218;
        rho=(I+J*hp)^L;
    end
end

