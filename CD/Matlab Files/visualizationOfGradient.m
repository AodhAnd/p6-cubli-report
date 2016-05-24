clear all
close all
clc

syms x1 x2;

f = -(cos(x1)^2 + cos(x2^2)^2)^2;

g = [ diff(f,x1)
      diff(f,x2) ];
  
H = [ diff(diff(f,x1),x1)
      diff(diff(f,x2),x2) ];

xx = solve(real(f),x1);
yy = solve(real(f),x2);

x = -1.5 : .2 : 1.5;
y = -1.5 : .2 : 1.5;

[X,Y] = meshgrid(-1.5:.1:1.5);
f1 = -(cos(X).^2 + cos(Y.^2).^2).^2

g1 = subs(real(g(1)),x1,x)'
g2 = subs(real(g(2)),x1,y)'
g1 = subs(real(g1),x2,x)'
g2 = subs(real(g2),x2,y)'

% h1 = subs(real(H(1)),x1,x)'
% h2 = subs(real(H(2)),x1,y)'
% h1 = subs(real(h1),x2,x)'
% h2 = subs(real(h2),x2,y)'

mesh(X,Y,f1)
title('Visualization of Gradient of Arbitrary Function');
xlabel('X1');
ylabel('X2');
zlabel('f(x)    ', 'Rotation', 0);
hold on;
g0 = zeros(size(g2))
quiver3(x,y,g0-6,g1,g2,g0)
axis([ -1.5 1.5 -1.5 1.5 -6 0 ])