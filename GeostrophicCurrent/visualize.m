clc;clear;

% 계수 설정
eta0 = -0.01;
R = 300;
f = 0.01;
g = 9.81;

% 격자 생성
x = -500:50:500;
y = -500:50:500;
[x, y] = meshgrid(x, y);

% 해면 고도 설정
eta = eta0*exp(-(x.^2+y.^2)/R^2);

% 유속 계산
v = (g*eta0)/f*(-2*x/R^2).*exp(-(x.^2+y.^2)/R^2);
u = -(g*eta0)/f*(-2*y/R^2).*exp(-(x.^2+y.^2)/R^2);

% 가시화
subplot(2, 1, 1)
surf(x, y, eta)
view([-45 80])
caxis([-0.01 0.01])
title('\eta, sea surface height')

subplot(2, 1, 2)
z0 = zeros(size(x));
quiver3(x, y, z0, u, v, z0)
view([-45 80])
caxis([-0.01 0.01])
axis([-500 500 -500 500 0 0.01])
title('u and v, velocities')
