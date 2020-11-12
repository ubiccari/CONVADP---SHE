function [S,dynfcn] = BuildSolverE03(bT,harmonics,Nt)
import casadi.*

abs = @(x) sqrt((x+1e-3)^2);

mb = length(bT);

bs = SX.sym('b',mb,1);
Xs = [bs]; 

fs = SX.sym('f',1,1); ts = SX.sym('t');

dbs = (2/pi)*fs*sin(harmonics.*ts);

dynfcn = Function('f',{ts,Xs,fs},{ [dbs] });

%%
T = pi/2;
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

end

