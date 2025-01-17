%%
% SHE via Chebyshev polynomials - quarter wave symmetry
% 
% modulates the 1st harmonic and set the 3rd, 5th and 7th to zero.
%
% REFERENCE: Janabi et al. - Generalized Chudnovsky algorithm for real-time
% PWM Selective Harmonic Elimination/Modulation: two-level VSI example

clear all

[data,Ma,n] = format2mat_revised('./SHE_2L_4A_TercerHarmControlado/angles/S_1/2lshe4A_1_Format2L.h');


% data: data from the table of Tecnalia
% Ma: modulation indices
% n: number of switching angles

lMa = length(Ma);  
Vdc = 1;                            % DC-link voltage
b1 = [Vdc*Ma;0.05*ones(1,lMa)];     % first and third Fourier coefficient 
b = zeros(lMa,n);
for i = 1:lMa
    b(i,1:size(b1,1)) = b1(:,i)';
end

harmonics = [1 3 5 7];

[alpha,val] = AnglesSHE(b,Vdc);

tspan = linspace(0,0.5*pi,5000);

[bFun,Fvalues] = computeFourier(alpha,harmonics,tspan);

error = (bFun-b).^2;

%%
close all

figure(1)
subplot(4,1,1)
plot(Ma,error(:,1),'LineWidth',1.5,'Color',[1 0 0])
xlim([Ma(1) Ma(lMa)])
xticks([Ma(1) 0.53 Ma(end)])

set(gca,'TickLabelInterpreter', 'latex');
xticklabels({'0.01','$m_a$','1.12'})
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
xlim([Ma(1) Ma(lMa)])
xticks([Ma(1) 0.53 Ma(end)])

set(gca,'TickLabelInterpreter', 'latex');
xticklabels({'0.01','$m_a$','1.12'})
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
xlim([Ma(1) Ma(lMa)])
xticks([Ma(1) 0.53 Ma(end)])

set(gca,'TickLabelInterpreter', 'latex');
xticklabels({'0.01','$m_a$','1.12'})
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
xlim([Ma(1) Ma(lMa)])
xticks([Ma(1) 0.53 Ma(end)])

set(gca,'TickLabelInterpreter', 'latex');
xticklabels({'0.01','$m_a$','1.12'})
Xt4 = get(gca,'XTickLabel');
set(gca,'XTickLabel',Xt4,'fontsize',14);

%ylim([-0.5e-5,3e-5])

Leg7 = legend('$e_7 = \|b_7-b_7^T\|^2$');
set(Leg7,'Interpreter','latex');
Leg7.FontSize = 20;
Leg7.Location = 'northeastoutside';
Leg7.Box = 'off';

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.9, 0.8])
print('errorModulation','-dpng','-r500')

%%
close all

figure(2)

mymap = [0 0 1; 0 1 0];

sg = sign(mean(bFun(:,1)));

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

yticks([Ma(1) 0.53 Ma(end)])

yticklabels({'0.01','$m_a$','1.05'})
Yt = get(gca,'YTickLabel');
set(gca,'YTickLabel',Yt,'fontsize',20);

xlim([0 pi/2])
ylim([Ma(1),Ma(end)])
ic = colorbar;
set(ic,'YTick',[-1 1],'TickLabelInterpreter','latex')
colormap(mymap)

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.9, 0.8])
print('anglesModulation','-dpng','-r500')

