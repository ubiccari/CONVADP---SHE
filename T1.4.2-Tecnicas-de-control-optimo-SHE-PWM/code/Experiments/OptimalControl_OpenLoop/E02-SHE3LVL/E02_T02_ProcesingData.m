clear 

load('data/EX02/SurfaceFs_minus.mat')
fopts_minus = fopts;
load('data/EX02/SurfaceFs_plus.mat')
fopts_plus = fopts;
load('data/EX02/SurfaceFs_sq.mat')
fopts_sq = fopts;
%% Extraemos las formas de onda para las soluciones S_1, S_2, S_3, S_4

harmonics = [1 5 7 11 13]';

Na = 0;

Nb = length(harmonics);

pathdir = "/home/djoroya/Documentos/Software/GitHub/external/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/anglesEX02/S_1" ;
pathdir = "/Users/djoroya/Documents/GitHub/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/anglesEX02/S_1" ;

filename = '2lshe5A_1_Format2L.h';

data = fcn_ReadTrunkSHE('TWOLVL',pathdir);
IdxMod = linspace(data.maMin,data.maMax,data.NumData);
bvalues = 2*IdxMod/sqrt(3);
bvalues = linspace(0,1,100);
IdxMod = bvalues;
bvalues_exact = [bvalues' zeros(100,4)] ;
%%
data.NumData = 100;
Nt = Nt - 1;
tspan = linspace(0,pi/2,Nt);
%
sol.fvalues = zeros(data.NumData,Nt);
sol.bn = zeros(data.NumData,Nb);


% solucion que nos da el control optimo

fopts = {fopts_minus,fopts_plus,fopts_sq};
names = {'OC-','OC+','OC^2'}
for j = 1:3
    sol(j).fvalues = fopts{j};
    sol(j).title  = names{j};

    for i = 1:100
        [~,sol(j).bn(i,:)] = f2anbn(fopts{j}(i,:),tspan,Na,harmonics);
    end
end

 

%% Ideal bn 


%%

figure('unit','norm','pos',[0 0 0.7 0.4])
clf

mymap = [0 0 1
    0 1 0];

for j=1:3
    
    subplot(1,3,j);
    surf(tspan,IdxMod,sol(j).fvalues);
    view(90,-90);shading interp
    xlabel('f(\tau)')
    ylabel('m_a')
    xticks([0 pi/4 pi/2])
    xticklabels({'0','\pi/4','\pi/2'})
    xlim([0 pi/2])
    ylim([IdxMod(1),IdxMod(end)])
    %
    title(sol(j).title)
    ic = colorbar;
    set(ic,'YTick',[0 1])
    colormap(mymap)

end
%%
print('../docs/D0002-FullReport/img/EX01_surf_3LVL.eps','-depsc')

%%
clear error
figure('unit','norm','pos',[0 0 0.3 0.3])

for j=1:3
    
    error(:,j) = sum(( sol(j).bn - bvalues_exact).^2,2)

end

plot(  IdxMod, error ,'LineWidth',1.25);

    xlabel('m_a')
    
    title('$\Sigma_j ||\beta_{j}(T)- b_j^T||^2$','Interpreter','latex')
    legend(sol.title)
    
%
print('../docs/D0002-OptimalControlOpenLoop/img/EX01_3LVL.eps','-depsc')

%%
