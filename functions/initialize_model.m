function [data,params,x0,y0,RKF_options] = initialize_model(case_now,INPUTS,varargin)

%% Handle inputs
% Default values
n_discard = 2;              % Number of cycles to discard due to initial transients of the model
dt_lim = 1e-3;              % Default maximum time step (notice that the NMRS errors are slightly dependent on the time step)
initialize = true;          % Option to initialize states by running one cycle
display_progress = false;   % Option to display algorithm progress
% Input values
if ~isempty(varargin)
    n_discard = varargin{1};
    if length(varargin) > 1
        dt_lim = varargin{2};
    end
    if length(varargin) > 2
        initialize = varargin{3};
    end
end

%% Read reference data and simulation parameters from input
[data,params] = read_data(INPUTS,case_now,n_discard);                      

%% Initialize to get consistent set of initial states 
% Set RKK45 ODE solver options
RKF_options.dt_lim = dt_lim;                        % Maximum timestep
RKF_options.display_progress = display_progress;    % Option to display progress
RKF_options.RKFtol = 1e-10;                         % Default absolute tolerance for difference between 4th and 5th order RKF approximations
RKF_options.RKF_it_max = 10;                        % Default maximum number of iterations for RKF approximations
% Solve ODEs for initial time
switch INPUTS.model
    case "BL"
        % Set model's number of states
        params.N = 14;    
        % Initialize states and outputs arrays
        x0 = zeros(params.N,1); x0(10:12) = 1; y0 = nan(45,1);
        % Get initial states
        if initialize
            [~,~,x,y] = BL_RKF45([0; params.t_cycle],x0,y0,params,RKF_options);
            x0 = x(:,end); y0 = y(:,end);
        end
end

end