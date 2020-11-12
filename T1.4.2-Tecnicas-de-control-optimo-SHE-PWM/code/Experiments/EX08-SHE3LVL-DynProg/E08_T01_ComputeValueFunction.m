
clear all;
%% Take a values of modulation index 

%% Create Solver

harmonics = [1 3]';
N1 = 500;
N2 = 500;
bT1_span = linspace(-1,1,N1);
bT2_span = linspace(-1,1,N2);
%
[bT1_ms,bT2_ms] = meshgrid(bT1_span,bT2_span);
%
f_span = [-1,1,0];

Nt = 80;
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

%V(V<1e-4) = 0;
for it = (Nt-1):-1:1
    
    bT1n_ms = F2_1(tspan(it));
    bT2n_ms = F2_2(tspan(it));
    %
    [~,ind1_ms] = min(abs(bT1n_ms - reshape(bT1_span,N1,1,1)),[],1);
    [~,ind2_ms] = min(abs(bT2n_ms - reshape(bT2_span,1,N2,1)),[],2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ind1_ms_minus = reshape(ind1_ms(:,:,1),N1,1);
    ind2_ms_minus = reshape(ind2_ms(:,:,1),N2,1);
    
    Vminus  = V(ind1_ms_minus,ind2_ms_minus,it+1);
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ind1_ms_plus = reshape(ind1_ms(:,:,2),N1,1);
    ind2_ms_plus = reshape(ind2_ms(:,:,2),N2,1);

    Vplus  = V(ind1_ms_plus,ind2_ms_plus,it+1);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ind1_ms_zero = reshape(ind1_ms(:,:,3),N1,1);
    ind2_ms_zero = reshape(ind2_ms(:,:,3),N2,1);

    Vzero  = V(ind1_ms_zero,ind2_ms_zero,it+1);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    V(:,:,it) = min(cat(3,Vminus,Vplus,Vzero),[],3);

end

%V(V< 1e-) = 0;
%%
clf
isurf = surf(bT1_ms,bT2_ms,V(:,:,1));
zlim([-1 1])
caxis([0 1e-3])

view(0,-90)
xlabel("\beta_{"+harmonics(1)+"}","FontSize",18)
ylabel("\beta_{"+harmonics(2)+"}","FontSize",18)
colorbar
shading interp

ititle = title('');
daspect([1 1 1])
for it = (Nt):-2:1
    isurf.ZData = V(:,:,it);
    ititle.String = "V_t(\beta_{"+harmonics(1)+"},\beta_{"+harmonics(2)+"}) | t = "+num2str(tspan(it)/pi,'%.2f')+"\pi";
    pause(0.1)
end
%%
% clf
% isurf = surf(bT1_ms,bT2_ms,V(:,:,1));
% zlim([-1 1])
% caxis([0 1e-3])
% view(0,-90)
% xlabel("\beta_{"+harmonics(1)+"}","FontSize",18)
% ylabel("\beta_{"+harmonics(2)+"}","FontSize",18)
% colorbar
% shading interp
% 
% ititle = title('');
% daspect([1 1 1])
% for it = 1:Nt
%     isurf.ZData = V(:,:,it);
%     ititle.String = "V_t(\beta_{"+harmonics(1)+"},\beta_{"+harmonics(2)+"}) | t = "+num2str(tspan(it)/pi,'%.2f')+"\pi";
%     pause(0.1)
% end
%%


bT_time = zeros(2,Nt);
bT_time(:,1)= [0.1;0.3];

f_time = zeros(1,Nt-1);

indexs = 1:3;

F = @(t,f) -(2/pi)*sin(harmonics*t)*f;


for it = 2:(Nt)

   bTc = bT_time(:,it-1);
   for ifs = 1:3
        bTn = bTc + (2*dt)*F(tspan(it),f_span(ifs));
        %
        [~,ind1] = min(abs(bTn(1) - bT1_span));
        [~,ind2] = min(abs(bTn(2) - bT2_span));

        Va(ifs) = V(ind1,ind2,it);
   end
   [Va_min,ind_f] = min(Va);
%    
%    if  sum(Va) ~= 0
%           [~,ind1c] = min(abs(bTc(1) - bT1_span));
%     [~,ind2c] = min(abs(bTc(2) - bT2_span));
% 
%        Va
%       V((ind1c-2):ind1c+2,(ind2c-2):ind2c+2,it)
%      
%    end
   Va_min
   if sum(Va == Va_min) > 1 && it>2
       posibles_ind_f = indexs(Va == Va_min);
       if false
            if ismember(f_time(it-2),f_span(posibles_ind_f))
               ind_f = find(f_time(it-2) == f_span);
            else
               ind_f = randsample(posibles_ind_f,1);
            end
       else
           %ind_f = randsample(posibles_ind_f,1);
           [~,newposibles] = min(abs(f_time(it-2) - f_span(posibles_ind_f)));
           ind_f = posibles_ind_f(newposibles);
       end
   end
    
  
   f_time(it-1)  = f_span(ind_f);
   bT_time(:,it) = bT_time(:,it-1) + dt*F(tspan(it),f_span(ind_f));
    
end

%%
figure(2)
clf
subplot(2,1,1)
isurf = surf(bT1_ms,bT2_ms,V(:,:,1));
zlim([-1 1])
caxis([0 1e-3])
view(0,-90)
xlabel("\beta_{"+harmonics(1)+"}","FontSize",18)
ylabel("\beta_{"+harmonics(2)+"}","FontSize",18)
colorbar
shading interp

hold on 
iplot= plot3(bT_time(1,1),bT_time(2,1),-1,'Marker','.','MarkerSize',30,'Color','g');

ititle = title('');
daspect([1 1 1])

subplot(2,2,3)
hold on 
plot(bT_time')
yline(0)

subplot(2,2,4)
hold on
plot(tspan(1:end-1),f_time)
yline(0)
ylim([-2 2])

for it = 2:(Nt)

   bTc = bT_time(:,it-1);
   bT_time(:,it) = bT_time(:,it-1) + dt*F(tspan(it-1),f_time(it-1));
   
   isurf.ZData = V(:,:,it);
   ititle.String = "V_t(\beta_{"+harmonics(1)+"},\beta_{"+harmonics(2)+"}) | t = "+num2str(tspan(it)/pi,'%.2f')+"\pi";
   
   iplot.XData = bT_time(1,it); 
   iplot.YData = bT_time(2,it);

   pause(0.01)
    
end
%%

