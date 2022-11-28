function [display_progress,c5,c45,dt,dt_lim,i,tc,ti,tf,RKF_it_max,RKFtol,tp,xp,yp,xdotp,x_i,xdot_i] = setup_RKF45(tspan,x0,y0,RKF_options)

% Unpack RKF45 options
dt_lim = RKF_options.dt_lim;
RKFtol = RKF_options.RKFtol;
RKF_it_max = RKF_options.RKF_it_max;
display_progress = RKF_options.display_progress;

% RKF45 integration variables
c4 = [25/216 0 1408/2565 2197/4104 -1/5 0]';        % Coefficients for 4th order approximation
c5 = [16/135 0 6656/12825 28561/56430 -9/50 2/55]'; % Coefficients for 5th order approximation
c45 = c5-c4;

% Time variables
ti = tspan(1);          % Initial time
tf = tspan(end);        % Final time
tc = ti;                % Current time
i = 1;                  % Initialize time step counter
dt = dt_lim;            % Initialize time step with maximum allowable

% Pre-allocate
N = length(x0);                         % Number of states
p_ratio = 1+sqrt(tf-ti);                % Pre-allocation ratio relative to constant time step - my simple formula
s0 = round(p_ratio*(tf-ti)/dt_lim);     % Initial size of the arrays
tp = zeros(s0,1);                       % Storage time array
xp = zeros(N,s0);                       % Storage states array
yp = zeros(length(y0),s0);              % Storage outputs array
xdotp = zeros(N,s0);                    % Storage states' rates array

% Set initial conditions on current states and states' rates arrays
x_i = x0; 
xdot_i = xdotp(:,1);

% Initialize storage arrays
tp(1) = ti;  
xp(:,1) = x0; 
yp(:,1) = y0;

end