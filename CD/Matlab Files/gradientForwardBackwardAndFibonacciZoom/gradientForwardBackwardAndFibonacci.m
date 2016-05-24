clear all
close all
clc

syms x1 x2;

%---- view settings -------------------------------------------------------
plotRange = 1;
topCutView = 1;
zoomConvergence = 0;
%--------------------------------------------------------------------------

f = -(cos(x1)^2 + cos(x2^2)^2)^2;

dfX1 = diff(f,x1);
dfX2 = diff(f,x2);

[X1,X2] = meshgrid(-1.5:.1:1.5);
f = -(cos(X1).^2 + cos(X2.^2).^2).^2;

figure('position', [ 959   209   511   501 ]);  %2 32 798 409
mesh(X1,X2,f, 'facecolor','none')
drawnow;


%view(6.5000, 16.0000); %<--rotate graph as wanted, then run
                        %   get(gca, 'View')
hold on;                %   coppy the two values (azimuth and elevation)
                        %   insert values in view(az, el)
%top cut view
if topCutView == 1
    axis([ -.9 .4 -1 1.2 -4 0 ])
    set(gca, 'CameraPosition', [9.0384   -5.5391   31.6467])
    set(gca, 'CameraTarget',   [-0.0880    0.0535   -1.2958])
    set(gca, 'CameraViewAngle', 8.1713)
    view(58.5000, 72.0000); %<--view from above.
end

%zoom on convergence view:
if zoomConvergence == 1
    axis([  -.2 .1 0 0.4 -4 -3.8 ])
    set(gca, 'CameraPosition', [3.5626   -1.2063   -0.3407])
    set(gca, 'CameraTarget',   [-0.0500    0.2000   -3.9000])
    set(gca, 'CameraViewAngle', 8.8476)
    view(54.7246, 56.8203);
end

%normal full view:
%axis([ -1.5 1.5 -1.5 1.5 -4 0 ])

%one side cut open view:
%axis([ -1.5 1.5 0 1.5 -4 0 ])

%zoom on convergence view:
%axis([  -.5 .5 0 0.3 -4 -3 ])

initX1 = -.8;%-1.4;
initX2 = -.9;%1.2;

isDone = 0;

while isDone == 0
    if exist('a','var')
        if c <= initF
            initX1 = a;
            initX2 = b;
            initF  = c;
        end
    else
        initF  = evalFunction(initX1, initX2);
        plot3(initX1, initX2, initF, 'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 2)
    end

    %finding derivative in X1 direction from initial point (x1, x2)
    dfXX1= subs(real(dfX1 ),x1,initX1);
    dfXX1= subs(real(dfXX1),x2,initX2);
    
    %finding derivative in X2 direction from initial point (x1, x2)
    dfXX2= subs(real(dfX2 ),x1,initX1);
    dfXX2= subs(real(dfXX2),x2,initX2);
    
    % gradient is then:   g = [ dfXX1
    %                           dfXX2 ]

    %------ The Forward-Backward Method -----------------------------------
    %--->Finding a 'bracket'/'search interval'/'interval of unsertainty'<--
    
%     plot3(initX1, initX2, initF, 'ok',  ...
%                   'MarkerFaceColor', 'c',...
%                   'MarkerSize', 5)
%               pause(3);
    
    step = .5;
    
    newX1 = double(real(initX1-dfXX1*step));
    newX2 = double(real(initX2-dfXX2*step));
    
    newF = evalFunction( newX1, newX2 );
    
%     plot3(newX1, newX2, newF, 'ok',  ...
%                   'MarkerFaceColor', 'r',...
%                   'MarkerSize', 5)
%               pause(3);
    
    done = 0;
    while done == 0
        if newF < initF  %-------------------------------------------------
       
           step = step+.1;
           newX1new = double(real(initX1-dfXX1*step));
           newX2new = double(real(initX2-dfXX2*step));
           
           newFnew = evalFunction( newX1new, newX2new );
           
%               plot3(newX1new, newX2new, newFnew, 'ok',  ...
%                   'MarkerFaceColor', 'b',...
%                   'MarkerSize', 5)
%               pause(3);
       
           if newF < newFnew
               %the region is [ (initX1, initX2) ; (newX1new newX2new) ]
               X1upper = newX1new;
               X2upper = newX2new;
               done = 1;           %<-----------------------------EXIT loop
           elseif newF > newFnew
               %stepped too far (over the hill)
               step = step*.5;
           end
    
        elseif newF > initF %----------------------------------------------
       
           step = step-.1;
           newX1new = double(real(initX1-dfXX1*step));
           newX2new = double(real(initX2-dfXX2*step));
           
           newFnew = evalFunction( newX1new, newX2new );
           
%            plot3(newX1new, newX2new, newFnew, 'ok',  ...
%                   'MarkerFaceColor', 'y',...
%                   'MarkerSize', 5)
%               pause(3);
       
           if newF > newFnew
               %the region is [ (initX1, initX2) ; (newX1 newX2) ]
               X1upper = newX1;
               X2upper = newX2;
               done = 1;           %<-----------------------------EXIT loop
           elseif newF < newFnew
               %stepped too far (over the hill)
               step = step*.5;
           end
    
        end  %-------------------------------------------------------------
    end
    if plotRange == 1
        fXupper = evalFunction(X1upper, X2upper);
        plot3(X1upper, X2upper, fXupper, 'ok', ...
             'MarkerFaceColor', 'k',           ...
             'MarkerSize', 2)
        v1 = [X1upper X2upper fXupper];
        v2 = [initX1 initX2 initF];
        v = [v1; v2];
        plot3(v(:,1),v(:,2),v(:,3),'k', 'LineWidth', 1, 'LineStyle', ':')
    end
    
    % bracket = [ (initX1, initX2) ; (X1upper X2upper) ]

    %----------------------------------------------------------------------

    [ a, b, isDone ] = fibonacciSearch(initX1, initX2, X1upper, X2upper);
    
    c = evalFunction(a,b);

    if c <= initF && isDone == 0
        plot3(a, b, c, 'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 2)
        v1 = [initX1 initX2 initF];
        v2 = [a b c];
        v = [v1; v2];
        plot3(v(:,1),v(:,2),v(:,3),'b', 'LineWidth', 1.4)
    elseif c > initF && isDone == 0
        plot3(a, b, c, 'or', 'MarkerFaceColor', 'r', 'MarkerSize', 2)
        v1 = [initX1 initX2 initF];
        v2 = [a b c];
        v = [v1; v2];
        plot3(v(:,1),v(:,2),v(:,3),'r', 'LineWidth', 1.4)
    end

    drawnow;
end

%title('Zoom on Convergence of Steepest Descend');
title({'Steepest Descend with Forward Backward Method and';...
       'Fibonacci Line Search'});
xlabel('X1');
ylabel('X2');
zlabel('f(x)    ', 'Rotation', 0);
