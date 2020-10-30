clear all;
import casadi.*
%
ha = [1    2  3  4 ];
aT = [0.2  0  0.1  0 ]';
%
hb = [1    2  3  4 ];
bT = [0.0  1  0  0 ]';
%
ma = length(ha);
mb = length(hb);

%
bs = SX.sym('b',mb,1);
as = SX.sym('a',ma,1);

fs = SX.sym('f',1,1);
ts = SX.sym('t');
%
Fmax = 1;
Fmin = -1;
%%
thetafcn = @(x) (0.5+0.5*tanh(50*x));
minfcn = @(x,a) thetafcn(-x+a).*(x-a) + a;
maxfcn = @(x,a) thetafcn(+x-a).*(x-a) + a;
stafcn = @(x,xmin,xmax) maxfcn(minfcn(x,xmax),xmin);
signfcn = @(x) tanh(500*x);
%%
Xs = [as;bs];
%
sat_fs =  stafcn(fs,Fmin,Fmax);
sat_fs =  signfcn(fs);
sat_fs = fs;
%
dbs_fcn = @(m) sat_fs*cos((2*m-1).*ts);
dbs = arrayfun(@(i)dbs_fcn(i),hb,'UniformOutput',false);
dbs = [dbs{:}]';
%
das_fcn = @(m) sat_fs*sin((2*m-1).*ts);
das = arrayfun(@(i)das_fcn(i),ha,'UniformOutput',false);
das = [das{:}]';
%%
dynfcn = casadi.Function('f',{ts,Xs,fs},{ [das;dbs] });
%
tspan = linspace(0,pi,100);
idyn = ode(dynfcn,Xs,fs,tspan);
idyn.InitialCondition = zeros(ma+mb,1);
SetIntegrator(idyn,'RK4')
Control0 = ZerosControl(idyn);
%
FreeState = solve(idyn,Control0);

%
epsilon = 1e-4;
PathCost  = casadi.Function('L'  ,{ts,Xs,fs},{ epsilon*(sqrt(fs^2+1e-7))          });
FinalCost = casadi.Function('Psi',{Xs}      ,{ ((bT - bs)'*(bT - bs) + (aT - as)'*(aT - as)) });


% 
iocp = ocp(idyn,PathCost,FinalCost);
iocp.constraints.MaxControlValue = Fmax;
iocp.constraints.MinControlValue = Fmin;
%%
ControlGuess = -0*sin(5*tspan);
[OptControl ,OptState] = IpoptSolver(iocp,ControlGuess);
%[OptControl ,OptState] = ClassicalGradient(iocp,ControlGuess,'MaxIter',500,'LengthStep',1,'Tol',1e-6);
%[OptControl ,OptState] = ArmijoGradient(iocp,ControlGuess,'MaxIter',1000);
%%
%OptControl = signfcn(OptControl);
%%

OptState = full(solve(idyn,OptControl));
Result.OptControl =OptControl;
Result.OptState = OptState;
Result.tspan = tspan;

Result.mb = mb;
Result.ma = ma;
Result.Vdc = 1;

plotResults(Result)

%%
%print('../docs/D0001-CalculusOfVariationIntro/fig/img03.eps','-depsc')
figure(1)

clf
for i = 1:9
    subplot(3,3,i)
    hold 
    plot(OptControl.*cos((2*i-1)*tspan),'--','LineWidth',2) 
    plot(cos((2*i-1)*tspan)) 
    plot(OptControl) 
    legend({'Fcos','Cos','F'})
end

%
figure(2)
clf
for i = 1:9
    subplot(3,3,i)
    hold 
    plot(OptControl.*sin((2*i-1)*tspan),'--','LineWidth',2) 
    plot(sin((2*i-1)*tspan)) 
    plot(OptControl) 
    legend({'Fcos','Cos','F'})
end

