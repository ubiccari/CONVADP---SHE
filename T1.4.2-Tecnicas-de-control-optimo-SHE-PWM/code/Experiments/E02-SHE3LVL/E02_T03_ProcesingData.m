clear 
load('data/EX02/SurfaceFs.mat')

%% Extraemos las formas de onda para las soluciones S_1, S_2, S_3, S_4

harmonics = [1 5 7 11 13]';

Na = 0;

Nb = length(harmonics);

pathdir = "/home/djoroya/Documentos/Software/GitHub/external/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/anglesEX02/S_1" ;
filename = '2lshe5A_1_Format2L.h';

data = fcn_ReadTrunkSHE('TWOLVL',pathdir);
IdxMod = linspace(data.maMin,data.maMax,data.NumData);
bvalues = IdxMod/sqrt(3);
%%
Nt = Nt - 1;
tspan = linspace(0,pi/2,Nt);
%
sol.fvalues = zeros(data.NumData,Nt);
sol.bn = zeros(data.NumData,Nb);

for i = 1:data.NumData
    alphas = data.table(i,:);
    sol.fvalues(i,:) = angles2fspan3LVL(alphas,tspan);
    [~,sol.bn(i,:)] = f2anbn(sol.fvalues(i,:),tspan,Na,harmonics);
end
sol.title = "S_1";
    
% solucion que nos da el control optimo

sol(2).fvalues = fopts;
sol(2).title  = "OC";

for i = 1:data.NumData
    [~,sol(2).bn(i,:)] = f2anbn(fopts(i,:),tspan,Na,harmonics);
end
 
%% Ideal bn 

bvalues_exact = IdxMod/sqrt(3);

bvalues_exact = [bvalues_exact' zeros(data.NumData,Nb-1)];

%%

figure('unit','norm','pos',[0 0 0.5 0.35])
clf

mymap = [0 0 1
    0 1 0];

for j=1:2
    
    subplot(1,2,j);
    surf(tspan,IdxMod,sol(j).fvalues);
    view(0,90);shading interp
    xlabel('\alpha(\tau)')
    ylabel('MI')
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

figure('unit','norm','pos',[0 0 0.25 0.4])

for j=1:2
    

    subplot(2,2,j)

    plot(  IdxMod,   sol(j).bn - bvalues_exact );

    xlabel('MI')
    ylabel('\Delta')
    if j==1
    legend([repmat('\Delta b_{',Nb,1), num2str(harmonics,'%.2d'),repmat('}',Nb,1)])
    end
    %ylim([-0.1 0.1])
    %
    title(sol(j).title)

    subplot(2,2,j+2)
    

    plot(  IdxMod,  sum(( sol(j).bn - bvalues_exact).^2,2));

    xlabel('MI')
    ylabel('\Delta')
    
    if j==1
    legend('\Sigma_i \Delta b_{i}^2')
    end
end
%
print('../docs/D0002-FullReport/img/EX01_3LVL.eps','-depsc')

%%
