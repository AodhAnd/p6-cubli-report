clear all
close all
clc

%----- PLOT OPTIONS -------------------------------------------------------
optimalityTest = 1;      %<--if set to 0 then
                         %   it is made for better comprehension of method.
                         %   if set to 1 then
                         %   it is made for testing of performance.
if optimalityTest == 1
   plotRegionReduction = 0; %<--grays out the area excluded by the search
   scale = 0;               %<--scaling as the process zeroes in on the min
   %choose when to scale:
   scaleAfterIt1 = 6;       %<--after x iteratinos
   scaleAfterIt2 = 14;      %<--after y iterations
else
   plotRegionReduction = 0;  %<--these two only works with the
   scale = 0;                %<  optimalityTest setting swiched on
end

%alternate figure position
figurePosition = [ 5 30 839 420 ];   %<--current scaling of everything is
%figurePosition = 'default';         %   made for this figure size
%figurePosition = [ 2 32 798 349 ];


%color settings
textBackGround = '[  .9  .9  .9]';
textBckgEdge   = '[  .6  .6  .6]';
minBackGround  = '[ 1    .4  .4]';
minBckgEdge    = '[  .6 0   0  ]';

%font settiings
XaXbFontSize = 7;
MinMaxFontSize = 10;
XaXbFontWeight = 'bold';
MinMaxFontWeight = 'bold';

%with of edge-line on Xa Xb markers
textBckgEdgeWidth = 1.13;

%settings for spacing and offsets
verticalSpacing = .11;
initXaXbOff    =  0.06;  XaXbOff = initXaXbOff;
ifEqualXaXbOff =  0.16;
XaBckgOffset   =  0   ; %-XaXbOff;
XaLabelOffset  = -0.15; %-XaXbOff;
XbBckgOffset   =  0   ; %+XaXbOff;
XbLabelOffset  = -0.15; %+XaXbOff;

%--------------------------------------------------------------------------

%----- PICK THE FUNCTION YOU WISH TO MINIMIZE -----------------------------
fx1 = 0; %<-- f(x) = x^2;
fx2 = 1; %<-- f(x) = x^2 + 5*x;

if fx1 == 1
    x = -20:.01:25;
    syms xSym;
    f = x.^2;
    fSym = xSym^2;
elseif fx2 == 1
    x = -8:.01:5;
    syms xSym;
    f = x.^2 + 5*x;
    fSym = xSym^2 + 5*xSym;
end
%--------------------------------------------------------------------------

%analyticly determine minimum of f for comparison with resulting minimizer
xTrueMin = double(solve(diff(fSym) == 0, xSym));
yTrueMin = double(subs(fSym,xSym,xTrueMin));

%plot cost function
figure('position', figurePosition)
plot(x,f, 'linewidth', 1.4)
hold on
grid on, grid minor;
xlim([ min(x) max(x)]);
limY = get(gca,'ylim');
limX = get(gca,'xlim');

%--------------------------------------------------------------------------
%---- FIBONACCI SEARCH ----------------------------------------------------
%--------------------------------------------------------------------------

%initializing range
Xmin = min(x)+.5;
Xmax = max(x)-.5;
fXmin = double( subs(fSym, xSym, Xmin) );
fXmax = double( subs(fSym, xSym, Xmax) );

%plotting Xmin
line( [Xmin Xmin], limY, 'linestyle', '-', 'linewidth', 1,...
      'color', '[1 0 0]' );  
%label for Xmin line
text( Xmin+.1, limY(2)-.5*((limY(2)-limY(1))*verticalSpacing),  ...
      '\leftarrow Xmin', 'FontWeight', MinMaxFontWeight,...
      'FontSize', MinMaxFontSize);

%plotting Xmax
line( [Xmax Xmax], limY, 'linestyle', '-', 'linewidth', 1,...
      'color', '[1 0 0]' );  
%label for Xmax line
text( Xmax-1.2, limY(2)-.5*((limY(2)-limY(1))*verticalSpacing),  ...
      'Xmax \rightarrow', 'FontWeight', MinMaxFontWeight,...
      'FontSize', MinMaxFontSize );

