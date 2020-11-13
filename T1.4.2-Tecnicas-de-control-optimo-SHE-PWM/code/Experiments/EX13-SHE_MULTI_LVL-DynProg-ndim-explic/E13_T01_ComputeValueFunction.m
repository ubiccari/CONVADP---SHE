clear all

%%% Number of harmonics (dimension of the dynaical system)
harmonics = [1 5 7 9 11];
dim = length(harmonics);
%%% Time discretization
Nt = 300;
T = pi/2;
tspan = linspace(0,T,Nt);

%%
rand_only_b1 = true;

if rand_only_b1
    b0 = zeros(length(harmonics),1);
    b0(1) = 0.5*rand;
else
    b0 = 0.25*rand(length(harmonics),1);
end
%b0 = [0.5 0.0 0.0 0.0 0.0];
[f_time,bT_time] = ComputeSolution_EX13(tspan,b0,harmonics,2);
%
figure(1)

PlotSolution(f_time,bT_time,b0,tspan,harmonics)

%%