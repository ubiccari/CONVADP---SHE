
clear all;
%% Take a values of modulation index 

%% Create Solver

harmonics = [5 7]';
N1 = 400;
N2 = 400;
bT1_span = linspace(-1,1,N1);
bT2_span = linspace(-1,1,N2);
%
[bT1_ms,bT2_ms] = meshgrid(bT1_span,bT2_span);
%
f_span = [-1,1];

Nt = 50;
T = pi/2;
tspan = linspace(0,T,Nt);
dt = tspan(2) - tspan(1);
%%
[bT1_ms_2,bT2_ms_2,f_ms_2] = meshgrid(bT1_span,bT2_span,f_span);

F2_1 = @(t) bT1_ms_2 -dt*(2/pi)*sin(harmonics(1)*t).*f_ms_2;
F2_2 = @(t) bT2_ms_2 -dt*(2/pi)*sin(harmonics(2)*t).*f_ms_2;

%%
V = zeros(N1,N2,Nt);
%
V(:,:,end) = 0.5*(bT1_ms.^2 + bT2_ms.^2)';


for it = (Nt-1):-1:1
    
    bT1n_ms = F2_1(tspan(it));
    bT2n_ms = F2_2(tspan(it));
    %
    [~,ind1_ms] = min(abs(bT1n_ms - reshape(bT1_span,N1,1,1)),[],1);
    [~,ind2_ms] = min(abs(bT2n_ms - reshape(bT2_span,1,N2,1)),[],2);
    %
    ind1_ms_minus = reshape(ind1_ms(:,:,1),N1,1);
    ind2_ms_minus = reshape(ind2_ms(:,:,1),N2,1);

    Vminus  = V(ind1_ms_minus,ind2_ms_minus,it+1);
   
    %
    ind1_ms_plus = reshape(ind1_ms(:,:,2),N1,1);
    ind2_ms_plus = reshape(ind2_ms(:,:,2),N2,1);

    Vplus  = V(ind1_ms_plus,ind2_ms_plus,it+1);

    V(:,:,it) = min(cat(3,Vminus,Vplus),[],3);

end

%%
clf
subplot(1,2,1)
isurf = surf(bT1_ms,bT2_ms,V(:,:,1));
zlim([-1 1])
caxis([0 1e-3])
view(0,90)
xlabel("\beta_{"+harmonics(1)+"}","FontSize",18)
ylabel("\beta_{"+harmonics(2)+"}","FontSize",18)
colorbar
shading interp

ititle = title('');
daspect([1 1 1])

subplot(1,2,2)

iplot = plot([0,1],[0,1],'LineStyle','-');
xlim([-2 2])
ylim([-2 2])
daspect([1 1 1])
for it = (Nt):-2:1
    isurf.ZData = V(:,:,it);
    ititle.String = "V_t(\beta_{"+harmonics(1)+"},\beta_{"+harmonics(2)+"}) | t = "+num2str(tspan(it)/pi,'%.2f')+"\pi";
    pause(0.2)
    
    iplot.XData(2) = sin(harmonics(1)*tspan(it));
    iplot.YData(2) = sin(harmonics(2)*tspan(it));

end

%%
bT_time = zeros(2,Nt);
bT_time(:,1)= [0.1;0.3];
f_time = zeros(1,Nt-1);

indexs = 1:2;

F = @(t,f) -(2/pi)*sin(harmonics*t)*f;

for it = 2:Nt

   bTc = bT_time(:,it-1);
   for ifs = 1:2
        bTn = bTc + dt*F(tspan(it),f_span(ifs));
        %
        [~,ind1] = min(abs(bTn(1) - bT1_span));
        [~,ind2] = min(abs(bTn(2) - bT2_span));

        Va(ifs) = V(ind1,ind2,it);
   end
   [Va_max,ind_f] = min(Va);

   if sum(Va == Va_max) > 1 && it>2
       if true
            if f_time(it-2) == -1
                ind_f = 1;
            else
                ind_f = 2;
            end
            
       else
           ind_f = randsample(indexs(Va == Va_max),1);
       end
   end

   
   f_time(it-1)  = f_span(ind_f);
   bT_time(:,it) = bT_time(:,it-1) + dt*F(tspan(it),f_span(ind_f));
end

clf
subplot(2,1,1)
hold on 
plot(bT_time')
yline(0)

subplot(2,1,2)
hold on
plot(tspan(1:end-1),f_time)
yline(0)
ylim([-2 2])

%%

clf
isurf = surf(bT1_ms,bT2_ms,V(:,:,1));
zlim([-1 1])
caxis([0 1e-3])
view(0,90)
xlabel("\beta_{"+harmonics(1)+"}","FontSize",18)
ylabel("\beta_{"+harmonics(2)+"}","FontSize",18)
colorbar
shading interp

ititle = title('');
daspect([1 1 1])

bT_time = zeros(2,Nt);
bT_time(:,1)= [0.5;0.3];
hold on 
iplot= plot3(bT_time(1,1),bT_time(2,1),1,'Marker','.','MarkerSize',30,'Color','g');
f_time = zeros(1,Nt-1);

indexs = 1:3;

F = @(t,f) -(2/pi)*sin(harmonics*t)*f;

for it = 2:Nt

   bTc = bT_time(:,it-1);
   for ifs = 1:2
        bTn = bTc + dt*F(tspan(it),f_span(ifs));
        %
        [~,ind1] = min(abs(bTn(1) - bT1_span));
        [~,ind2] = min(abs(bTn(2) - bT2_span));

        Va(ifs) = V(ind1,ind2,it);
   end
   [Va_min,ind_f] = min(Va);

   if sum(Va == Va_min) > 1 && it>2
       posibles_ind_f = indexs(Va == Va_min);
       if true
            if ismember(f_time(it-2),f_span(posibles_ind_f))
               ind_f = find(f_time(it-2) == f_span);
            else
               ind_f = randsample(posibles_ind_f,1);
            end
       else
           ind_f = randsample(posibles_ind_f,1);
       end
   end
    
   

   f_time(it-1)  = f_span(ind_f);
   bT_time(:,it) = bT_time(:,it-1) + dt*F(tspan(it),f_span(ind_f));
   
   isurf.ZData = V(:,:,it);
   ititle.String = "V_t(\beta_{"+harmonics(1)+"},\beta_{"+harmonics(2)+"}) | t = "+num2str(tspan(it)/pi,'%.2f')+"\pi";
   
   iplot.XData = bT_time(1,it); 
   iplot.YData = bT_time(2,it);

   pause(0.01)
    
end
