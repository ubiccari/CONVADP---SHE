clear all
%%
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
Nt = 500;
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
sigma = @(x) 0.5 + 0.5*tanh(100*x);
ValueF = @(t_index,x) (1/neurons)*norm(sigma(W*x' - b(:,t_index)))^2;

surf(b)


%%

figure(1)

E12plot(harmonics,ValueF,Nt,tspan,W,b)
