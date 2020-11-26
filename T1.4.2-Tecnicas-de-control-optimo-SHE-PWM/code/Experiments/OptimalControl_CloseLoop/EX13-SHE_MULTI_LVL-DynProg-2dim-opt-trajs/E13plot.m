function   E13plot(harmonics,ValueF,Nt,tspan,W,b,x_opts,fopts,bvalues)

%% Take a values of modulation index 

%% Create Solver

N1 = 80;
N2 = 70;
bT1_span = linspace(-1.5,1.5,N1);
bT2_span = linspace(-1.5,1.5,N2);
%
[bT1_ms,bT2_ms] = meshgrid(bT1_span,bT2_span);
%


%%
V = zeros(N1,N2,Nt);

[nn,~] = size(W);
clf
hold on
% for ii = 1:nn
%     jplot(ii) = plot( [W(ii,2).*b(ii,1) W(ii,2).*b(ii,1)+W(ii,1)  W(ii,2).*b(ii,1)-W(ii,1)], ...
%                       [W(ii,1).*b(ii,1) W(ii,1).*b(ii,1)-W(ii,2)  W(ii,1).*b(ii,1)+W(ii,2)] ,'y-','LineWidth',1.25);
% end


%%
for it = 1:Nt
    for i = 1:N1
        for j = 1:N2
                bnn = [bT1_span(i) bT2_span(j)];
                V(i,j,it) = ValueF(it,bnn);
        end
    end
end
%%
%mymap = jet(10);
subplot(1,2,1)
isurf = surf(bT1_ms,bT2_ms,V(:,:,1)');
colormap jet
zlim([-3 3])
caxis([0 1e-3])

view(0,-90)
xlabel("\beta_{"+harmonics(1)+"}","FontSize",18)
ylabel("\beta_{"+harmonics(2)+"}","FontSize",18)
%ic = colorbar;
%set(ic,'YTick',[-1 1])
%colormap(mymap)
shading interp

ititle = title('');
daspect([1 1 1])
hold on; 
ylim([-1 1])
xlim([-1 1])
%iplot = plot( W(:,2).*b(:,1)  , W(:,1).*b(:,1) ,'Color','c','Marker','.','LineStyle','none','MarkerSize',14);
%%

[~,~,ndata] = size(x_opts);
%npoints =  1:25:floor(ndata/2);
npoints =  1:5:ndata;

col = hsv(length(npoints));

x_opts = x_opts(:,end,:) - x_opts;
idataiter = 0;
for idata = npoints
    idataiter = idataiter + 1;
    plot(x_opts(1,:,idata),x_opts(2,:,idata),'k','LineWidth',1.0,'color',0.5+0.5*col(idataiter,:))
end

idataiter = 0;
for idata = npoints
    idataiter = idataiter + 1;
    rplot(idataiter) =     plot(x_opts(1,1,idata),x_opts(1,2,idata),'k','MarkerSize',30,'color',col(idataiter,:),'Marker','.');
end

subplot(1,2,2)
hold on 
surf(tspan,bvalues,fopts);

idataiter = 0;
for idata = npoints
    idataiter = idataiter + 1;
    yline(bvalues(idata),'color',col(idataiter,:),'LineWidth',2);
    gplot(idataiter) = plot3(0,bvalues(idata),-2,'color',col(idataiter,:),'Marker','.','MarkerSize',30);
end

shading interp

view(90,-90)



for it = 1:(Nt)
    isurf.ZData = V(:,:,it)';
    ititle.String = "V_t(\beta_{"+harmonics(1)+"},\beta_{"+harmonics(2)+"}) | t = "+num2str(tspan(it)/pi,'%.2f')+"\pi";

 
    idataiter = 0;
    for idata = npoints
        idataiter = idataiter + 1;
        rplot(idataiter).XData =  x_opts(1,it,idata);
        rplot(idataiter).YData =  x_opts(2,it,idata);
        %
        gplot(idataiter).XData = tspan(it);
    end


    pause(0.02)

end



 