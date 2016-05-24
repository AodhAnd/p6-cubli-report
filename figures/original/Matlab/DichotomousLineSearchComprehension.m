clear all
close all
clc

optimalityTest = 0;      %<--if set to 0 then
                         %   it is made for better comprehension of method.
                         %   if set to 1 then
                         %   it is made for testing of performance.
if optimalityTest == 1
    x = -8:.1:5;
    syms xSym

    %function to minimize
    f = x.^2 + 5*x;
    fSym = xSym^2 + 5*xSym;
else
    x = -8:.1:5;
    syms xSym

    %function to minimize
    f = x.^2;
    fSym = xSym^2;
end

%analyticly determine minimum of f for comparison
xTrueMin = double(solve(diff(fSym) == 0, xSym));

%plot of cost function
figure('position', [978 30 623 420])
plot(x,f, 'linewidth', 1.4)
hold on
grid on, grid minor;
xlim([ min(x) max(x)]);

%setting title and axis labels
title('Dichotomous Line Search');
xlabel('X');

if optimalityTest == 1
    ylabel('f(x) = x^2 + 5x');
else
    ylabel('f(x) = x^2');
end

%saving ylim for use in plotting verticle lines
limY = get(gca,'ylim');

%Dichotomous Search
if optimalityTest == 1
    E = .00039;
else
    E = .12;
end
Xmin = min(x)+.5;
Xmax = max(x)-.5;

%plotting the bracket: [Xmin Xmax]   Xmin in red   and   Xmax in blue
%( interval in which the minimum is assumed to be contained )
      
%plotting Xmin
line( [Xmin Xmin], limY, 'linestyle', '-', 'linewidth', 1,...
      'color', '[1 0 0]' );  
%label for Xmin line
text( Xmin+.1, limY(2)-.5*((limY(2)-limY(1))*.12),  ...
      '\leftarrow Xmin', 'FontWeight', 'bold',...
      'FontSize', 10);

%plotting Xmax
line( [Xmax Xmax], limY, 'linestyle', '-', 'linewidth', 1,...
      'color', '[1 0 0]' );  
%label for Xmax line
text( Xmax-1.5, limY(2)-.5*((limY(2)-limY(1))*.12),  ...
      'Xmax \rightarrow', 'FontWeight', 'bold',...
      'FontSize', 10 );
                 

X = min(x);
F = double(subs(fSym,xSym,X));
iterations = 0;

while abs(xTrueMin-X) >= E*10
    iterations = iterations+1;
    clc
    
    mid = (Xmin+Xmax)/2;

    a = mid - E; %<--plotted below as red non-dotted line
    b = mid + E; %<--plotted below as blue non-dotted line
    
    rangea = line( [a a], limY, ...
                   'linestyle', '-',  ...
                   'linewidth', .1,  ...
                   'color', '[1 .2 .2]' );
    rangeb = line( [b b], limY, ...
                   'linestyle', '-',  ...
                   'linewidth', .1,  ...
                   'color', '[0 0.447 0.741]' );
    
    %evaluating cost function in X = a and X = b
    Fa = double(subs(fSym,xSym,a));
    Fb = double(subs(fSym,xSym,b));
    
    %selecting new min as a and keeping old max
    %OR
    %selecting new max as b and keeping old min
    if Fa < Fb

        F = Fb;
        X = a;
        Xmax = b;
        
        %plotting the new maximum range
        if optimalityTest == 0
            rangeMax = line( [Xmax Xmax], limY, ...
                             'linestyle', ':',  ...
                             'linewidth', 1.8,  ...
                             'color', '[0 0.447 0.741]' );
        end
        
    elseif Fb <= Fa
        
        F = Fa;
        X = b;
        Xmin = a;
        
        %plotting the new minimum range
        if optimalityTest == 0
            rangeMin = line( [Xmin Xmin], limY, ...
                             'linestyle', ':',  ...
                             'linewidth', 1.8,  ...
                             'color', '[1 0 0]' );
        end
    end
    
    if exist('Fa','var')
       if Fa < Fb && abs(xTrueMin-X) < E*10
         scatter(a,Fa, 'filled', 'r')       %<--mark the found minimizer
         persitionInterval = abs(xTrueMin-a)%   with red in last iteration.
         drawnow;                           
       elseif Fb < Fa && abs(xTrueMin-X) < E*10
         scatter(b,Fb, 'filled', 'r')       %<--mark the found minimizer
         persitionInterval = abs(xTrueMin-b)%   with red in last iteration.
         drawnow;                           
       end
    end
    
    if optimalityTest == 1  %write performance information on graph
        
        iterations;
        functionEvaluations = iterations*2+2;
        if exist('tex1', 'var')
            delete(tex1);
            delete(tex2);
        end
        tex1 = text( -1.4, 38,                     ...
                     ['Function evaluations = ',   ...
                     num2str(functionEvaluations)],...
                     'Color', '[ 0 .55 0 ]')
        tex2 = text( -1.4, 34,                              ...
                     ['Iterations = ', num2str(iterations)],...
                     'Color', '[ 0 .55 0 ]')
    end
    
        %pause(.2) %<--pause for dramatic effect!
end
 
if optimalityTest == 1 %write persition interval on graph
    text( -1.4, 42,                     ...
          ['Difference from minimum = ',...
          num2str(persitionInterval,3)],...
          'Color', '[ 0 .55 0 ]' )
end

