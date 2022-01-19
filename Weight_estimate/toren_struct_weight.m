function [W_struct] = toren_struct_weight(MTOW, bs, b_ref, n_ult, tr, S, s_h, ...
    k_h, f, v_d, lam_h, s_v, k_v, lam_v, w_h, w_v, k, A1, A2, B1, B2, C1, C2, D1, D2,...
    k_wf, lt, bf, hf, S_g) 
% Torenbeek's method for weight estimation

% airframe structure in this book includes "wing group", "tail group",
% "body group", "alighting gear", and "engine nacelles group" which is the
% same way Roscam grouped "structures weight"
[W_w] = toren_wingweight(MTOW, bs, b_ref, n_ult, tr, S);
[W_emp] = toren_empweight(s_h, k_h, f, v_d, lam_h, s_v, k_v, lam_v, w_h, w_v);
[W_lg] = toren_lgweight(MTOW, k, A1, A2, B1, B2, C1, C2, D1, D2);
[W_fus] = toren_fusweight(k_wf, v_d, lt, bf, hf, S_g);

W_struct = W_w + W_lg + W_emp + W_fus ;
end