function [result] = ValueFunEx(x0,t,harmonics)

x0norm = norm(x0);
x0unit = x0/x0norm;

T = pi/2;
tspan = linspace(t,T,50);

Fdyn = -(4/pi)*sin(harmonics'.*tspan);

bias = trapz(tspan, abs(sum(Fdyn.*x0unit') ));
bias = trapz(tspan, abs(Fdyn'*x0unit'));

k = 30;

value = x0norm-bias;

result = max(0,value);
% result = 0.5 + 0.5*tanh(k*value);
% 
% result = value^2*result;

