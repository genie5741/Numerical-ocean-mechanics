clc;clear;

% 계수 설정
tauy = 0.5;
rho = 1025;
f = 1e-4;
Az = 1e-2;
z = 0:-2:-100;

% 에크만 흐름 계산
u = tauy/(rho*sqrt(Az*f))*...
    exp(sqrt(f/(2*Az))*z).*cos(sqrt(f/(2*Az))*z+pi/4);
v = tauy/(rho*sqrt(Az*f))*...
    exp(sqrt(f/(2*Az))*z).*sin(sqrt(f/(2*Az))*z+pi/4);

% 가시화
compass(0, tauy, 'g')
hold on
compass(u, v)

cmap = colormap(cool);
figure
for i=1:length(z)
    quiver3(0, 0, z(i), u(i), v(i), 0, ...
        'color', cmap(i,:), 'autoscale', 'off', 'linewidth', 2)
    hold on
end

hold off
view([-100 60])