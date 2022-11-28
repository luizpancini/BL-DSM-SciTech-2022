function [Tf_n,Tf_m,Tf_c,Ta_theta] = BL_time_constants(theta,R,RD,Ta,Tf,lambda_1,lambda_2)

%% Stall supression time delay 
Ta_theta = Ta*(1/4+lambda_1*RD^(lambda_2)*(1-R^(1/4))*exp(-(abs(theta)-1)^2/0.01));

%% Separation points time delays         
Tf_n = Tf;   
Tf_m = Tf; 
Tf_c = Tf;  

end