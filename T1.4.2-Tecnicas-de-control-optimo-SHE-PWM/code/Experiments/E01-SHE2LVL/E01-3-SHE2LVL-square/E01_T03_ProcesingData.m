clear 
load('data/EX01/SurfaceFs_square.mat')

%% Extraemos las formas de onda para las soluciones S_1, S_2, S_3, S_4

harmonics = [1 5 7 11 13]';

Na = 0;

Nb = length(harmonics);


for j=1:3
    pathdir = "/Users/djoroya/Documents/GitHub/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/anglesEX01/S_"+j ;
    filename = '2lshe5A_1_Format2L.h';

    data = fcn_ReadTrunkSHE('TWOLVL',pathdir);
    IdxMod = linspace(data.maMin,data.maMax,data.NumData);
    nangles = data.NumAngs;

    tspan = linspace(0,pi/2,Nt);
    %
    sol(j).fvalues = zeros(length(IdxMod),Nt);
    sol(j).bn = zeros(length(IdxMod),Nb);

    for i = 1:length(IdxMod)
        alphas = data.table(i,:);
        sol(j).fvalues(i,:) = angles2fspan(alphas,tspan);
        [~,sol(j).bn(i,:)] = f2anbn(sol(j).fvalues(i,:),tspan,Na,harmonics);
    end
    sol(j).title = "Solution S_"+j;
end
% solucion que nos da el control optimo

sol(4).fvalues = fopts;
sol(4).title  = "Solution OC";
for i = 1:length(IdxMod)
    [~,sol(4).bn(i,:)] = f2anbn(fopts(i,:),tspan,Na,harmonics);
end
 
%% Ideal bn 

bvalues_exact = 2*IdxMod/sqrt(3);
bvalues_exact = [bvalues_exact' zeros(117,Nb-1)];

%%

figure('unit','norm','pos',[0 0 0.45 0.55])
clf

mymap = [0 0 1
    0 1 0];

for j=1:4
    
    
    subplot(2,2,j);
    
        sg = sign(mean(sol(j).bn(:,1)));

    switch sg
        case -1 
            surf(tspan,IdxMod,sol(j).fvalues);
        case 1
            surf(tspan,IdxMod,-sol(j).fvalues);

    end
    view(90,90);shading interp
    xlabel('$f(\tau)$','Interpreter','latex')
    ylabel('$m_a$','Interpreter','latex')
    xticks([0 pi/4 pi/2])
    xticklabels({'0','\pi/4','\pi/2'})
    xlim([0 pi/2])
    ylim([IdxMod(1),IdxMod(end)])
    %
    title(sol(j).title)
    ic = colorbar;
    set(ic,'YTick',[-1 1])
    colormap(mymap)

end
%%
print('../docs/D0002-FullReport/img/EX01_surf.eps','-depsc')

%%

figure('unit','norm','pos',[0 0 0.5 0.5])

for j=1:4
    

    subplot(2,4,j)
    
    sg = sign(mean(sol(j).bn(:,1)));

    switch sg
        case 1
            plot(  IdxMod,   sol(j).bn - bvalues_exact );
        case -1
            plot(  IdxMod,  -sol(j).bn - bvalues_exact );
    end

    xlabel('m_a')
    ylabel('\Delta')
    if j==1
    legend([repmat('\Delta b_{',Nb,1), num2str(harmonics,'%.2d'),repmat('}',Nb,1)])
    end
    %ylim([-0.1 0.1])
    %
        title(sol(j).title)

    subplot(2,4,j+4)
    
    
    switch sg
        case 1
            plot(  IdxMod,  sum(( sol(j).bn - bvalues_exact).^2,2));
        case -1
            plot(  IdxMod,  sum((-sol(j).bn - bvalues_exact).^2,2));
    end

    xlabel('m_a')
    ylabel('\Delta')
    
    if j==1
    legend('\Sigma_i \Delta b_{i}^2')
    end
end
%
print('../docs/D0002-FullReport/img/EX01.eps','-depsc')

