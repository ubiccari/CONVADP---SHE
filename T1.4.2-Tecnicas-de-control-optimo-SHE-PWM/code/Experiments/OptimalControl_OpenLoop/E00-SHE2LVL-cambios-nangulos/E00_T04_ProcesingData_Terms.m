clear 


load('data/EX00/SurfaceFs_plus.mat')
fopts_plus = fopts;
harmonics = [1 3 9 13 17]';

%% Extraemos las formas de onda para las soluciones S_1, S_2, S_3, S_4


Na = 0;

Nb = length(harmonics);

pathdir = "/home/djoroya/Documentos/Software/GitHub/external/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/anglesEX02/S_1" ;
pathdir = "/Users/djoroya/Documents/GitHub/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/anglesEX02/S_1" ;

filename = '2lshe5A_1_Format2L.h';

data = fcn_ReadTrunkSHE('TWOLVL',pathdir);
IdxMod = linspace(data.maMin,data.maMax,data.NumData);
bvalues = 2*IdxMod/sqrt(3);
bvalues = linspace(-1,1,200);
IdxMod = bvalues;
bvalues_exact = [bvalues' zeros(200,4)] ;
%%
data.NumData = 200;
tspan = linspace(0,pi/2,Nt);
%
sol.fvalues = zeros(data.NumData,Nt);
sol.bn = zeros(data.NumData,Nb);


% solucion que nos da el control optimo

fopts = {fopts_plus};
names = {'$\mathcal{L}=+f$'};
for j = 1:1
    sol(j).fvalues = fopts{j};
    sol(j).title  = names{j};

    for i = 1:200
        [~,sol(j).bn(i,:)] = f2anbn(fopts{j}(i,:),tspan,Na,harmonics);
    end
end

 

%% Ideal bn 


%%

%figure('unit','norm','pos',[0 0 0.7 0.4])
figure
clf

mymap = [0 0 1
    0 1 0];


for j=1:1
    
    surf(tspan,IdxMod,(smoothdata(sign(sol(j).fvalues) ,'SmoothingFactor',0.3)));
    view(90,-90);shading interp
    xlabel('$f(\tau)$','FontSize',21,'Interpreter','latex')
    ylabel('$b_1$','Interpreter','latex','FontSize',21)
    xticks([0 pi/4 pi/2])
    xticklabels({'0','\pi/4','\pi/2'})
    xlim([0 pi/2])
    ylim([IdxMod(1),IdxMod(end)])
    %
    title(sol(j).title,'Interpreter','latex','FontSize',21)
    ic = colorbar;
    set(ic,'YTick',[0 1])
    colormap(mymap)

end
%%
print('../docs/D0002-OptimalControlOpenLoop/img/EX00_surf_2LVL.eps','-depsc')

%%
clear error
%figure('unit','norm','pos',[0 0 0.3 0.3])
figure
for j=1:1
    
    error(:,j) = sqrt(sum(( sol(j).bn - bvalues_exact).^2,2))

end

plot(  IdxMod, error ,'LineWidth',1.25);

    xlabel('$b_1$','FontSize',21,'Interpreter','latex')
    
    title('$\Sigma_j ||\beta_{j}(T)- b_j^T||$','Interpreter','latex','FontSize',21)
    
%
print('../docs/D0002-OptimalControlOpenLoop/img/EX00_2LVL.eps','-depsc')

%%
