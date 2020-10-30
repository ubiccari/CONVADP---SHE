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
f = @(x) 1-x.^0.45 + 0.1*sin(13*pi*x)+0.2;
%
xl = linspace(0.1,1.1,n+2);

clf
xlim([-0.1 1.2])
ylim([-0.1 1.2])
xline(0)
yline(0)
hold on
plot(xl(1),f(xl(1)),'Marker','o','MarkerSize',15,'Color','b')
plot(xl(end),f(xl(end)),'Marker','o','MarkerSize',15,'Color','b')

plot(xl,f(xl),'Marker','.','LineStyle','none','Color','k','MarkerSize',30)
% - 
for i = 1:n+2
    plot([xl(i) xl(i)],[f(xl(i)) 0],'Marker','.','LineStyle','-','Color','r','MarkerSize',30)
    
end
% --
for i = 1:n+1
    plot([xl(i) xl(i+1)],[f(xl(i)) f(xl(i+1))],'Marker','.','LineStyle','--','Color','k','MarkerSize',30)
end
for i = 2:n+1
    plot([xl(i)],[f(xl(i))],'Marker','.','LineStyle','--','Color','r','MarkerSize',30)
end

%
for i = 1:n
    text(xl(i+1)+0.01,0.5*f(xl(i+1)) ,"y_"+i,'Color','r')
end

text(xl(1)+0.01,0.5*f(xl(1)) ,"y_"+0,'Color','k')
text(xl(end)+0.01,0.5*f(xl(end)) ,"y_"+(i+1),'Color','k')

%
xticks([xl])
xticklabels("x_"+(0:n+1))
yticks([])

print('../docs/D0001-CalculusOfVariationIntro/fig/img01.eps','-depsc')