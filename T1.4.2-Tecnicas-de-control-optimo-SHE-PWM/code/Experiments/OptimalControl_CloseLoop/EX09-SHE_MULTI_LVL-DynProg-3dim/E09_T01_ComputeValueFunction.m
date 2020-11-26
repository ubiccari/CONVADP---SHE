
clear all;
%% Take a values of modulation index 

%% Create Solver

harmonics = [1 3 5]';
N1 = 150;
N2 = 150;
N3 = 150;

bT1_span = linspace(-2,2,N1);
bT2_span = linspace(-2,2,N2);
bT3_span = linspace(-2,2,N3);

%
[bT1_ms,bT2_ms,bT3_ms] = ndgrid(bT1_span,bT2_span,bT3_span);
%
Nf = 3;
f_span = linspace(-1,1,Nf);

Nt = 10;
T = pi/2;
tspan = linspace(0,T,Nt);
dt = tspan(2) - tspan(1);
%%
[bT1_ms_2,bT2_ms_2,bT3_ms_2,f_ms_2] = ndgrid(bT1_span,bT2_span,bT3_span,f_span);

F2_1 = @(t) bT1_ms_2 -dt*(4/pi)*sin(harmonics(1)*t).*f_ms_2;
F2_2 = @(t) bT2_ms_2 -dt*(4/pi)*sin(harmonics(2)*t).*f_ms_2;
F2_3 = @(t) bT3_ms_2 -dt*(4/pi)*sin(harmonics(3)*t).*f_ms_2;

%%
V = zeros(N1,N2,N3,Nt);
%
V(:,:,:,end) = 0.5*(bT1_ms.^2 + bT2_ms.^2 + bT3_ms.^2);

%V(V<1e-4) = 0;
for it = (Nt-1):-1:1
    
    bT1n_ms = F2_1(tspan(it));
    bT2n_ms = F2_2(tspan(it));
    bT3n_ms = F2_3(tspan(it));

    %
    bT1n_span = reshape(bT1n_ms(:,1,1,:),N1,Nf);
    bT2n_span = reshape(bT2n_ms(1,:,1,:),N2,Nf);
    bT3n_span = reshape(bT3n_ms(1,1,:,:),N3,Nf);

    [~,ind1] = min(abs(bT1n_span - reshape(bT1_span,1,1,N1)),[],3);
    [~,ind2] = min(abs(bT2n_span - reshape(bT2_span,1,1,N2)),[],3);
    [~,ind3] = min(abs(bT3n_span - reshape(bT3_span,1,1,N3)),[],3);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for ifs = 1:Nf
        ind1_fs = ind1(:,ifs);
        ind2_fs = ind2(:,ifs);
        ind3_fs = ind3(:,ifs);

        Vf{ifs}  = V(ind1_fs,ind2_fs,ind3_fs,it+1);
     
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    V(:,:,:,it) = min(cat(4,Vf{:}),[],4);

    fprintf("iter = "+num2str(Nt-it)+"\n")
end

%%
clf
max_error = 0.01;

lvls = 20+[0.1 1 10];
lvls = -0.2+linspace(0,1,100);



X_meshgrid = permute(bT1_ms,[2,1,3]);
Y_meshgrid = permute(bT2_ms,[2,1,3]);
Z_meshgrid = permute(bT3_ms,[2,1,3]);

for it = Nt:(-2):1
cla


Vper =  permute(V(:,:,:,it),[2,1,3]);
isosurface(X_meshgrid,Y_meshgrid,Z_meshgrid,Vper,0.001)

axis tight
camlight 
lighting gouraud

xlim([-5 5])
ylim([-5 5])
zlim([-5 5])

xlabel("\beta_{"+harmonics(1)+"}")
ylabel("\beta_{"+harmonics(2)+"}")
zlabel("\beta_{"+harmonics(3)+"}")

daspect([1 1 1])
colorbar
colormap jet
view(3)
grid on
title("t = "+num2str(tspan(it),'%.4f'))
pause(0.1)
end 

