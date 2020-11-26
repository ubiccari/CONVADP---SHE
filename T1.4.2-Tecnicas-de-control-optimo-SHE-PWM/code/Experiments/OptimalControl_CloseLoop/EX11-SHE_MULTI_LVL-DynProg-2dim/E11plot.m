function   E11plot(harmonics,ValueF,Nt,tspan)

N1 = 50;
N2 = 50;
N3 = 50;

bT1_span = linspace(-2,2,N1);
bT2_span = linspace(-2,2,N2);
bT3_span = linspace(-2,2,N3);

V = zeros(N1,N2,N3,Nt);

for it = 1:Nt
for i = 1:N1
    for j = 1:N2
        for k = 1:N3
            bnn = [bT1_span(i) bT1_span(j) bT1_span(k)];
            V(i,j,k,it) = ValueF(it,bnn);
        end
    end
end
end
%
[bT1_ms,bT2_ms,bT3_ms] = ndgrid(bT1_span,bT2_span,bT3_span);
%
Nf = 2;
f_span = linspace(-1,1,Nf);


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

xlim([-1 1])
ylim([-1 1])
zlim([-1 1])

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


end

