clc;clear;

% 문제 설정
g = 9.8;
R = 6400000;
omega = 2*pi/(24*60*60);
eta = peaks(50)/100;

% 공간 격자 설정
x = linspace(129.5, 130.5, 50);
y = linspace(36, 57, 50);
[x, y] = meshgrid(x, y);
x = x';
y = y';

% 전향력 계수 계산
f = 2*omega*sind(y);

% 해면 고도 가시화
pcolor(x, y, eta)
shading interp
set(gcf, 'Renderer', 'Zbuffer')
colorbar

u = zeros(size(eta));
v = zeros(size(eta));

% 수치적 방법의 지형류 계산
for i=2:size(x, 2)-1
    for j=2:size(y,1)-1

        dx = (x(i+1,j)-x(i-1,j))*(R*cosd(y(i,j))*pi/180);
        dy = (y(i,j+1)-y(i,j-1))*(R*pi/180);
        u(i,j) = -g/f(i,j)*(eta(i,j+1)-eta(i,j-1))/dy;
        v(i,j) = g/f(i,j)*(eta(i+1,j)-eta(i-1,j))/dx;
    end
end

% 지형류 가시화
hold on
quiver(x, y, u, v, 2, 'k')