
maMin = results.maMin;
maMax = results.maMax;
Ma = results.modulation;
bNum = results.targetNumerical;
error = results.error;
Fvalues = results.function;

maMed = 0.5*(maMin+maMax);
tspan = linspace(0,0.5*pi,size(Fvalues,2));


%%
close all

figure(1)
subplot(4,1,1)
plot(Ma,error(:,1),'LineWidth',1.5,'Color',[1 0 0])
xlim([maMin maMax])
xticks([maMin maMed maMax])

set(gca,'TickLabelInterpreter', 'latex');
xticklabels({'0.01','$m_a$','1.05'})
Xt1 = get(gca,'XTickLabel');
set(gca,'XTickLabel',Xt1,'fontsize',14);

%ylim([-0.5e-5,2.5e-5])

Leg1 = legend('$e_1 = \|b_1-b_1^T\|^2$');
set(Leg1,'Interpreter','latex');
Leg1.FontSize = 20;
Leg1.Location = 'northeastoutside';
Leg1.Box = 'off';

subplot(4,1,2)
plot(Ma,error(:,2),'LineWidth',1.5,'Color',[0 1 0])
xlim([maMin maMax])
xticks([maMin maMed maMax])

set(gca,'TickLabelInterpreter', 'latex');
xticklabels({'0.01','$m_a$','1.05'})
Xt2 = get(gca,'XTickLabel');
set(gca,'XTickLabel',Xt2,'fontsize',14);

%ylim([-0.5e-5,2.5e-5])

Leg3 = legend('$e_3 = \|b_3-b_3^T\|^2$');
set(Leg3,'Interpreter','latex');
Leg3.FontSize = 20;
Leg3.Location = 'northeastoutside';
Leg3.Box = 'off';

subplot(4,1,3)
plot(Ma,error(:,3),'LineWidth',1.5,'Color',[0 0 1])
xlim([maMin maMax])
xticks([maMin maMed maMax])

set(gca,'TickLabelInterpreter', 'latex');
xticklabels({'0.01','$m_a$','1.05'})
Xt3 = get(gca,'XTickLabel');
set(gca,'XTickLabel',Xt3,'fontsize',14);

%ylim([-0.5e-5,4e-5])

Leg5 = legend('$e_5 = \|b_5-b_5^T\|^2$');
set(Leg5,'Interpreter','latex');
Leg5.FontSize = 20;
Leg5.Location = 'northeastoutside';
Leg5.Box = 'off';

subplot(4,1,4)
plot(Ma,error(:,4),'LineWidth',1.5,'Color',[1 0.5 0])
xlim([maMin maMax])
xticks([maMin maMed maMax])

set(gca,'TickLabelInterpreter', 'latex');
xticklabels({'0.01','$m_a$','1.05'})
Xt4 = get(gca,'XTickLabel');
set(gca,'XTickLabel',Xt4,'fontsize',14);

%ylim([-0.5e-5,3e-5])


Leg7 = legend('$e_7 = \|b_7-b_7^T\|^2$');
set(Leg7,'Interpreter','latex');
Leg7.FontSize = 20;
Leg7.Location = 'northeastoutside';
Leg7.Box = 'off';

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.9, 0.8])
%print('errorElimination','-dpng','-r500')

%%
figure(2)

mymap = [0 0 1; 0 1 0];

sg = sign(mean(bNum(:,1)));

switch sg
    case -1
        surf(tspan,Ma,Fvalues);
    case 1
        surf(tspan,Ma,-Fvalues);
end

view(90,90);
shading interp

xticks([0 pi/2-0.05])
xticklabels({'0','$\displaystyle\frac{\pi}{2}$'})
set(gca,'TickLabelInterpreter','latex');
Xt1 = get(gca,'XTickLabel');
set(gca,'XTickLabel',Xt1,'fontsize',20);

yticks([maMin maMed maMax])

yticklabels({'0.01','$m_a$','1.05'})
Yt = get(gca,'YTickLabel');
set(gca,'YTickLabel',Yt,'fontsize',20);

xlim([0 pi/2])
ylim([maMin,maMax])
ic = colorbar;
set(ic,'YTick',[-1 1],'TickLabelInterpreter','latex')
colormap(mymap)

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.9, 0.8])
%print('anglesElimination','-dpng','-r500')
