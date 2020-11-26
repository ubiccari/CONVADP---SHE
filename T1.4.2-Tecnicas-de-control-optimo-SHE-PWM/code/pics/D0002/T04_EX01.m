import casadi.*

clear all;
harmonics = [1 5]';

bvalues = linspace(-0.4,0.4,9);

bmatrix = zeros(length(bvalues),length(harmonics));
bmatrix(:,1) = bvalues;
%%
Nt = 200;
Lterms = {@(f) +f};
%Lterms = {@(f) f.^2.*cos(7*pi*f)};

names = {'SurfaceFs_plus','SurfaceFs_minus','SurfaceFs_sq'};
iter = 0;
fconstraints = [-1,1];
for Lterm = Lterms
    iter = iter + 1;
    [S,ftraj] = SHE2OCP_4SYM(harmonics,Lterm{:},Nt);
    fopts{iter} = SolveOCP_4SYM_range(bmatrix,S,ftraj,Nt,fconstraints);
end

%%
tspan = linspace(0,pi/2,Nt);
color = cool(9)

iter = 1;
figure(1)
clf
for i = 1:9
    subplot(3,3,i)
    plot(tspan,sign(fopts{iter}(i,:)'),'color',color(i,:),'LineWidth',1.2)
    box
    yline(0)
    ylim([-1.5 1.5])
    ylabel("f(\tau)")
    xlabel("\tau")
    xticks([0 pi/4 pi/2])
    xticklabels({'0','\pi/4','\pi/2'})
    title("$b_1 = "+num2str(bvalues(i),'%.2f')+'$','Interpreter','latex')
end

print('../docs/D0002-OptimalControlOpenLoop/img/ex01-dyn.eps','-depsc')

figure(2)
clf
hold on


for i = 1:9
    subplot(3,3,i)
    hold on
    xlim([-0.8 0.8])
    ylim([-0.6 0.6])
    daspect([1 1 1])
    itraj = ftraj(fopts{iter}(i,:));
    itraj = full(itraj)';
    plot(0,0,'k','MarkerSize',15,'Marker','.')
    plot(itraj(:,1),itraj(:,2),'color',color(i,:),'LineWidth',1.2);
    plot(itraj(end,1),itraj(end,2),'color','r','Marker','.','MarkerSize',15);
    title("$b_1 = "+num2str(bvalues(i),'%.2f')+'$','Interpreter','latex')
    box
    xline(0);yline(0)
    xlabel('\beta_1')
    ylabel('\beta_5')

end

print('../docs/D0002-OptimalControlOpenLoop/img/ex01-con.eps','-depsc')
