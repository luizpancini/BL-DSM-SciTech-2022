function varargout = unpack_outputs(outputs,model)

switch model
    case {"BL"}
        t = outputs.t;
        alpha = outputs.alpha;
        q = outputs.q; 
        qR = outputs.qR;  
        R = outputs.R;  
        alpha_cr = outputs.alpha_cr; 
        theta = outputs.theta;   
        theta_min = outputs.theta_min;
        theta_max = outputs.theta_max;
        S = outputs.S;
        alpha1_n = outputs.alpha1_n;
        alpha1_m = outputs.alpha1_m;
        alpha1_c = outputs.alpha1_c;
        alpha2_n = outputs.alpha2_n;
        alpha2_m = outputs.alpha2_m;
        alpha2_c = outputs.alpha2_c;
        dalpha_n = outputs.dalpha_n;
        dalpha_m = outputs.dalpha_m;
        dalpha_c = outputs.dalpha_c;
        f_n = outputs.f_n;
        f_m = outputs.f_m;
        f_c = outputs.f_c;
        fprime_n = outputs.fprime_n;
        fprime_m = outputs.fprime_m;
        fprime_c = outputs.fprime_c;
        Tf_n = outputs.Tf_n;
        Tf_m = outputs.Tf_m;
        Tf_c = outputs.Tf_c;
        Ta_theta = outputs.Ta_theta;
        alpha_C = outputs.alpha_C;
        c_n = outputs.c_n;
        c_nC = outputs.c_nC;
        c_nI = outputs.c_nI;
        c_nf = outputs.c_nf;
        c_nv = outputs.c_nv;
        c_m = outputs.c_m;
        c_mC = outputs.c_mC;
        c_mI = outputs.c_mI;
        c_mf = outputs.c_mf;
        c_mv = outputs.c_mv;
        dCP = outputs.dCP;
        c_c = outputs.c_c;
        c_l = outputs.c_l;
        c_d = outputs.c_d;
        alpha_lag = outputs.alpha_lag;
        f2prime_n = outputs.f2prime_n;
        f2prime_m = outputs.f2prime_m;
        f2prime_c = outputs.f2prime_c;
        RD = outputs.RD;
        RD_theta = outputs.RD_theta;
        RD_tv0 = outputs.RD_tv0;
        f_diff_tv0 = outputs.f_diff_tv0;
        TvL_tv0 = outputs.TvL_tv0;
        f_diff_tv0_2 = outputs.f_diff_tv0_2;
        varargout = {t,alpha,q,qR,R,alpha_cr,theta,theta_min,theta_max,S,alpha1_n,alpha1_m,alpha1_c,alpha2_n,alpha2_m,alpha2_c,dalpha_n,dalpha_m,dalpha_c,f_n,f_m,f_c,fprime_n,fprime_m,fprime_c,Tf_n,Tf_m,Tf_c,Ta_theta,alpha_C,c_n,c_nC,c_nI,c_nf,c_nv,c_m,c_mC,c_mI,c_mf,c_mv,dCP,c_c,c_l,c_d,alpha_lag,f2prime_n,f2prime_m,f2prime_c,RD,RD_theta,RD_tv0,f_diff_tv0,TvL_tv0,f_diff_tv0_2};
end

end