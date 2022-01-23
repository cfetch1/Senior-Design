function [W_airframe] = Weight_Nikolai(MTOW, Wfuel,L_sm,S_v,bv,t_rv,VeqMax,fuse_width, fuse_diam, Ltot,S_h,lt,t_rh,bh,AR, sweep, S, lambda, t_c)
    [W_lg] = LG_nikolai(MTOW, Wfuel,L_sm)
    [W_ver_tail] = ver_tail_nikolai(MTOW,S_v,bv,t_rv)
    [W_fuse] = fuselage_nikolai(MTOW, VeqMax,fuse_width, fuse_diam, Ltot)
    [W_h_tail] = Hor_tail_nikolai(MTOW, S_h,lt,t_rh,bh)
    [W_struct] = structure_nikolai(MTOW, AR, sweep, S, lambda, t_c, VeqMax)
    
    W_airframe=W_lg+W_ver_tail+W_fuse+W_h_tail+W_struct
end

