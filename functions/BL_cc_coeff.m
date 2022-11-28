function c_c = BL_cc_coeff(alpha,alpha_C,f2prime_c,RD,cc_v,alpha_0L,eta,c_d0,c_n_alpha,E1,upstroke,theta_c,theta_c_db)

% Circulatory unsteady
cc_f = -c_d0*cos(alpha)+(1-eta*RD^2)*c_n_alpha*sin(alpha_C-alpha_0L)^2*f2prime_c^(1+theta_c);
if theta_c > 1
    coef = 3*(1+RD^(1/4)*(~upstroke)*(theta_c_db^3>2));
    cc_f = cc_f-E1*min([1,theta_c^coef-1]);             
end

% Total: circulatory unsteady + vortex
c_c = cc_f+cc_v;

end