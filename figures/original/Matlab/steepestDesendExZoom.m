clear all
close all
clc

syms x1 x2;

f = -(cos(x1)^2 + cos(x2^2)^2)^2;

dfX1 = diff(f,x1);
dfX2 = diff(f,x2);

x = -1.5 : .2 : 1.5;
y = -1.5 : .2 : 1.5;

[X,Y] = meshgrid(-1.5:.1:1.5);
f = -(cos(X).^2 + cos(Y.^2).^2).^2;

figure;%('position', [ 2 32 798 409 ]);
mesh(X,Y,f, 'facecolor','none')
drawnow;
view(18.5, 28);         %<--rotate graph as wanted, then run
                        %   get(gca, 'View')
hold on;                %   coppy the two values (azimuth and elevation)
                        %   insert values in view(az, el)
%normal full view:
%axis([ -1.5 1.5 -1.5 1.5 -4 0 ])

%one side cut open view:
%axis([ -1.5 1.5 0 1.5 -4 0 ])

%zoom on convergence view:
axis([  -.5 .5 0 0.3 -4 -3 ])

initX = -1.4;
initY = 1.2;
d = .1;
i = 1;
while i <= 100
    if exist('a','var')
        if c <= initF
            initX = a;
            initY = b;
            initF  = -(cos( initX)^2 + cos( initY^2)^2)^2;
        end
    else
        initF  = -(cos( initX)^2 + cos( initY^2)^2)^2;
        plot3(initX, initY, initF, 'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 4)
    end

    dfXX= subs(real(dfX1),x1,initX);
    dfXX= subs(real(dfXX),x2,initY);
    dfYY= subs(real(dfX2),x1,initX);
    dfYY= subs(real(dfYY),x2,initY);

    a = double(initX -dfXX*d);
    b = double(initY -dfYY*d);
    c = double(-(cos(a)^2 + cos(b^2)^2)^2);

    if c <= initF
        plot3(a, b, c, 'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 4)

        v1 = [initX initY initF];
        v2 = [a b c];
        %scale = (v1-v2)*100
        %v11 = v1+scale
        %v22 = v2-scale
        v = [v1; v2];
        plot3(v(:,1),v(:,2),v(:,3),'b', 'LineWidth', 1.4)

        drawnow;
        d = d+0.1*d
    else
        plot3(a, b, c, 'or', 'MarkerFaceColor', 'r', 'MarkerSize', 4)
        v1 = [initX initY initF];
        v2 = [a b c];
        v = [v1; v2];
        plot3(v(:,1),v(:,2),v(:,3),'r', 'LineWidth', 1.4)
        d = d-0.4*d
    end

    i = i+1;
end

title('Zoom on Convergence of Steepest Descend');
%title('Minimization using Steepest Descend');
xlabel('X1');
ylabel('X2');
zlabel('f(x)    ', 'Rotation', 0);
