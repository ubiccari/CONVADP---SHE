clear 

%% Extraemos las formas de onda para las soluciones S_1, S_2, S_3, S_4

harmonics = [1 5 7 11 13]';

Na = 0;

Nb = length(harmonics);
Nt = 499;


for j=1:1
    name_folder = ['/home/djoroya/Documentos/Software/GitHub/external/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/anglesEX02/S_',num2str(j)];
    name_file = '/2lshe5A_1_Format2L.h';
    %
    [data,IdxMod,nangles]  = format2mat(fullfile(name_folder,name_file));

    tspan = linspace(0,pi/2,Nt);
    %
    sol(j).fvalues = zeros(length(IdxMod),Nt);
    sol(j).bn = zeros(length(IdxMod),Nb);

    for i = 1:length(IdxMod)
        alphas = data(i,:);
        sol(j).fvalues(i,:) = angles2fspan(alphas,tspan);
        [~,sol(j).bn(i,:)] = f2anbn(sol(j).fvalues(i,:),tspan,Na,harmonics);
    end
    sol(j).title = "S_"+j;
end
% solucion que nos da el control optimo
load('data/EX02/SurfaceFs.mat')

sol(2).fvalues = fopts;
sol(2).title  = "OC";
for i = 1:length(IdxMod)
    [~,sol(2).bn(i,:)] = f2anbn(fopts(i,:),tspan,Na,harmonics);
end
 
%% Ideal bn 

bvalues_exact = IdxMod/sqrt(3);
bvalues_exact = [bvalues_exact' zeros(117,Nb-1)];

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
    set(ic,'YTick',[-1 1])
    colormap(mymap)

end
%%
print('../docs/D0002-FullReport/img/EX01_surf_3LVL.eps','-depsc')

%%

figure('unit','norm','pos',[0 0 0.25 0.4])

for j=1:2
    

    subplot(2,2,j)
    
    sg = sign(sol(j).bn(1,1));

    switch sg
        case 1
            plot(  IdxMod,   sol(j).bn - bvalues_exact );
        case -1
            plot(  IdxMod,  -sol(j).bn - bvalues_exact );
    end

    xlabel('MI')
    ylabel('\Delta')
    if j==1
    legend([repmat('\Delta b_{',Nb,1), num2str(harmonics,'%.2d'),repmat('}',Nb,1)])
    end
    %ylim([-0.1 0.1])
    %
        title(sol(j).title)

    subplot(2,2,j+2)
    
    
    switch sg
        case 1
            plot(  IdxMod,  sum(( sol(j).bn - bvalues_exact).^2,2));
        case -1
            plot(  IdxMod,  sum((-sol(j).bn - bvalues_exact).^2,2));
    end

    xlabel('MI')
    ylabel('\Delta')
    
    if j==1
    legend('\Sigma_i \Delta b_{i}^2')
    end
end
%
print('../docs/D0002-FullReport/img/EX01_3LVL.eps','-depsc')

