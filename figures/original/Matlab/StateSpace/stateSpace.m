clear all;
close all;
clc;

%% Cubli model parameters
J_w=0.601e-3;
J_f=4.8e-3;
B_w=17.03e-6;
B_f=7.7e-3;
m_w=0.222;
m_f=0.77-m_w;%0.354;
g=9.82;
l_w=0.093;
l_f=0.08498;%0.076;

% Disturbance data
disturb=0.65;    % Disturbance torque value in Nm
t_dist=0.01;    % Duration of the disturbance

%% Description in State-Space
% x=[theta_F thetadot_F thetadot_w]
% y=[theta_F thetadot_w]
% u=torque
% xdot=A*x+B*u and y=C*x+D*u

A=[0 1 0;
    (m_f*l_f+m_w*l_w)*g/(J_f+m_w*l_w^2) -B_f/(J_f+m_w*l_w^2) B_w/(J_f+m_w*l_w^2);
    -(m_f*l_f+m_w*l_w)*g/(J_f+m_w*l_w^2) B_f/(J_f+m_w*l_w^2) -(J_f+J_w+m_w*l_w^2)*B_w/(J_w*(J_f+m_w*l_w^2))];
B=[0;
    -1/(J_f+m_w*l_w^2);
    (J_f+J_w+m_w*l_w^2)/(J_w*(J_f+m_w*l_w^2))];
C=[1 0 0;
    0 0 1];
D=[0;
    0];

%system=ss(A,B,C,D);

%% Analisys of the system
eigenvalues=eig(A);
cont=[A A*B A^2*B];
rank(cont); % is equal to 3 - the system can be controlled
obs=[C;
    C*A;
    C*A^2];
rank(obs); % is equal to 3 - the internal states can be found through the outputs

%% Comparison between different position of closed-loop poles

P=[-4 -5 -15];
K=place(A,B,P);
   
k=1;
P1=[0 -1 -2];
close all;
for i=1:0.5:20
    P1(k)=P1(k)-2;
%     if (P1(1)==P1(2) || P1(1)==P1(3) || P1(2)==P1(3)) 
%      P1(k)=P1(k)-2;
%     end;
    P1(2)=P1(1)-1;  
    P1(3)=P1(2)-8;
    K1=place(A,B,P1);
    if (i==1)
        Ptotal=P1;
        Ktotal=K1;
    else
        Ptotal=[Ptotal; P1];
        Ktotal=[Ktotal; K1]; 
    end;
    warning('off');
    sim('stateSpaceController.slx');
    warning('on');
    figure(1);
    plot(position1,'linewidth',1.2);
    hold on;
    figure(2);
    plot(position2,'linewidth',1.2);
    hold on;   
    drawnow;    
    hold on;
    if (K1(1)<-5)
        break;
    end;
end

figure(1);
title('Catching Response with Initial Velocity of the Frame');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
xlabel('Time (s)');
ylabel('Angular Position (rad)');
xlim([0 3]);
hold off;

figure(2);
title('Disturbance Torque Response');
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)
xlabel('Time (s)');
ylabel('Angular Position (rad)');
hold off;


