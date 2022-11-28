function xdot = BL_state_space(x,xdot,alpha,alpha_tqc,q,R,A,Tf_n,Tf_m,Tf_c,Ta,fprime_n,fprime_m,fprime_c,Ta_theta)

% Potential flow states 
xdot(1) = A(1)*x(1)+alpha_tqc; 
xdot(2) = A(2)*x(2)+alpha_tqc; 
xdot(3) = A(3)*x(3)+alpha;
xdot(4) = A(4)*x(4)+q;
xdot(5) = A(5)*x(5)+alpha; 
xdot(6) = A(6)*x(6)+alpha; 
xdot(7) = A(7)*x(7)+q; 
xdot(8) = A(8)*x(8)+q; 

% Nonlinear states
xdot(9)  = (alpha-x(9))/Ta;             % Delayed AoA 
xdot(10) = (fprime_n-x(10))/Tf_n;       % Delayed separation point - normal force
xdot(11) = (fprime_m-x(11))/Tf_m;       % Delayed separation point - pitch moment
xdot(12) = (fprime_c-x(12))/Tf_c;       % Delayed separation point - chordwise force
xdot(13) = (R-x(13))/(Ta*3);            % Delayed capped reduced pitch rate
xdot(14) = (R-x(14))/(Ta_theta);        % Delayed capped reduced pitch rate for the delayed AoA 

end