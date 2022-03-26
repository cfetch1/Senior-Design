function [MTOW]=RangeSizing(Wto,Wf,Wpl)
    error = 1000;
    while (abs(error) > .1) 
        Wf = 143;
        We=Wto-Wf-Wpl;
        A = -.144;
        B = 1.1162;       
        We_log=(10^((log10(Wto)-A)/B));
        error = We-We_log;
        Wto = Wto - error;        
    end   
    MTOW = (We+Wf+Wpl);   
end