clear all;close all
import casadi.*


xs = SX.sym('x',3,1);
us = SX.sym('u',1,1);
ts = SX.sym('t');

%
harmonic = [1 5 7 11 13];

A = [-1   0.5  0.1;
      0.5  -1.0  0.5;
      0.1 0.5 -1.0];
  
dynfcn = Function('f',{ts,xs,us},{ A*xs + [0;0;1].*us });
%
%%
tspan = linspace(0,30,100);
idyn = ode(dynfcn,xs,us,tspan);
idyn.InitialCondition = [1 1 1]' ;
SetIntegrator(idyn,'RK4')
Control0 = ZerosControl(idyn);

FreeState = solve(idyn,Control0);
FreeState = full(FreeState);
%
epsilon = 1e-3;

P = [1 0 0;
     0 1 0];
 
xtp = 0.5*[1;1];
xt = 0.5*[1;1;1];
%PathCost  = Function('L'  ,{ts,xs,us},{ (P*xs-xtp)'*(P*xs-xtp)           });
PathCost  = Function('L'  ,{ts,xs,us},{ (xs-xt)'*(xs-xt)           });

FinalCost = Function('Psi',{xs}      ,{ 0  });

iocp = ocp(idyn,PathCost,FinalCost,'SymCalculations',false);

ControlGuess = ZerosControl(idyn);
[OptControl ,OptState] = IpoptSolver(iocp,ControlGuess);

%%
clf 
subplot(2,1,1)
plot3(FreeState(1,:),FreeState(2,:),FreeState(3,:))
hold on 
plot3(xt(1),xt(2),xt(3),'Marker','o')
grid on 
title('Free')
subplot(2,1,2)
plot3(OptState(1,:),OptState(2,:),OptState(3,:))
hold on 
plot3(xt(1),xt(2),xt(3),'Marker','o')
grid on
title('Opt')


