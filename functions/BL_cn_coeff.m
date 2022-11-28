function [c_n,c_nC,c_nf,c_nI,alpha_C] = BL_cn_coeff(x,M,U,b,ah,beta,alpha_tqc,c_n_alpha,A1,A2,b1,b2,K_a,K_q,T_I,alpha_bar,q,f2prime_n,alpha_0L,cn_v)

% Circulatory effective angle of attack
alpha_C = beta^2*U/b*(A1*b1*x(1)+A2*b2*x(2))+alpha_tqc*(1-A1-A2);

% Circulatory unsteady - attached flow
c_nC = c_n_alpha*sin(alpha_C-alpha_0L);

% Circulatory unsteady - separated flow
K_f = ((1+f2prime_n^(1/2))/2)^2;
c_nf = c_nC*K_f;

% Inertial
c_nI = -4/(M*K_a*T_I)*x(3) - (-2*ah)/(M*K_q*T_I)*x(4) + 4/M*alpha_bar + (-2*ah)/M*q;

% Total: circulatory + inertial + vortex
c_n = c_nf+c_nI+cn_v;

end