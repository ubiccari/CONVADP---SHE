clear all

%%% Number of harmonics (dimension of the dynaical system)
harmonics = [1 5 7 9 11];
dim = length(harmonics);
%%% Time discretization
Nt = 500;
T = pi/2;
tspan = linspace(0,T,Nt);

ValueF = ComputeValueFunction(harmonics,tspan);
%%
rand_only_b1 = false;

if rand_only_b1
    b0 = zeros(length(harmonics),1);
    b0(1) = 0.5*rand;
else
    b0 = 0.5*rand(length(harmonics),1);
end
%b0 = [0.5 0.0 0.0 0.0 0.0];
[f_time,bT_time] = ComputeSolution(ValueF,tspan,b0,harmonics,20);
%
figure(1)

PlotSolution(f_time,bT_time,b0,tspan,harmonics)

%%
M = 100;
b1span = linspace(-1.25,1.25,M);
%b1span = linspace(0,1.25,M);

b0 = zeros(dim,1);
f_time = zeros(M,Nt-1);

bn_M = zeros(100,dim)

for i  = 1:M
   b0(1) = b1span(i);
   [f_time(i,:),bT_time,bn_M(i,:)] = ComputeSolution(ValueF,tspan,b0,harmonics,2); 
   fprintf("iter = "+i+"\n")
end
%
err_b1  = (bn_M(:,1) - b1span').^2;
otherbn = sum(bn_M(:,2:end).^2,2);

err_total = (err_b1 + otherbn);
%%
figure(2)
clf
subplot(1,2,1)
surf(tspan(1:end-1),b1span,f_time)
shading interp
xlabel('$f(\tau)$',"FontSize",25,'Interpreter','latex')
ylabel("$b_1$",'FontSize',25,'Interpreter','latex')
colorbar
view(90,-90)

subplot(1,2,2)

plot(b1span,err_total)
title('$J[f(\tau)] = \frac{1}{|\mathcal{E}_b|}\sum_{j} (\beta(T) - b_j)^2$',"FontSize",25,'Interpreter','latex')

xlabel("$b_1$",'FontSize',25,'Interpreter','latex')
