% from point a to point b
%
fig = figure(1);
clf

ha = 10;
hb = 0;
%
% intermediate steps
n = 4;
%
f = @(x) 1-x.^0.45 + 0.1*sin(2.5*pi*x)+0.2;
%
xl = linspace(0.1,1.1,100);

clf
xlim([-0.1 1.2])
ylim([-0.1 1.2])
xline(0)
yline(0)
hold on
plot(xl(1),f(xl(1)),'Marker','o','MarkerSize',15,'Color','b')
plot(xl(end),f(xl(end)),'Marker','o','MarkerSize',15,'Color','b')

plot(xl,f(xl),'Marker','none','LineStyle','-','Color','k','MarkerSize',2)
% - 
for i = [1 100]
    plot([xl(i) xl(i)],[f(xl(i)) 0],'Marker','none','LineStyle','-','Color','r','MarkerSize',2)
    
end


%
text(xl(1)+0.01,0.5*f(xl(1)) ,"y_0",'Color','k')
text(xl(end)+0.01,0.5*f(xl(end)) ,"y_f",'Color','k')

text(xl(50)+0.01,1.1*f(xl(50)) ,"y(x)",'Color','k')


%
xticks([xl([1 100])])
xticklabels({"x_0","x_f"})
yticks([])

print('../docs/D0001-CalculusOfVariationIntro/fig/img02.eps','-depsc')