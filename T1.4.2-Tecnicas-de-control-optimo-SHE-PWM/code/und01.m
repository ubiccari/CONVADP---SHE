clear 
tspan = linspace(0,pi/2,100);

harm = [1;3;7 ;9];


bt = @(b0,t,f,j) b0 - (4/(pi.*harm(j))).*f*( 1 - cos(harm(j)*t)) ;

dim = length(harm)


bspan = linspace(-1.8,1.8,10);
clf

[~,betamax] = ode45(@(t,beta)  (4/pi)*abs(sin(harm.*t)),tspan,zeros(size(harm)));
[~,betamin] = ode45(@(t,beta) -(4/pi)*abs(sin(harm.*t)),tspan,zeros(size(harm)));

for idim = 1:dim
   subplot(1,dim,idim)
   hold on
   bt_value  = bt(bspan,tspan',-1,idim);
   plot(bt_value,tspan,'b')
   plot(bspan,0*bspan,'k','Marker','o')
   xline(0)
   bt_value  = bt(bspan,tspan',1,idim); 
   plot(bt_value,tspan,'r')
   xlim([-1.5 1.5])
   

   plot(-betamax(1,idim) + betamax(:,idim),tspan,'k','LineWidth',5)
   plot(-betamin(2,idim) + betamin(:,idim),tspan,'k','LineWidth',5)

   title("\beta_{"+harm(idim)+"}")
   ylabel('time')
   xlabel("\beta_"+harm(idim))

end

