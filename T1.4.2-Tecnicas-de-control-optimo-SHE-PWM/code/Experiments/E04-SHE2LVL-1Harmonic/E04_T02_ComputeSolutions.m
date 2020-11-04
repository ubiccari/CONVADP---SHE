import casadi.*

clear all;
%% Take a values of modulation index 
pathdir = "/home/djoroya/Documentos/Software/GitHub/external/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/anglesEX01/S_1" ;
filename = '2lshe5A_1_Format2L.h';

data = fcn_ReadTrunkSHE('TWOLVL',pathdir);
IdxMod = linspace(data.maMin,data.maMax,data.NumData);
    
bvalues = IdxMod/sqrt(3);

%% Create Solver

harmonics = [1]';
bT = [0 ]';
Nt = 50;
T = pi/2;
tspan = linspace(0,T,Nt);
dt = tspan(2) - tspan(1);

mb = length(bT);
[S,dynfcn] = BuildSolverE04(bT,harmonics,Nt);
%%

fopts = zeros(length(bvalues),Nt-1);

u0 = zeros(1,Nt-1);
plots = true;

for i = 1:length(bvalues)

bT = [bvalues(i)]';

lbg = [-ones(1,Nt-1),bT'];
ubg = [+ones(1,Nt-1),bT'];


r = S('x0',[u0(:);bT(:)], 'lbg',lbg,'ubg',ubg);
  

u_opt = r.x;

u_opt = reshape(full(u_opt(1:(Nt-1))),1,Nt-1);
%u_opt = sign(u_opt);

fopts(i,:) = u_opt;
%
X_opt = zeros(mb,Nt);
%X_opt(:,1) = [1;1];
for it = 2:Nt
   X_opt(:,it)  =  full(X_opt(:,it-1) +  dt*(dynfcn(tspan(it-1),X_opt(:,it-1),u_opt(:,it-1))));
end
%
if plots 
    subplot(1,2,1)
    
    %plot(u_opt');
    plot([u_opt' u0'])
    title('u')
    subplot(1,2,2)
    plot(X_opt');
    title('x')
    pause(0.1)
end

fprintf("=================== iter ====================== :"+i+"/"+length(bvalues)+"\n")
u0 = u_opt;

end

%%
save('data/EX04/SurfaceFs','fopts','Nt')