I1 = Xmax-Xmin;

%---- Recursive implementation of fibonacci (very inefficient (12 s)) -----
% i = 27;
% while i >= 1
%     fibonacciFunction(i)
%     i= i-1;
% end
%--12578 ms----------------------------------------------------------------

%---- for-loop implementation of fibonacci (way more inefficient) ---------
% n = 49;
% fibonacci = zeros(n,1);
% fibonacciLast = 1;
% fibonacciSecondLast = 1;
% for i = 1:n+1
%     if i == 1 || i == 2
%         fibonacci(i) = 1;
%     else
%         fibonacci(i) = fibonacciLast + fibonacciSecondLast;
%         fibonacciSecondLast = fibonacciLast;
%         fibonacciLast = fibonacci(i);
%     end
% end
%--0.023 ms----------------------------------------------------------------

%---- The first 50 fibonacci numbers (from F0 to F49) ---------------------
fibonacci = [ 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 ...
              4181 6765 10946 17711 28657 46368 75025 121393 196418    ...
              317811 514229 832040 1346269 2178309 3524578 5702887     ...
              9227465 14930352 24157817 39088169 63245986 102334155    ...
              165580141 267914296 433494437 701408733 1134903170       ...
              1836311903 2971215073 4807526976 7778742049 12586269025  ]';
%--0.010 ms----------------------------------------------------------------

%setting highest magnitude fibonacci-number for a precision interval of In
if optimalityTest == 1
    In = 0.01;
else
    In = .5;
end
FnWanted = I1/In;

%---- Selecting Fn from the fibonacci numbers -----------------------------
for i = 1:50
    if FnWanted < fibonacci(i)
        Fn = fibonacci(i);
        n = i-1;
        In = I1/Fn;
        break;
    end
end
%--0.153 ms----------------------------------------------------------------

nn = n+1;
I = zeros(nn,1);

for i = 1:nn
    I(n+2-nn) = fibonacci(nn)*In;
    nn = nn-1;
end

for i = 2:n+1

    if i>2
        XaOld = Xa;
        XbOld = Xb;
    end
    
if i == 2
    Xb = Xmax-(I(i-1)-I(i));
    Xa = Xmin+(I(i-1)-I(i));
elseif strcmp(setX, 'Xa')
    Xa = Xb;
    Xb = Xmax-(I(i-1)-I(i));
elseif strcmp(setX, 'Xb')
    Xb = Xa;
    Xa = Xmin+(I(i-1)-I(i));
end

fXa = double( subs(fSym, xSym, Xa) );
fXb = double( subs(fSym, xSym, Xb) );

%only update lines if there is new data to plot
if i == 2
    XaLine = line( [Xa Xa], limY,     ...
                   'linestyle', '-',  ...
                   'linewidth', 1,   ...
                   'color', '[0 0.447 0.741]' );
    uistack(XaLine, 'bottom');
    
    if optimalityTest == 0
     %label for Xa lines
     XaBckg = scatter( Xa+XaBckgOffset-XaXbOff,                         ...
                       limY(2)-((limY(2)-limY(1))*verticalSpacing), 220,...
                       'filled', 'MarkerFaceColor', textBackGround,     ...
                       'MarkerEdgeColor', textBckgEdge,                 ...
                       'LineWidth', textBckgEdgeWidth);
     XaLabel = text( Xa+XaLabelOffset-XaXbOff,                          ...
                     limY(2)-((limY(2)-limY(1))*verticalSpacing),       ...
                     'X_a', 'FontSize',XaXbFontSize,                    ...
                     'FontWeight',XaXbFontWeight );
     uistack(XaBckg, 'top');
     uistack(XaLabel, 'top');
    end

    XbLine = line( [Xb Xb], limY,     ...
                   'linestyle', '-',  ...
                   'linewidth', 1,   ...
                   'color', '[0 0.447 0.741]' );
    uistack(XbLine, 'bottom');

    if optimalityTest == 0
     %label for Xb line
     XbBckg = scatter( Xb+XbBckgOffset+XaXbOff,                         ...
                       limY(2)-((limY(2)-limY(1))*verticalSpacing), 220,...
                       'filled', 'MarkerFaceColor', textBackGround,     ...
                       'MarkerEdgeColor', textBckgEdge,                 ...
                       'LineWidth', textBckgEdgeWidth );
     XbLabel = text( Xb+XbLabelOffset+XaXbOff,                          ...
                     limY(2)-((limY(2)-limY(1))*verticalSpacing),       ...
                     'X_b', 'FontSize',XaXbFontSize,                    ...
                     'FontWeight',XaXbFontWeight );
     uistack(XbBckg, 'top');
     uistack(XbLabel, 'top');
    end
