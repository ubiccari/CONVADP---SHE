load('/Users/djoroya/Documents/GitHub/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/EX01/SurfaceFs_minus.mat')
fminus = fopts;
load('/Users/djoroya/Documents/GitHub/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/EX01/SurfaceFs_plus.mat')
fplus = fopts;
load('/Users/djoroya/Documents/GitHub/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/EX01/SurfaceFs_sq.mat')
fsq = fopts;

bvalues = linspace(-1,1,200);
tspan = linspace(0,pi/2,Nt);
harmonics = [1 5 7 11 13]';

figure(1)
clf
name = '$\mathcal{L}(f) = +f$';
pplot(fplus,tspan,bvalues,name)
figure(2)
clf
name = '$\mathcal{L}(f) = -f$';
pplot(fminus,tspan,bvalues,name)
figure(3)
clf
name = '$\mathcal{L}(f) = -f^2$';
pplot(fsq,tspan,bvalues,name)


function pplot(f,tspan,bvalues,name)
surf(tspan,bvalues,sign(f))
xlim([0 pi/2])
ylim([-1 1])
shading interp
title(name,'Interpreter','latex','FontSize',14)
view(90,-90)
colormap(parula(2))
colorbar
xlabel('$f(\tau)$','Interpreter','latex','FontSize',14)
ylabel('$b_1$','Interpreter','latex','FontSize',14)
end
