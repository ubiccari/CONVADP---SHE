function   E12plot(harmonics,ValueF,Nt,tspan)

%% Take a values of modulation index 

%% Create Solver

N1 = 100;
N2 = 100;
bT1_span = linspace(-1,1,N1);
bT2_span = linspace(-1,1,N2);
%
[bT1_ms,bT2_ms] = meshgrid(bT1_span,bT2_span);
%
f_span = [-1,1,0];


%%
V = zeros(N1,N2,Nt);

for it = 1:Nt
for i = 1:N1
    for j = 1:N2
            bnn = [bT1_span(i) bT1_span(j)];
            V(i,j,it) = ValueF(it,bnn);
    end
end
end
%%
clf
isurf = surf(bT1_ms,bT2_ms,V(:,:,1));
zlim([-3 3])
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


 