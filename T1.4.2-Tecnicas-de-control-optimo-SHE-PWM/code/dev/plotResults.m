function  plotResults(Result)

OptState = Result.OptState;
OptControl = Result.OptControl;
tspan = Result.tspan;
ma = Result.ma;
mb = Result.mb;

subplot(2,3,1);
plot(tspan,OptState(1:(ma),:)');
title('a_n(\tau)')
xticks([0 pi/2 pi])
xticklabels({'0','\pi/2','\pi'})
yticks([0 1])
yline(1)
ylim([-0.5 1.2])
yline(0)
yline(1)
xlabel('\tau')
legend("a_"+(1:ma)','Location','northeastoutside')
%
subplot(2,3,4);
plot(tspan,OptState((ma+1):end,:)');
title('b_n(\tau)')
xticks([0 pi/2 pi])
xticklabels({'0','\pi/2','\pi'})
ylim([-0.5 1.2])
yline(1)
yline(0)
xlabel('\tau')
legend("b_"+(1:mb)','Location','northeastoutside')
%%%
subplot(1,3,2);
plot(tspan,OptControl,'.-')
title('f(\tau)')
xlabel('\tau')
xticks([0 pi/2 pi])
xticklabels({'0','\pi/2','\pi'})
ylim([-1.5 1.5])
yticks([-1 1])
%yticklabels({'F_{min}','F_{max}'})
%
an = @(f,n) (2/pi)*trapz(tspan,cos((2*n-1)*tspan).*f);
bn = @(f,n) (2/pi)*trapz(tspan,sin((2*n-1)*tspan).*f);

subplot(2,3,3)
bar(arrayfun(@(n) an(OptControl,n),1:11))
title('a_n')
xticklabels([repmat('a_{',11,1),num2str((1:2:(2*11))'),repmat('}',11,1)])
ylim([-1 1.5])

subplot(2,3,6)
bar(arrayfun(@(n) bn(OptControl,n),1:11))
title('b_n')
xticklabels([repmat('b_{',11,1),num2str((1:2:(11*2))'),repmat('}',11,1)])
ylim([-1 1.5])


end