end

if Xa ~= Xb
    XaXbOff = initXaXbOff;
elseif Xa == Xb
    XaXbOff = ifEqualXaXbOff;
end

if XaLine.XData(1) ~= Xa || Xa == Xb || Xa == Xa || Xb == Xb
    
    if exist('setX','var')
        if strcmp(setX, 'Xb')
            set(XaLine, 'visible', 'off')
        end
    end
    
    XaLine = line( [Xa Xa], limY,     ...
                   'linestyle', '-',  ...
                   'linewidth', 1,   ...
                   'color', '[0 0.447 0.741]' );
    uistack(XaLine, 'bottom');

    if optimalityTest == 0
     %label for Xa lines
     XaBckg = scatter(Xa+XaBckgOffset-XaXbOff,                          ...
                      limY(2)-(i-1)*((limY(2)-limY(1))*verticalSpacing),...
                      220, 'filled', 'MarkerFaceColor', textBackGround, ...
                      'MarkerEdgeColor', textBckgEdge,                  ...
                      'LineWidth', textBckgEdgeWidth );
     XaLabel = text( Xa+XaLabelOffset-XaXbOff,                          ...
                     limY(2)-(i-1)*((limY(2)-limY(1))*verticalSpacing), ...
                     'X_a', 'FontSize',XaXbFontSize,                    ...
                     'FontWeight',XaXbFontWeight );
     uistack(XaBckg, 'top');
     uistack(XaLabel, 'top');
    end

end

if XbLine.XData(1) ~= Xb  || Xa == Xb || Xa == Xa || Xb == Xb
    
    if exist('setX','var')
        if strcmp(setX, 'Xa')
            set(XbLine, 'visible', 'off')
        end
    end
    
    XbLine = line( [Xb Xb], limY,     ...
                   'linestyle', '-',  ...
                   'linewidth', 1,   ...
                   'color', '[0 0.447 0.741]' );
    uistack(XbLine, 'bottom');
    
    if optimalityTest == 0
     %label for Xb lines
     XbBckg = scatter(Xb+XbBckgOffset+XaXbOff,                          ...
                      limY(2)-(i-1)*((limY(2)-limY(1))*verticalSpacing),...
                      220, 'filled', 'MarkerFaceColor', textBackGround, ...
                      'MarkerEdgeColor', textBckgEdge,                  ...
                      'LineWidth', textBckgEdgeWidth );
     XbLabel = text( Xb+XbLabelOffset+XaXbOff,                          ...
                     limY(2)-(i-1)*((limY(2)-limY(1))*verticalSpacing), ...
                     'X_b', 'FontSize',XaXbFontSize,                    ...
                     'FontWeight',XaXbFontWeight );
     uistack(XbBckg, 'top');
     uistack(XbLabel, 'top');
    end
end
drawnow;

if fXb > fXa
    Xmax = Xb;
    if optimalityTest == 0
        set(XbBckg, 'MarkerEdgeColor', '[0 0 1]')
    end
    if plotRegionReduction == 1
        set(XbLine, 'color', 'k', 'linestyle', '-', 'linewidth', .8);
        if exist('regionR','var')
            set(regionR, 'visible', 'off');
        end
        regionR = patch( [ Xb      limX(2) limX(2) Xb      ],      ...
                         [ limY(1) limY(1) limY(2) limY(2) ], 'r', ...
                         'FaceColor', 'k',                         ...
                         'EdgeColor', 'none',                      ...
                         'FaceAlpha',.05);
        uistack(regionR, 'bottom');
        drawnow;
    end
    setX = 'Xb';
