function [r] = rho_us(Hp)
    if Hp<36089.2 %values from IAS table
        I=.24179285;
        J=-1.6624675E-6;
        L=4.2558797;
        r=(I+J*Hp)^L;
    elseif Hp<65616.8
        M=4.0012122E-3;
        N=-48.063462E-6;
        r=M*exp(N*Hp);
    else
        I=1.1616564;
        J=1.8005232E-6;
        L=-35.163218;
        r=(I+J*Hp)^L;
    end
end

