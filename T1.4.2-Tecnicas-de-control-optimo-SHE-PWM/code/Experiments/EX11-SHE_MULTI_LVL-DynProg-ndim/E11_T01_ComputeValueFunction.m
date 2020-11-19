clear all

%%% Number of harmonics (dimension of the dynaical system)
harmonics = [1 3];
dim = length(harmonics);

%%% Number of neurons in the NN
nphi = 25; %discretization for the meridian
ntheta = 25; %discretization for the lattitude (discret. points without the poles)
[W] = nsphere(dim,ntheta,nphi);

[neurons,~] = size(W);
%% 
%%% Time discretization
Nt = 100;
T = pi/2;
tspan = linspace(0,T,Nt);
dt = tspan(2) - tspan(1);

%%% Evolution for the bias
[harm_grid, t_grid] = meshgrid(harmonics, tspan);
P = -(4/pi)*dt*sin(harm_grid.*t_grid);

%%% Create the bias
b = zeros(neurons, Nt);

for it = (Nt-1):(-1):1
    b(:,it) = b(:,it+1) + abs(W*P(it+1,:)');
end

%%% Define the value function

sigma = @(x) max(0, x);

ValueF = @(t_index,x) norm(sigma(W*x' - b(:,t_index)))^2;

surf(b)

%%
bT_time = zeros(dim,Nt);
bT_time(:,1)= 0.5*rand(dim,1);

f_time = zeros(1,Nt-1);

F = @(t,f) -(4/pi)*sin(harmonics'*t)*f;
f_span = [-1 1];

for it = 2:Nt

   bTc = bT_time(:,it-1);
   for ifs = 1:2
        bTn = bTc + dt*F(tspan(it),f_span(ifs));
        %
        Va(ifs) = ValueF(it,bTn');
   end
   [~,ind_f] = min(Va);

   f_time(it-1)  = f_span(ind_f);
   bT_time(:,it) = bT_time(:,it-1) + dt*F(tspan(it),f_span(ind_f));
end

clf
subplot(2,1,1)
hold on 
plot(bT_time')
yline(0)

subplot(2,1,2)
hold on
plot(tspan(1:end-1),f_time)
yline(0)
ylim([-2 2])

%%

ValueF = @(t_index,x) norm(sigma(W*x' - b(:,t_index)))^2;
ValueF = @(t_index,x) norm(sigma(W*x' - b(:,t_index)));

%ValueF = @(t_index,x) ValueFunEx(x,tspan(t_index),harmonics);

figure(1)

E12plot(harmonics,ValueF,Nt,tspan,W,b)
