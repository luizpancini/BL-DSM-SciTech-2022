function [alpha,alpha_tqc,q,qR,R] = BL_kinematics(t,U,b,ah,k,a_0,a_1,r0)

% Pitch angle and its rate
alpha = a_0+a_1*sin(k*U/b*t); sa = sin(alpha); ca = cos(alpha);
alphadot = a_1*k*U/b*cos(k*U/b*t);
% Angle of attack at 3/4-chord
alpha_tqc = atan((U*sa+b*(1/2-ah)*alphadot)/(U*ca));
% Nondimensional pitch rate 
q = 2*alphadot*b/U;
% Nondimensional reduced pitch rate 
r = q/2;
% Unsigned ratio of reduced pitch rate to critical pitch rate 
qR = abs(r)/r0; 
% Unsigned capped reduced pitch rate ratio 
R = min([1, qR]);

end