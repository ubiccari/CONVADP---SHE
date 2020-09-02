clear 
T = 1;
tspan = linspace(-T/2,T/2,100);

%% Define function
f = @(t) sin(2*pi*t/T); 
%
n = 2;
f = @(t) (t>0).*(t<0.25);
%%
fspan = f(tspan);
n=1
bk = bk_fun(n,fspan,tspan);

plot(tspan,fspan)




%%
syms f(t) n T

bk = f*sin(2*pi*t/T);
dbk_df = functionalDerivative(bk,f);