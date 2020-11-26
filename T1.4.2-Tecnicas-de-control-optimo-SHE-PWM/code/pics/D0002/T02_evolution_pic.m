path = "../docs/S0001-Resumen-19-11-2020/imgs/T01/";

tspan = linspace(0,pi,800);

ft = (tspan>pi/4).*(tspan<(3*pi/4))
ft = 2*ft - 1;
f = @(t) interp1(tspan,ft,t);

pt =find(diff(ft));

dyn = @(t,x) (2/pi)*f(t)*[ cos(t); sin(t)];

x0 = [0;0];

[~,xt] = ode45(dyn,tspan,x0);


xT = (2/pi)*trapz(tspan,cos(tspan).*ft);
yT = (2/pi)*trapz(tspan,sin(tspan).*ft);

%%
figure(1)
clf 
grid on
box
hold on
plot(xt(:,1),xt(:,2),'LineWidth',2)


swp = plot(xt(pt,1),xt(pt,2),'marker','.','LineStyle','none','MarkerSize',18,'Color','g')
swp.Parent.FontSize = 15;
yline(0)
xline(0)

initp = plot(xt(1,1),xt(1,2),'Marker','.','MarkerSize',18,'Color','r','LineStyle','none');
endp  = plot(xt(end,1),xt(end,2),'Marker','.','MarkerSize',18,'Color','k','LineStyle','none');

legend([initp,endp,swp(1)],{'$\tau = 0$','$\tau = \pi$','switching'},'FontSize',18,'Interpreter','latex','Location','south')
xlim([-0.5 0.3])
ylim([-0.4 0.9])

%title("Dynamical System","Interpreter","latex",'FontSize',21)
xlabel('$\alpha_1$','Interpreter','latex','FontSize',21)
ylabel('$\beta_1$','Interpreter','latex','FontSize',21)

print('../docs/D0002-OptimalControlOpenLoop/img/sys.eps','-depsc')
figure(2)
clf 
box
grid on
hold on
plot(tspan,ft,'LineWidth',2);
initp = plot(tspan(1),ft(1),'Marker','.','MarkerSize',18,'color','r','LineStyle','none');
endp = plot(tspan(end),ft(end),'Marker','.','MarkerSize',18,'Color','k','LineStyle','none');
endp.Parent.FontSize = 15;

yline(0)
for ii = pt
   swp = xline(tspan(ii),'LineWidth',1,'Color','g') 
end

legend([initp,endp,swp(1)],{'$\tau = 0$','$\tau = \pi$','switching'},'FontSize',18,'Interpreter','latex','Location','south')

%title("Control",'Interpreter','latex','FontSize',21)
xlabel("\tau",'FontSize',21)
ylabel("$f(\tau)$",'Interpreter','latex','FontSize',21)

xticks([0 pi/4 pi/2 3*pi/4 pi])
xticklabels({'0','\pi/4','\pi/2','3\pi/2','\pi'})
ylim([-1.5 1.5])
xlim([0 pi])
print('../docs/D0002-OptimalControlOpenLoop/img/con.eps','-depsc')