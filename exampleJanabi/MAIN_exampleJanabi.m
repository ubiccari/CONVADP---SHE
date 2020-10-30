clear all



[data,Ma,n] = format2mat_revised('./SHE_2L_4A_TercerHarmEliminado/angles/S_1/2lshe4A_1_Format2L.h');

lMa = length(Ma);
Vdc = 1;
b1 = Vdc*Ma;

sFun = @(n,b) 0.5*(1 + pi*b/(4^n*Vdc)*nchoosek(2*n-1,n-1));
nIndex = 1:1:n;

s = coefficients_s(n,lMa,b1,Vdc);

v = coefficients_v(s);

gExt = coefficients_g(v);

g = gExt(:,2:end);

alpha = zeros(lMa,n);

for i = 1:lMa
    [gMatrix,gVector] = constructionMatrix_G(g(i,:));           
    pVector = gMatrix\gVector;
    pVectorExt = [1 pVector'];
    r = sort(roots(pVectorExt),'descend');
    for j = 1:n
        alpha(i,j) = acos((-1)^j*r(j));
        if alpha(i,j) > 0.5*pi
           alpha(i,j) = abs(alpha(i,j)-pi);
        end
    end
    alpha(i,:) = sort(alpha(i,:));
end





