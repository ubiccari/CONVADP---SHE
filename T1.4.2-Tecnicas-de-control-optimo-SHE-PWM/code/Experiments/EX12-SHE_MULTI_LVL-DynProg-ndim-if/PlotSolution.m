function PlotSolution(f_time,bT_time,b0,tspan,harmonics)

T = tspan(end);
Nt = length(tspan);
clf

%%
subplot(2,2,1)
hold on 
plot(bT_time')
yline(0)
ylim([-0.5 0.5])

%%
subplot(2,2,2)

refine_tspan = linspace(0,T,3*Nt);
refine_f_time = interp1(tspan(1:end-1),f_time,refine_tspan,'nearest','extrap');

plot(refine_tspan,refine_f_time)
ylim([-1.5 1.5])
yline(0)
%%
subplot(2,2,4)
[an,bn] = f2anbn(refine_f_time,refine_tspan,0,harmonics');
jb = bar(bn)
title('Harmónicos Obtenidos')
ylim([-1 1])
xticklabels("\beta_{"+harmonics'+'}')
jb.Parent.FontSize = 20;


%%
subplot(2,2,3)
ib = bar(b0)
title('Harmónicos Target')
ylim([-1 1])
ib.Parent.FontSize = 20;
xticklabels("\beta_{"+harmonics'+'}')
end

