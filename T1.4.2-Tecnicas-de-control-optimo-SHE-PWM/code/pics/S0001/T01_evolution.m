clf 
path = "../docs/S0001-Resumen-19-11-2020/imgs/T01/";

tspan = linspace(0,pi,200);

ft = sin(4*tspan) + cos(2*tspan+0.2);
ft = sign(ft);

f = @(t) interp1(tspan,ft,t);

dyn = @(t,x) (2/pi)*f(t)*[ cos(t); sin(t)];

x0 = [0;0];

[~,xt] = ode45(dyn,tspan,x0);


xT = (2/pi)*trapz(tspan,cos(tspan).*ft);
yT = (2/pi)*trapz(tspan,sin(tspan).*ft);

clf
subplot(2,1,1)
hold on
plot(xt(:,1),xt(:,2),'LineWidth',2)

yline(0)
xline(0)

iplot = plot(xt(1,1),xt(1,2),'Marker','.','MarkerSize',18);

xlim([-0.5 0.5])
ylim([-0.5 0.5])

title("Sistema dinámico","Interpreter","latex")
xlabel('$\alpha_1$','Interpreter','latex','FontSize',21)
ylabel('$\beta_1$','Interpreter','latex','FontSize',21)


subplot(2,2,3)
hold on
plot(tspan,ft,'LineWidth',2);
jplot =plot(tspan(1),ft(1),'Marker','.','MarkerSize',18);

title("Control")
xlabel("\tau",'FontSize',21)
ylabel("$f(\tau)$",'Interpreter','latex','FontSize',21)
ylim([-1.5 1.5])
xlim([0 pi])

subplot(2,2,4)


bar([1,2],[xT,yT]);
title('Coeficientes de Fourier')
xticklabels({'\alpha_1','\beta_1'})
ylim([-0.3  0.3])
v = VideoWriter(fullfile(path,'peaks'),'MPEG-4');
open(v);
%%
for it = 1:2:200
   iplot.XData = xt(it,1); 
   iplot.YData = xt(it,2);
   
   jplot.XData = tspan(it);
   jplot.YData = ft(it);
   
   if false
    frame = getframe(gcf);
    writeVideo(v,frame);
   else
     pause(0.1)  
   end
end
close(v);
%%
for it = 200:-2:1
   iplot.XData = xt(it,1); 
   iplot.YData = xt(it,2);
   
   jplot.XData = tspan(it);
   jplot.YData = ft(it);
   
   if false
    frame = getframe(gcf);
    writeVideo(v,frame);
   else
     pause(0.1)  
   end
end
close(v);
%%
print('../docs/S0001-Resumen-19-11-2020/imgs/S0001.eps','-depsc')