elseif fXa >= fXb
    Xmin = Xa;
    if optimalityTest == 0
        set(XaBckg, 'MarkerEdgeColor', '[1 0 0]')
    end
    if plotRegionReduction == 1
    set(XaLine, 'color', 'k', 'linestyle', '-', 'linewidth', .8);
        if exist('regionL','var')
            set(regionL, 'visible', 'off');
        end
        regionL = patch( [ limX(1) Xa      Xa      limX(1) ],      ...
                         [ limY(1) limY(1) limY(2) limY(2) ], 'r', ...
                         'FaceColor', 'k',                         ...
                         'EdgeColor', 'none',                      ...
                         'FaceAlpha',.05);
        uistack(regionL, 'bottom');
        drawnow;
    end
    setX = 'Xa';
end

if scale == 1  %<--zooming in as the algorithm iterates
    if i == scaleAfterIt1
        xlim([ limX(1)-((limX(1)-xTrueMin)/1.1)...
               limX(2)-((limX(2)-xTrueMin)/1.1) ])
        ylim([ limY(1)-((limY(1)-yTrueMin)/1.009)...
               limY(2)-((limY(2)-yTrueMin)/1.009) ])
        limY = get(gca,'ylim');
        limX = get(gca,'xlim');
    end
    if i == scaleAfterIt2
        xlim([ limX(1)-((limX(1)-xTrueMin)/2)...
               limX(2)-((limX(2)-xTrueMin)/2) ])
        ylim([ limY(1)-((limY(1)-yTrueMin)/1.4)...
               limY(2)-((limY(2)-yTrueMin)/1.4) ])
    end
end

    if optimalityTest == 1  %write performance information on graph
        
        iterations = i-1;
        functionEvaluations = iterations+2;
        if exist('tex1', 'var')
            delete(tex1);
            delete(tex2);
        end
        tex1 = text( .05, 38,                      ...
                     ['Function evaluations = ',   ...
                     num2str(functionEvaluations)],...
                     'Color', '[ 0 .55 0 ]')
        tex2 = text( .05, 34,                               ...
                     ['Iterations = ', num2str(iterations)],...
                     'Color', '[ 0 .55 0 ]')
    end

    %pause(.1)%<--pause for dramatic effect!
end

if fXa < fXb
    persitionInterval = abs(xTrueMin-Xa);
    
    if optimalityTest == 0
        set( XaBckg, 'MarkerFaceColor', minBackGround,...
                     'MarkerEdgeColor', minBckgEdge );
        set(XaLine, 'color', 'r', 'linestyle', '-', 'linewidth', 2);
        uistack(XaLine, 'up', 2);
    else
        set(XaLine, 'color', 'k', 'linestyle', '-', 'linewidth', 1.2);
        uistack(XaLine, 'top');
        
        %writing persition interval on graph
        text( .05, 42,                      ...
              ['Difference from minimum = ',...
              num2str(persitionInterval,3)],...
              'Color', '[ 0 .55 0 ]' )
    end
end

if fXb < fXa
    
    persitionInterval = abs(xTrueMin-Xb);
    
    if optimalityTest == 0
        set(XbBckg, 'MarkerFaceColor', minBackGround,...
                    'MarkerEdgeColor', minBckgEdge );
        set(XbLine, 'color', 'r', 'linestyle', '-', 'linewidth', 2);
        uistack(XbLine, 'up', 2);
    else
        set(XaLine, 'color', 'k', 'linestyle', '-', 'linewidth', 1.2);
        uistack(XbLine, 'top');
        
        %writing persition interval on graph
        text( .05, 42,                      ...
              ['Difference from minimum = ',...
              num2str(persitionInterval,3)],...
              'Color', '[ 0 .55 0 ]' )
    end
end




%adding title and labels
xlabel('X')
if fx1 == 1
    title('Fibonacci Line Search')
    ylabel('f(x) = x^2')
elseif fx2 == 1
    title('Fibonacci Line Search')
    ylabel('f(x) = x^2 + 5x')
end
