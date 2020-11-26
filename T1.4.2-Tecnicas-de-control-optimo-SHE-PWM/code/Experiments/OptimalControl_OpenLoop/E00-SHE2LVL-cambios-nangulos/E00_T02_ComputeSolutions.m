import casadi.*

clear all;
harmonics = [1 3 9 13 17]';
%harmonics = [1 3 5 7]';

%% Take bn for modulation index
pathdir = "/Users/djoroya/Documents/GitHub/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/anglesEX01/S_1" ;

filename = '2lshe5A_1_Format2L.h';

data = fcn_ReadTrunkSHE('TWOLVL',pathdir);
IdxMod = linspace(data.maMin,data.maMax,data.NumData);
%%

bvalues = linspace(-1,1,200);

bmatrix = zeros(length(bvalues),length(harmonics));
bmatrix(:,1) = bvalues;
%%
Nt = 300;
Lterms = {@(f) (f)};
%Lterms = {@(f) f.^2.*cos(7*pi*f)};

names = {'SurfaceFs_plus','SurfaceFs_minus','SurfaceFs_sq'};
iter = 0;
fconstraints = [-1,1];
for Lterm = Lterms
    iter = iter + 1;
    [S,ftraj] = SHE2OCP_4SYM(harmonics,Lterm{:},Nt);
    fopts = SolveOCP_4SYM_range(bmatrix,S,ftraj,Nt,fconstraints);
    %save("data/EX00/"+names{iter},'fopts','Nt')
    ylabelstring = '$\beta_1 = \beta_2$';
    figure(iter)
    ts = 'sol';
    plotRes_4SYM(harmonics,bmatrix,bvalues,fopts,ylabelstring,ts)
end
%%
%ylabelstring = '$\beta_1 = \beta_2$';
%plotRes_4SYM(harmonics,bmatrix,bvalues,fopts,Nt,ylabelstring)
%%
