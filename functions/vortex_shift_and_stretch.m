nu = 2;
ratio = 1.6;
x = 0:1e-3:2;
Vx = sin(pi/2*x).^nu;

%%
% x2 = 0:1e-3:2*ratio;
% Vx = sin(pi/2*x).^nu;
% Vx2 = sin(pi/2*(x2+ratio-1)/ratio).^nu;
% figure;plot(x,Vx,x2,Vx2);grid
% 
% %%
% N = length(x); half = round(N/2);
% Vx1 = sin(pi/2*x(1:half)).^(2*nu);
% Vx2 = sin(pi/2*x(half+1:end)).^(nu/2);
% Vx_new = [Vx1,Vx2];
% figure;plot(x,Vx,x,Vx_new);grid

%%
x_brk = 1/ratio; fac = 1/(2-1/ratio);
[~,i_brk] = min(abs(x-x_brk));
Vx1 = sin(pi/2*(x(1:i_brk)*ratio)).^(nu/ratio);
Vx2 = sin(pi/2*(1+fac*(x(i_brk+1:end)-x_brk))).^(ratio*nu);
Vx_new = [Vx1,Vx2];
figure;plot(x,Vx,x,Vx_new);grid
