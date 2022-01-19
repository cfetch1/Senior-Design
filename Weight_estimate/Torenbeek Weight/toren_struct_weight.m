function [W_struct] = toren_struct_weight(W_w, W_lg, W_emp, W_fuse)
% Torenbeek's method for weight estimation

% airframe structure in this book includes "wing group", "tail group",
% "body group", "alighting gear", and "engine nacelles group" which is the
% same way Roscam grouped "structures weight"

W_struct = W_w + W_lg + W_emp + W_fuse ;
end