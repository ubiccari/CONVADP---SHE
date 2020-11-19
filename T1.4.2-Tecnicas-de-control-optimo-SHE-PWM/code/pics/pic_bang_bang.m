clf
xl = linspace(-2,2);

ax = plot(xl,-xl.^2,'LineWidth',2);
ax.Parent.FontSize = 15
hold on

plot(xl,xl,'LineWidth',2)
plot(xl,-xl,'LineWidth',2)

xlim([-2 2])
ylim([-2 2])

ylabel('$H^*(f)$','Interpreter','latex')
xlabel('$f$','Interpreter','latex')
yline(0)
xline(-1,'LineWidth',2)
xline(1,'LineWidth',2)
legend({'$\mathcal{L}[f] = -f^2$','$\mathcal{L}[f] = +f$','$\mathcal{L}[f] = -f$'},'Interpreter','latex')


print('../docs/D0002-FullReport/img/bang-bang.eps','-depsc')
print('../docs/S0001-Resumen-19-11-2020/imgs/bang-bang.eps','-depsc')
