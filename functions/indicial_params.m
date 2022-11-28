function params = indicial_params(params,model)

% Unpack
M = params.M;
b = params.b;
a_inf = params.a_inf;
beta = params.beta;
airfoil = params.airfoil;

%% Indicial parameters according to each model
switch model
    case {"BL"}
        %% Circulatory indicial parameters
        % Nominal values
        params.A1 = 0.3;
        params.A2 = 0.7;
        params.A3 = 1.5;
        params.A4 = -0.5;
        params.b1 = 0.14;
        params.b2 = 0.53;
        params.b3 = 0.25;
        params.b4 = 0.1;
        params.b5 = 5.0;
        % Adjustments for each airfoil
        switch airfoil
            case 'NACA0012'
                params.b1 = params.b1*1.5;
                params.b2 = params.b2*1.0;
            case 'AMES-01'
                params.b1 = params.b1*3.0;
                params.b2 = params.b2*0.6;
            case 'NLR-7301'
                params.b1 = params.b1*2.5;
                params.b2 = params.b2*0.8;
            case 'S809'
                params.b1 = params.b1*1.0;
                params.b2 = params.b2*1.0;
            case 'Vertol-23010'
                params.b1 = params.b1*1.0;
                params.b2 = params.b2*1.0;    
        end
        %% Impulsive indicial parameters
        % Nominal values
        params.K_a = 1/(1-M+pi*beta*M^2*(params.A1*params.b1+params.A2*params.b2));
        params.K_q = 1/(1-M+2*pi*beta*M^2*(params.A1*params.b1+params.A2*params.b2));
        params.K_M = 1/(1-M+pi/beta*M^2*(params.A1*params.b1+params.A2*params.b2));
        params.K_aM = (params.A3*params.b4+params.A4*params.b3)/(params.b3*params.b4*(1-M));
        params.K_qM = 7/(15*(1-M)+3*pi*beta*M^2*params.b5);
        params.K_MM = params.K_aM;
        params.T_I = 2*b/a_inf;
        % Leishman and Nguyen (1989) say they have reduced the K constants by 25% to
        % match experimental data (see Conclusions of their paper). Here we apply
        % that only for M > 0.07, and only for c_n related impulsive parameters.
        if M > 0.07
            fac = 0.75;
        else
            fac = 1-0.25*(M/0.07)^2;
        end
        params.K_a = params.K_a*fac;
        params.K_q = params.K_q*fac;
        params.K_M = params.K_M*fac;
        % Adjustments for each airfoil
        switch airfoil
            case 'NACA0012'
                params.K_aM = params.K_aM*1.0;
                params.K_qM = params.K_qM*1.0;
                params.K_MM = params.K_MM*1.0;
            case 'AMES-01'
                params.K_aM = params.K_aM*1.25;
                params.K_qM = params.K_qM*1.25;
                params.K_MM = params.K_MM*1.25;
            case 'NLR-7301'
                params.K_aM = params.K_aM*1.0;
                params.K_qM = params.K_qM*1.0;
                params.K_MM = params.K_MM*1.0;
            case 'S809'
                params.K_aM = params.K_aM*2.0;
                params.K_qM = params.K_qM*2.0;
                params.K_MM = params.K_MM*2.0;
            case 'Vertol-23010'
                params.K_aM = params.K_aM*1.15;
                params.K_qM = params.K_qM*1.15;
                params.K_MM = params.K_MM*1.15;    
        end
end

end