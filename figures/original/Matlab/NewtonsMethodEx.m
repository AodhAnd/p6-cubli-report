clear all
close all
clc

syms x1 x2;

f = -(cos(x1)^2 + cos(x2^2)^2)^2;

hes = hessian(f, [ x1, x2 ])

%first derivative of function to be minimized
dfX1 = diff(f,x1);
dfX2 = diff(f,x2);

%2nd derivative of function to be minimized
ddfX1X1 = diff(dfX1,x1);
ddfX1X2 = diff(dfX1,x2);
ddfX2X1 = diff(dfX2,x1);
ddfX2X2 = diff(dfX2,x2);

x = -1.5 : .2 : 1.5;
y = -1.5 : .2 : 1.5;

[X,Y] = meshgrid(-1.5:.1:1.5);
f = -(cos(X).^2 + cos(Y.^2).^2).^2;

figure;%('position', [ 2 32 798 409 ]);
mesh(X,Y,f, 'facecolor','none')
drawnow;
view(6.5000, 16.0000);

hold on;

%normal full view
%axis([ -1.5 1.5 -1.5 1.5 -4 0 ])

%one side cut open view
axis([ -1.5 1.5 0 1.5 -4 0 ])

%zoom on convergence view
%axis([  -.5 .5 -0.3 0 -4 -3.612 ])

initX = -.5;
initY = 1;
%d = .1;
i = 1;
while i <= 30
    if exist('a','var')
        initX = a;
        initY = b;
        initF  = -(cos( initX)^2 + cos( initY^2)^2)^2;
    else
        initF  = -(cos( initX)^2 + cos( initY^2)^2)^2;
        plot3(initX, initY, initF, 'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 4)
        drawnow;
    end

    %inserting current/initial point in gradient (1st derivatives)
    dfXX= subs(real(dfX1),x1,initX);
    dfXX= subs(real(dfXX),x2,initY);
    dfYY= subs(real(dfX2),x1,initX);
    dfYY= subs(real(dfYY),x2,initY);
    
    g = [ double(dfXX)
          double(dfYY) ];
    
    %inserting current/initial point in Hessian (2nd derivatives)
%     ddfXX = subs(real(ddfX1X1),x1,initX);
%     ddfXX = subs(real(ddfXX  ),x2,initX);
%     ddfXY = subs(real(ddfX1X2),x1,initX);
%     ddfXY = subs(real(ddfXY  ),x2,initX);
%     ddfYX = subs(real(ddfX2X1),x1,initX);
%     ddfYX = subs(real(ddfYX  ),x2,initX);
%     ddfYY = subs(real(ddfX2X2),x1,initX);
%     ddfYY = subs(real(ddfYY  ),x2,initX);
    
    ddfXX = subs(real(hes(1,1)),x1,initX);
    ddfXX = subs(real(ddfXX  ),x2,initX);
    ddfXY = subs(real(hes(1,2)),x1,initX);
    ddfXY = subs(real(ddfXY  ),x2,initX);
    ddfYX = subs(real(hes(2,1)),x1,initX);
    ddfYX = subs(real(ddfYX  ),x2,initX);
    ddfYY = subs(real(hes(2,2)),x1,initX);
    ddfYY = subs(real(ddfYY  ),x2,initX);
    
    H = [ double(ddfXX) double(ddfXY) 
          double(ddfYX) double(ddfYY) ]
      
    detH = H(1,1)*H(2,2)-H(2,1)*H(1,2);
    
    invH = (1/detH)*[  H(2,2) -H(1,2)
                      -H(2,1)  H(1,1) ]
    
    %calculating next point using gradient and Hessian (Newton's method)
    delta = [ (invH(1,1)*g(1) + invH(1,2)*g(2))
              (invH(2,1)*g(1) + invH(2,2)*g(2)) ]
          
    a = initX -delta(1)*.2;
    b = initY -delta(2)*.2;
    c = -(cos(a)^2 + cos(b^2)^2)^2;

        plot3(a, b, c, 'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 4)

        v1 = [initX initY initF];
        v2 = [a b c];
        %scale = (v1-v2)*100
        %v11 = v1+scale
        %v22 = v2-scale
        v = [v1; v2];
        plot3(v(:,1),v(:,2),v(:,3),'b', 'LineWidth', 1.4)

        drawnow;
        %d = d+0.1*d;

    i = i+1;
end

title('Minimization using Newton''s Method');
xlabel('X1');
ylabel('X2');
zlabel('f(x)    ', 'Rotation', 0);
