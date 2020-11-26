clear 
load('data/EX05/SurfaceFs.mat')

%% Extraemos las formas de onda para las soluciones S_1, S_2, S_3, S_4

harmonics = [1]';

Na = 0;

Nb = length(harmonics);
Nt = Nt -1;

sol.fvalues = fopts;
sol.title  = "OC";
for i = 1:length(IdxMod)
    [~,sol.bn(i,:)] = f2anbn(fopts(i,:),tspan,Na,harmonics);
end
 


%% Ideal bn 

bvalues_exact = IdxMod/sqrt(3);
bvalues_exact = [bvalues_exact' zeros(117,Nb-1)];

%%

figure('unit','norm','pos',[0 0 0.5 0.35])
clf

mymap = [0 0 1
    0 1 0];

for j=1:5
    
    subplot(1,5,j);
    
        sg = sign(mean(sol(j).bn(:,1)));

    switch sg
        case -1 
            surf(tspan,IdxMod,sol(j).fvalues);
        case 1
            surf(tspan,IdxMod,-sol(j).fvalues);

    end
    view(90,90);shading interp
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
print('../docs/D0002-FullReport/img/EX01_surf.eps','-depsc')

%%

figure('unit','norm','pos',[0 0 0.25 0.4])

for j=1:5
    

    subplot(2,5,j)
    
    sg = sign(mean(sol(j).bn(:,1)));

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

    subplot(2,5,j+5)
    
    
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

