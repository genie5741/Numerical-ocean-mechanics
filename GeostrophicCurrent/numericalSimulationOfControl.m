clc;clear;

% 문제 설정
dt = 10;
dx = 100;
g = 9.8;
h = 10;
c = sqrt(g*h);

% 계수 설정
eta0 = 1;
f = 1e-4;
l = sqrt(g*h)/f;
ef = 0.05;
pint = 50;

% 격자 설정
x = -400000:dx:400000;

% 초기 해면 고도 설정
eta = zeros(10000,length(x));
eta(1,:) = -eta0*sign(x);
eta(2,:) = eta(1,:);

% 잠재 와도 계산
xip = eta0/h*sign(x);

% 수치 해석
wb = waitbar(0, 'Please wait.');
for n=2:10000
    
    % 운동 방정식 해석
    for k=2:size(eta,2)-1
        eta(n+1,k) = 2*eta(n,k)-eta(n-1,k)+...
            (dt)^2*(g*h*(eta(n,k+1)-2*eta(n,k)...
            +eta(n,k-1))/(dx)^2-h*(f^2)...
            *(xip(k)+eta(n,k)/h));
    end
    
    % 경계 조건
    eta(n+1,1) = eta(n,1)+c*dt/dx*(eta(n,2)-eta(n,1));
    eta(n+1,end) = eta(n,end)...
        -c*dt/dx*(eta(n,end)-eta(n,end-1));
    
    % 평활화
    etaf = eta(n+1,:);
    for k=2:size(eta,2)-1
        eta(n+1,k) = (1-ef)*etaf(k)+...
            0.5*ef*(etaf(k-1)+etaf(k+1));
    end
    
    waitbar(n/10000,wb)
end

close(wb);

% 가시화
etar = eta0*(-sign(x)+sign(x).*exp(-x.*sign(x)/1));
for n=1:10:size(eta,1)
    plot(x, eta(n,:), 'linewidth', 2)
    hold on
    plot(x, etar, 'r--', 'linewidth', 2)
    hold off
    ylim([-1.5 1.5])
    title(['t=' num2str((n-1)*dt*pint,'%4.0f')]);
    drawnow
end
    