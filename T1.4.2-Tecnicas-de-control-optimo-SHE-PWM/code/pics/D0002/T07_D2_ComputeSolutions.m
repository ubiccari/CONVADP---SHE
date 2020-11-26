import casadi.*

clear all;

%% Take bn for modulation index
bvalues = linspace(-0.5,+0.5,100);
avalues = linspace(-0.5,+0.5,100);

%%
Nt =300;
Lterms = {@(f) +f   };
Lnames = {'OCP-plus'};

aharmonics = {[1,3,5]};
bharmonics = {[1,5,7,9]};

jter = 0;
for ih = aharmonics'
    jter = jter +1;

    bmatrix = zeros(length(bvalues),length(bharmonics{jter}));
    bmatrix(:,1) = bvalues;
    bmatrix(:,2) = bvalues;

    amatrix = zeros(length(avalues),length(ih{:}));
    amatrix(:,1) = avalues;
    
    iter = 0;
    fconstraints = [-1,1];
    for Lterm = Lterms
        iter = iter + 1;
        [S,ftraj] = SHE2OCP_2SYM(ih{:}',bharmonics{jter}',Lterm{:},Nt);
        [fopts,x_opt] = SolveOCP_2SYM_range(amatrix,bmatrix,S,ftraj,Nt,fconstraints);
        ylabelstring = '$b_1 = b_3 = a_1$';
        titlestring = "{ "+num2str(ih{:})+" } | "+Lnames{iter};
        figure
        plotRes_2SYM(ih{:}',bharmonics{jter}',amatrix,bmatrix,bvalues,fopts,ylabelstring,titlestring)
        path = replace(replace(replace(titlestring,'  ','-'),'}',''),'{','');
        path = replace(path,' ','')+"-"+Lnames{iter};
        pathdata = "pics/S0006/data/"+path;
        path = "pics/S0006/imgs/"+path+'.png';


    end
end
%%
%%
figure(1)
clf
mymap = [0 0 1
    0 1 0];

tspan = linspace(0,pi,Nt)
surf(tspan,bvalues,fopts);
    ic = colorbar;
    set(ic,'YTick',[-1 1])
    colormap(mymap)
title('$\mathcal{L}(f) = +f$','Interpreter','latex','FontSize',21)
    view(90,-90);shading interp
xlabel('$f(\tau)$','FontSize',21,'Interpreter','latex')
ylabel('$b_1 = b_5 = a_1$','Interpreter','latex','FontSize',21)
xticks([0 pi/2 pi])
xticklabels({'0','\pi/2','\pi'})
xlim([0  pi])
ylim([bvalues(1),bvalues(end)])

print('../docs/D0002-OptimalControlOpenLoop/img/alphabeta.eps','-depsc')
    %
    %%
figure(2)
clf
    [an,bn] = f2anbn_2SYM(fopts,tspan,ih{:}',bharmonics{jter}');
    err =sum(  (amatrix - an).^2,2) +sum((bmatrix - bn).^2,2);

    plot(bvalues,err,'LineWidth',1.5)
    title('$\Delta = || a_T - \alpha||^2 + || b_T - \beta||^2$','Interpreter','latex','FontSize',18)
    xlabel(ylabelstring,'Interpreter','latex','FontSize',18)
print('../docs/D0002-OptimalControlOpenLoop/img/alphabeta_error.eps','-depsc')
