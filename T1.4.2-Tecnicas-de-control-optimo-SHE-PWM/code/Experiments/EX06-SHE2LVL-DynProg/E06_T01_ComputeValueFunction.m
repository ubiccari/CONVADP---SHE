import casadi.*

clear all;
%% Take a values of modulation index 
pathdir = "/home/djoroya/Documentos/Software/GitHub/external/CONVADP---SHE/T1.4.2-Tecnicas-de-control-optimo-SHE-PWM/code/data/anglesEX01/S_1" ;
filename = '2lshe5A_1_Format2L.h';

data = fcn_ReadTrunkSHE('TWOLVL',pathdir);
IdxMod = linspace(data.maMin,data.maMax,data.NumData);
    
bvalues = IdxMod/sqrt(3);

%% Create Solver

harmonics = [1 5]';
N1 = 150;
N2 = 150;
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

V = zeros(N1,N2,Nt);
%
V(:,:,end) = 0.5*(bT1_ms.^2 + bT2_ms.^2)';

F = @(t,f) -(2/pi)*sin(harmonics*t)*f;

for it = (Nt-1):-1:1
    for ib1 = 1:N1
        for ib2 = 1:N2
           bTc = [bT1_span(ib1);bT2_span(ib2)];

           for ifs = 1:2
                bTn = bTc + dt*F(tspan(it),f_span(ifs));
                %
                [~,ind1] = min(abs(bTn(1) - bT1_span));
                [~,ind2] = min(abs(bTn(2) - bT2_span));

                Va(ifs) = V(ind1,ind2,it+1);
           end
           V(ib1,ib2,it) = min(Va);
%            surf(V(:,:,it))
%            pause(0.05)
       end
    end
end

%%
% clf
% isurf = surf(bT1_ms,bT2_ms,V(:,:,1));
% zlim([-1 1])
% shading interp
% for it = 1:Nt
%     isurf.ZData = V(:,:,it);
%     title(it)
%     pause(0.1)
% end

%%
bT_time = zeros(2,Nt);
bT_time(:,1)= [0.5;0.3];
f_time = zeros(1,Nt-1);

indexs = 1:2;

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
        if f_time(it-2) == -1
            ind_f = 1;
        else
            ind_f = 2;
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