import casadi.*

clear all;

%% Take bn for modulation index
pathdir = "/home/djoroya/Documentos/Software/GitHub/external/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/anglesEX01/S_1" ;
filename = '2lshe5A_1_Format2L.h';

data = fcn_ReadTrunkSHE('TWOLVL',pathdir);
IdxMod = linspace(data.maMin,data.maMax,data.NumData);
    
bvalues = IdxMod/sqrt(3);

%% Dynamics Definition 

harmonics = [1 5 7 11 13]';
bT = [0 0 0 0 0]';

abs = @(x) sqrt((x+1e-3)^2);

mb = length(bT);

bs = SX.sym('b',mb,1);
Xs = [bs]; 

fs = SX.sym('f',1,1); ts = SX.sym('t');

dbs = (2/pi)*fs*sin(harmonics.*ts);

dynfcn = Function('f',{ts,Xs,fs},{ [dbs] });

%%
T = pi/2;
Nt = 400;
tspan = linspace(0,T,Nt);
dt = tspan(2) - tspan(1);
%%
fst = SX.sym('ft',[1 Nt-1]);
tst = SX.sym('ts',[1 Nt-1]);
%
Xend = zeros(mb,1);
for it = 2:Nt
   Xend  =  Xend +  dt*dynfcn(tspan(it-1),Xend,fst(:,it-1));
end

%%
alpha = 1e-5;

bTs = casadi.SX.sym('bT',size(bT));

nlp = struct( 'x' , [fst(:);bTs]           , ...
              'f' , (Xend - [bTs])'*(Xend-[bTs]) -   alpha*sum(sum(fst.* 2)), ...
              'g' , [fst(:);bTs]   );
          
opt = struct('ipopt',struct('print_level',0,'tol',1e-12));
S = nlpsol('S', 'ipopt', nlp,opt);

%%

fopts = zeros(length(bvalues),Nt-1);

u0 = zeros(1,Nt-1);
plots = false;

for i = 1:length(bvalues)

    bT = [bvalues(i) 0 0 0 0]';

    lbg = [-ones(size(fst)),bT'];
    ubg = [+ones(size(fst)),bT'];

    r = S('x0',[u0(:);bT(:)], 'lbg',lbg,'ubg',ubg);
    u_opt = r.x;
    u_opt = reshape(full(u_opt(1:(Nt-1))),1,Nt-1);
    
    fopts(i,:) = u_opt;
    %
    X_opt = zeros(mb,Nt);
    %X_opt(:,1) = [1;1];
    for it = 2:Nt
       X_opt(:,it)  =  full(X_opt(:,it-1) +  dt*(dynfcn(tspan(it-1),X_opt(:,it-1),u_opt(:,it-1))));
    end
    %
    if plots 
        subplot(1,2,1);plot(u_opt');title('u')
        subplot(1,2,2);plot(X_opt');title('x')
        pause(0.1)
    end

    fprintf("=================== iter ====================== :"+i+"/"+length(bvalues))
    u0 = u_opt;

end

%%
Nt = Nt -1 ;
save('data/EX01/SurfaceFs','fopts','Nt')