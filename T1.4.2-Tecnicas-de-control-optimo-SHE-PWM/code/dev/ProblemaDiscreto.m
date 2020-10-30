
% 
import casadi.*
clear 

n = 4;


Vdc = 100;

b1  = 0.6283*(4*Vdc)/pi;

bT = [b1 0 0 0]';

bk = @(k,alpha)  -(4*Vdc./(k*pi)).*( 1 - 2*sum( ((-1).^((1:n)'-1)).*(cos(k*alpha))));
%

opti = casadi.Opti();
alpha = opti.variable(n);

cost = arrayfun(@(i) (bk(i,alpha) - bT(i))^2,1:n,'UniformOutput',false);
cost = sum([cost{:}]);
opti.minimize(cost);

opti.subject_to(alpha(1) > 0)
opti.subject_to(alpha(2) > alpha(1))
opti.subject_to(alpha(3) > alpha(2))
opti.subject_to(alpha(4) > alpha(3))
opti.subject_to(pi/4     > alpha(4))

opti.solver('ipopt');

alpha_init = linspace(0+0.2,pi/4-0.2,n);
opti.set_initial(alpha,rand*(pi/4))

sol = opti.solve();

alpha_values = sol.value(alpha);

%
plot(alpha_values,'*')