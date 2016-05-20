function [ fusedAngle ] = simSensToolCompFilter( u, t, par)

tau=par(1);
T=0.01;
fusedAngle = zeros(numel(t), 1);

% Bilinear transformed differences equation
Q1 = (2*tau-T)/(2*tau+T);
Q2 = T/(2*tau+T);
fusedAngle(1) = u((1),1);
    for i = 2:1:numel(t)
        fusedAngle(i) = Q1*fusedAngle(i-1) + Q2*(u((i),1)+u((i-1),1) + tau*u((i),2) + tau*u((i-1),2));
    end
end

