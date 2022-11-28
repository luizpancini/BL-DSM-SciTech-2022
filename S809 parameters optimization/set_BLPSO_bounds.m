function [D,LB,UB,LBmat,UBmat,Vmax,Vmaxmat] = set_BLPSO_bounds(N_p,varargin)

% Handle input
if ~isempty(varargin)
    airfoil = varargin{1};
end

switch airfoil
    case 'S809'
%         FOR M = 0.075
        B = [ pi/180*-0.6,  pi/180*-0.4     % alpha_0L
              pi/180*21.5,  pi/180*23.0     % alpha_ds0
              pi/180*18.8,  pi/180*19.3     % alpha_ss
              pi/180*11.2,  pi/180*11.3     % alpha1_0n
               pi/180*8.0,  pi/180*9.0      % alpha1_0m
              pi/180*16.0,  pi/180*17.5     % alpha1_0c
              pi/180*19.0,  pi/180*20.0     % alpha2_0n
              pi/180*19.0,  pi/180*20.0     % alpha2_0m
              pi/180*19.0,  pi/180*22.0     % alpha2_0c
                     -0.4,          1.0     % beta_S1n_u
                     -0.8,          1.0     % beta_S1m_u
                     -0.8,          1.0     % beta_S1c_u
                      0.0,          3.0     % beta_S1n_d
                     -0.8,          3.0     % beta_S1m_d
                      0.0,          4.0     % beta_S1c_d
                     -0.9,          4.0     % beta_S2n_u
                     -0.9,          4.0     % beta_S2m_u
                     -0.9,          4.0     % beta_S2c_u
                     -0.9,          4.0     % beta_S2n_d
                     -0.9,          4.0     % beta_S2m_d
                     -0.9,          4.0     % beta_S2c_d
                     -0.8,          0.0     % beta_S3n_u
                     -0.8,          3.0     % beta_S3m_u
                     -0.8,          1.0     % beta_S3c_u
                      0.0,          3.0     % beta_S3n_d
                      0.0,          3.0     % beta_S3m_d
                      0.0,          4.0     % beta_S3c_d
                      3.0,          9.0     % gamma_v
               pi/180*0.0,   pi/180*2.0     % delta_alpha_0
               pi/180*0.0,   pi/180*2.0     % delta_alpha_1
               pi/180*3.0,   pi/180*7.0     % delta_alpha_u
                      0.0,         0.05     % eta
                     0.25,         0.40     % kappa_0
                      0.0,          0.5     % kappa_1
                     0.00,         0.25     % kappa_2
                      0.0,          0.5     % kappa_3 
                        0,          100     % lambda_1
                      1/6,            1     % lambda_2
                      0.1,          1.0     % nu_1
                      0.1,          0.4     % nu_2
                      0.1,         0.25     % nu_3
                      2.0,          3.0     % nu_4
                      1.0,          1.8     % chi_v
                    0.000,        0.000     % c_d0
                   -0.035,       -0.030     % c_m0
                2*pi*1.06,    2*pi*1.09     % c_n_alpha
              pi/180*-3.0,   pi/180*3.0     % d_cc
              pi/180*-3.0,   pi/180*3.0     % d_cm
                     0.07,         0.10     % E1
                    0.043,        0.050     % f0_n
                    0.003,        0.005     % f0_m
                    0.000,         0.01     % f0_c
                     0.34,         0.42     % fb1_n
                     0.35,         0.47     % fb1_m
                     0.50,         0.60     % fb1_c
                    0.005,        0.015     % fb2_n
                    0.020,        0.027     % fb2_m
                    0.000,        0.010     % fb2_c
                     -1.0,          0.2     % g_v
                   -0.032,       -0.028     % K0
                    -0.27,        -0.20     % K1
                     0.20,         0.24     % K2
                    0.012,        0.022     % r0
               pi/180*3.5,   pi/180*5.0     % S1
               pi/180*9.0,  pi/180*12.0     % S1_c
               pi/180*3.0,   pi/180*4.5     % S2
                      0.8,          0.9     % S3
                     0.25,          1.0     % S3_c       
                      0.5,          2.0     % Ta
                      2.0,          4.0     % Tf
                      3.5,          4.0     % Tv
                     0.20,         0.25     % Vm
                      1.0,          2.0     % Vn1
                      0.5,          2.0     % Vn2
                     -3.5,          3.0     % z_cc
                     -1.0,          3.0     % z_cm
                                       ];
