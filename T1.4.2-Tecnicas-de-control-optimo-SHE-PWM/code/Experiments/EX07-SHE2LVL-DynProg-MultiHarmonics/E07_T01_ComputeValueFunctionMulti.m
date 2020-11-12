
clear all;
%% Take a values of modulation index 

%% Create Solver

harmonics = [1 3]';

Ns = [250;250;];
dim = length(Ns);
for iNs = 1:dim
    bT_span{iNs} = linspace(-1,1,Ns(iNs));
    bT_ms{iNs} = [];
    bT_ms_2{iNs} = [];
end

%%
[bT_ms{:}] = meshgrid(bT_span{:});
%
f_span = [-1,1];

Nt = 100;
T = pi/2;
tspan = linspace(0,T,Nt);
dt = tspan(2) - tspan(1);
%%
[bT_ms_2{:},f_ms_2] = meshgrid(bT_span{:},f_span);

for iNs = 1:dim
    F2{iNs} = @(t) bT_ms_2{iNs} -dt*(2/pi)*sin(harmonics(1)*t).*f_ms_2;
end

%%
NsCell = num2cell(Ns);

V = zeros(NsCell{:},Nt);
%
%V(:,:,end) = 0.5*(bT1_ms.^2 + bT2_ms.^2)';

Vstring = ['V(',repmat(':,',1,dim),'end)'];
eval([Vstring,'=0.5*bT_ms{1}.^2;'])

for id = 2:dim
    eval([Vstring,'=',Vstring,' + 0.5*bT_ms{',num2str(id),'}.^2;'])
end

for it = (Nt-1):-1:1
    
    for id = 1:dim
        bTn_ms{id} = F2{id}(tspan(it));
    end

    %
    [~,ind1_ms] = min(abs(bTn_ms{1} - reshape(bT_span{1},Ns(1),1,1)),[],1);
    [~,ind2_ms] = min(abs(bTn_ms{2} - reshape(bT_span{2},1,Ns(2),1)),[],2);
    %
    ind1_ms_minus = reshape(ind1_ms(:,:,1),Ns(1),1);
    ind2_ms_minus = reshape(ind2_ms(:,:,1),Ns(2),1);

    Vminus  = V(ind1_ms_minus,ind2_ms_minus,it+1);
   
    %
    ind1_ms_plus = reshape(ind1_ms(:,:,2),Ns(1),1);
    ind2_ms_plus = reshape(ind2_ms(:,:,2),Ns(2),1);

    Vplus  = V(ind1_ms_plus,ind2_ms_plus,it+1);

    V(:,:,it) = min(cat(3,Vminus,Vplus),[],3);

end

%%
clf
isurf = surf(bT_ms{1},bT_ms{2},V(:,:,1));
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
bT_time = zeros(2,Nt);
bT_time(:,1)= [0.3;0.3];
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