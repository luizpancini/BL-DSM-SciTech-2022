function [params,ps] = override_BL_params(p,params,model)

switch model
        case "BL"
            % Mach-dependent parameters
            ps.alpha_0L =       p(1);
            ps.alpha_ds0 =      p(2);
            ps.alpha_ss =       p(3);
            ps.alpha1_0n =      p(4);
            ps.alpha1_0m =      p(5);
            ps.alpha1_0c =      p(6);
            ps.alpha2_0n =      p(7);
            ps.alpha2_0m =      p(8);
            ps.alpha2_0c =      p(9);
            ps.beta_S1n_u =     p(10);
            ps.beta_S1m_u =     p(11);
            ps.beta_S1c_u =     p(12);
            ps.beta_S1n_d =     p(13);
            ps.beta_S1m_d =     p(14);
            ps.beta_S1c_d =     p(15);
            ps.beta_S2n_u =     p(16);
            ps.beta_S2m_u =     p(17);
            ps.beta_S2c_u =     p(18);
            ps.beta_S2n_d =     p(19);
            ps.beta_S2m_d =     p(20);
            ps.beta_S2c_d =     p(21);
            ps.beta_S3n_u =     p(22);
            ps.beta_S3m_u =     p(23);
            ps.beta_S3c_u =     p(24);
            ps.beta_S3n_d =     p(25);
            ps.beta_S3m_d =     p(26);
            ps.beta_S3c_d =     p(27);
            ps.gamma_v =        p(28);
            ps.delta_alpha_0 =  p(29);
            ps.delta_alpha_1 =  p(30);
            ps.delta_alpha_u =  p(31);
            ps.eta =            p(32);
            ps.kappa_0 =        p(33);
            ps.kappa_1 =        p(34);
            ps.kappa_2 =        p(35);
            ps.kappa_3 =        p(36);
            ps.lambda_1 =       p(37);
            ps.lambda_2 =       p(38);
            ps.nu_1 =           p(39);
            ps.nu_2 =           p(40);
            ps.nu_3 =           p(41);
            ps.nu_4 =           p(42);
            ps.chi_v =          p(43);
            ps.c_d0 =           p(44);
            ps.c_m0 =           p(45);
            ps.c_n_alpha =      p(46);
            ps.d_cc =           p(47);
            ps.d_cm =           p(48);
            ps.E1 =             p(49);
            ps.f0_n =           p(50);
            ps.f0_m =           p(51);
            ps.f0_c =           p(52);
            ps.fb1_n =          p(53);
            ps.fb1_m =          p(54);
            ps.fb1_c =          p(55);
            ps.fb2_n =          p(56);
            ps.fb2_m =          p(57);
            ps.fb2_c =          p(58);
            ps.g_v =            p(59);
            ps.K0 =             p(60);
            ps.K1 =             p(61);
            ps.K2 =             p(62);
            ps.r0 =             p(63);
            ps.S1 =             p(64);
            ps.S1_c =           p(65);
            ps.S2 =             p(66);
            ps.S3 =             p(67);
            ps.S3_c =           p(68);
            ps.Ta =             p(69);
            ps.Tf =             p(70);
            ps.Tv =             p(71);
            ps.Vm =             p(72);
            ps.Vn1 =            p(73);
            ps.Vn2 =            p(74);
            ps.z_cc =           p(75);
            ps.z_cm =           p(76);
            % Time delay constants adjustment for dimensional time
            ps.Ta = ps.Ta*params.b/params.U;
            ps.Tf = ps.Tf*params.b/params.U;
            ps.Tv = ps.Tv*params.b/params.U;
            % Aerodynamic center
            ps.x_ac = 0.25-ps.K0;
            % Copy p struct to the params struct
            for fn = fieldnames(ps)'
                params.(fn{1}) = ps.(fn{1});
            end
            % Reset time delay constants to non-dimensional time for output
            ps.Ta = ps.Ta*params.U/params.b;
            ps.Tf = ps.Tf*params.U/params.b;
            ps.Tv = ps.Tv*params.U/params.b;
end

end