%%

bT_time = zeros(3,Nt);
bT_time(:,1)= [0.1;0.3;0.5];

bT_time(:,1)= [rand-0.5;rand-0.5;rand-0.5];

f_time = zeros(1,Nt-1);

indexs = 1:Nf;

F = @(t,f) -(4/pi)*sin(harmonics*t)*f;


for it = 2:(Nt)

   bTc = bT_time(:,it-1);
   for ifs = 1:Nf
        bTn = bTc + (2*dt)*F(tspan(it),f_span(ifs));
        %
        [~,ind1] = min(abs(bTn(1) - bT1_span));
        [~,ind2] = min(abs(bTn(2) - bT2_span));
        [~,ind3] = min(abs(bTn(3) - bT3_span));

        Va(ifs) = V(ind1,ind2,ind3,it);
   end
   
   [Va_min,ind_f] = min(Va);

   
   if sum(Va == Va_min) > 1 && it>2
       posibles_ind_f = indexs(Va == Va_min);
       w =randsample(2,1);
       switch 1
           case 1
                if ismember(f_time(it-2),f_span(posibles_ind_f))
                   ind_f = find(f_time(it-2) == f_span);
                else
                   ind_f = randsample(posibles_ind_f,1);
                end
           case 2
               %
               [vv,newposibles] = min(abs(f_time(it-2) - f_span(posibles_ind_f)));
               ind_f = posibles_ind_f(newposibles);
           case 3
               ind_f = randsample(posibles_ind_f,1);
       end
   end
    

   f_time(it-1)  = f_span(ind_f);
   bT_time(:,it) = bT_time(:,it-1) + dt*F(tspan(it),f_span(ind_f));
   
    
end

%
figure(2)
clf
% subplot(2,1,1)
% isurf = surf(bT1_ms,bT2_ms,V(:,:,1));
% zlim([-1 4])
% caxis([0 1e-3])
% view(0,-90)
% xlabel("\beta_{"+harmonics(1)+"}","FontSize",18)
% ylabel("\beta_{"+harmonics(2)+"}","FontSize",18)
% colorbar
% shading interp
% 
% hold on 
% iplot= plot3(bT_time(1,1),bT_time(2,1),-1,'Marker','.','MarkerSize',30,'Color','g');
% 
% ititle = title('');
% daspect([1 1 1])

subplot(2,2,3)
hold on 
plot(bT_time')
yline(0)
xplot= plot(1,bT_time(1,1),'Marker','.','MarkerSize',30,'Color','g');
yplot= plot(1,bT_time(2,1),'Marker','.','MarkerSize',30,'Color','g');
zplot= plot(1,bT_time(3,1),'Marker','.','MarkerSize',30,'Color','g');

subplot(2,2,4)
hold on
plot(tspan(1:end-1),f_time)
fplot = plot(1,f_time(1),'Marker','.','MarkerSize',30,'Color','g');

yline(0)
ylim([-2 2])

for it = 2:1:(Nt)

   %bTc = bT_time(:,it-1);
   %bT_time(:,it) = bT_time(:,it-1) + dt*F(tspan(it-1),f_time(it-1));
   
   %isurf.ZData = V(:,:,it);
   %ititle.String = "V_t(\beta_{"+harmonics(1)+"},\beta_{"+harmonics(2)+"}) | t = "+num2str(tspan(it)/pi,'%.2f')+"\pi";
   
   iplot.XData = bT_time(1,it); 
   iplot.YData = bT_time(2,it);
   iplot.YData = bT_time(3,it);

   xplot.XData = it;
   xplot.YData = bT_time(1,it);
  
   yplot.XData = it;
   yplot.YData = bT_time(2,it);

   zplot.XData = it;
   zplot.YData = bT_time(3,it);
   
   fplot.XData = tspan(it-1);
   fplot.YData = f_time(it-1);

   pause(0.01)
    
end
%%