% % FOR M = 0.15
%         B = [ pi/180*-1.0,  pi/180*-0.7     % alpha_0L
%               pi/180*21.0,  pi/180*24.0     % alpha_ds0 
%               pi/180*19.0,  pi/180*22.0     % alpha_ss 
%               pi/180*11.2,  pi/180*11.5     % alpha1_0n
%                pi/180*8.0,  pi/180*10.0     % alpha1_0m
%               pi/180*16.0,  pi/180*19.0     % alpha1_0c 
%               pi/180*19.5,  pi/180*22.3     % alpha2_0n 
%               pi/180*19.5,  pi/180*22.3     % alpha2_0m 
%               pi/180*21.5,  pi/180*24.0     % alpha2_0c
%                      -0.8,          4.0     % beta_S1n_u 
%                      -0.8,          4.0     % beta_S1m_u 
%                      -0.8,          4.0     % beta_S1c_u 
%                      -0.8,          4.0     % beta_S1n_d 
%                      -0.8,          4.0     % beta_S1m_d 
%                      -0.8,          4.0     % beta_S1c_d 
%                      -0.8,          4.0     % beta_S2n_u 
%                      -0.8,          4.0     % beta_S2m_u 
%                      -0.8,          4.0     % beta_S2c_u 
%                      -0.8,          4.0     % beta_S2n_d 
%                      -0.8,          4.0     % beta_S2m_d 
%                      -0.8,          4.0     % beta_S2c_d 
%                      -0.8,          4.0     % beta_S3n_u 
%                      -0.8,          4.0     % beta_S3m_u 
%                      -0.8,          4.0     % beta_S3c_u 
%                      -0.8,          4.0     % beta_S3n_d 
%                      -0.8,          4.0     % beta_S3m_d 
%                      -0.8,          5.0     % beta_S3c_d 
%                       3.0,         10.0     % gamma_v 
%                pi/180*0.0,   pi/180*2.0     % delta_alpha_0 
%                pi/180*0.0,   pi/180*2.0     % delta_alpha_1
%                pi/180*3.0,   pi/180*7.0     % delta_alpha_u
%                       0.0,         0.05     % eta
%                       0.30,         0.45    % kappa_0
%                       0.0,          0.5     % kappa_1
%                       0.0,          0.5     % kappa_2
%                       0.0,          0.5     % kappa_3
%                         0,          100     % lambda_1
%                       1/6,            1     % lambda_2
%                       0.1,          1.0     % nu_1
%                       0.2,          0.4     % nu_2 
%                       0.1,          0.4     % nu_3 
%                       2.0,          3.0     % nu_4
%                       1.0,          2.0     % chi_v
%                     0.000,        0.000     % c_d0
%                    -0.038,       -0.030     % c_m0
%                 2*pi*1.10,    2*pi*1.13     % c_n_alpha
%               pi/180*-3.0,   pi/180*3.0     % d_cc 
%               pi/180*-3.0,   pi/180*3.0     % d_cm
%                      0.06,         0.10     % E1
%                     0.040,        0.050     % f0_n 
%                     0.003,        0.005     % f0_m 
%                     0.000,         0.01     % f0_c
%                      0.35,         0.45     % fb1_n 
%                      0.35,         0.50     % fb1_m 
%                      0.50,         0.60     % fb1_c
%                     0.010,        0.015     % fb2_n 
%                     0.020,        0.025     % fb2_m 
%                     0.000,        0.010     % fb2_c
%                      -1.0,          0.0     % g_v
%                    -0.032,       -0.025     % K0
%                     -0.30,        -0.20     % K1
%                      0.18,         0.25     % K2 
%                     0.012,        0.022     % r0
%                pi/180*3.5,   pi/180*5.0     % S1 
%               pi/180*10.0,  pi/180*12.0     % S1_c 
%                pi/180*3.0,   pi/180*5.0     % S2
%                       0.8,          1.0     % S3 
%                       0.2,          1.2     % S3_c 
%                       0.3,          3.0     % Ta 
%                       2.0,          5.0     % Tf
%                       3.0,          4.2     % Tv 
%                      0.18,         0.25     % Vm
%                       0.5,          2.0     % Vn1 
%                       0.5,          2.0     % Vn2
%                      -4.0,          3.0     % z_cc
%                       0.0,          3.5     % z_cm
%                                        ];
end

% Number of optimization variables
D = size(B,1);

% Lower and upper bounds
LB = B(:,1)';
UB = B(:,2)';

% Check inconsistent bounds
if any(LB > UB)
    error('There are inconsistent bounds')
end

% Lower and upper bounds repeated over rows
LBmat = repmat(LB,N_p,1);
UBmat = repmat(UB,N_p,1);

% Maximum velocities (default is a quarter of the domain of the dimension)
Vmax = (UB-LB)/4;
Vmaxmat = repmat(Vmax,N_p,1);

end