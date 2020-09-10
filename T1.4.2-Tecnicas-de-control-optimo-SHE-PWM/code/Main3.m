clear all;close allimport casadi.*m = 3;as = SX.sym('a',m,1);bs = SX.sym('b',m,1);fs = SX.sym('f',1,1);ts = SX.sym('t');%aT = [1 0 0]';bT = [0 1 0]';%Fmax = +0.9;Fmin = -0.9;%%Xs = [as;bs];das = fs*sin([1:2:(2*m-1)]'.*ts);dbs = fs*cos([1:2:(2*m-1)]'.*ts);dynfcn = Function('f',{ts,Xs,fs},{ [das;dbs] });%tspan = linspace(0,pi,100);idyn = ode(dynfcn,Xs,fs,tspan);idyn.InitialCondition = zeros(2*m,1);SetIntegrator(idyn,'RK4')Control0 = ZerosControl(idyn);FreeState = solve(idyn,Control0);%epsilon = 1e-4;PathCost  = Function('L'  ,{ts,Xs,fs},{ epsilon*(fs^2)           });FinalCost = Function('Psi',{Xs}      ,{ (aT - as)'*(aT - as) + (bT - bs)'*(bT - bs)  });iocp = ocp(idyn,PathCost,FinalCost);iocp.constraints.MaxControlValue = Fmax;iocp.constraints.MinControlValue = Fmin;ControlGuess = ZerosControl(idyn);[OptControl ,OptState] = IpoptSolver(iocp,ControlGuess);%%figure(12)subplot(2,2,1);plot(tspan,OptState(1:m,:)');title('a_n(\tau)')xticks([0 pi/2 pi])xticklabels({'0','\pi/2','\pi'})yticks([0 1])yline(1)ylim([-0.5 1.2])yline(0)yline(1)xlabel('\tau')legend("a_"+(1:m)','Location','northeastoutside')%subplot(2,2,3);plot(tspan,OptState(m+1:end,:)');title('b_n(\tau)')xticks([0 pi/2 pi])xticklabels({'0','\pi/2','\pi'})ylim([-0.5 1.2])yline(1)yline(0)xlabel('\tau')legend("b_"+(1:m)','Location','northeastoutside')%%%subplot(1,2,2);plot(tspan,OptControl)title('f(\tau)')xlabel('\tau')xticks([0 pi/2 pi])xticklabels({'0','\pi/2','\pi'})ylim([1.1*Fmin 1.1*Fmax])yticks([Fmin Fmax])yticklabels({'F_{min}','F_{max}'})%%print('../docs/D0001-CalculusOfVariationIntro/fig/img03.eps','-depsc')