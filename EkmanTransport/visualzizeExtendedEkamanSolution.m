% 유한한 수심에서 압력 경사가 있을 경우의 확장된 에크만 해

clc;clear;

% 계수 설정
Az = 2.5e-3;
taux = 0;
tauy = 0.2;
ugx = 0;
ugy = 0.4;
f = 6e-5;
rho = 1025;

D = sqrt(2*Az/f);
h = 200;

z = 0:-1:-h;

tau = taux+tauy*i;
ug = ugx+ugy*i;

% 확장된 에크만 흐름 계산
j = sqrt(f*i/(Az));
ue = tau/(rho*Az*j)*sinh(j*(h+z))/cosh(j*h)...
    -ug*cosh(j*z)/cosh(j*h);

V = ug+ue;
u = real(V);
v=imag(V);

% 가시화
cmap = cool(length(z));
figure
hold on
for i=[1:30 35:10:length(z)-30 ...
        length(z)-30:2:length(z)]
    quiver3(0, 0, z(i), u(i), v(i), 0, ...
        'color', cmap(i,:), 'autoscale', 'off', ...
        'linewidth', 2)
end

view(-50, 70)
hold off
grid on


