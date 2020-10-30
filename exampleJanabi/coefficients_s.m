function s = coefficients_s(n,lMa,b1,Vdc)

sFun = @(n,b) 0.5*(1 + pi*b/(4^n*Vdc)*nchoosek(2*n-1,n-1));
nIndex = 1:1:n;

s = zeros(lMa,n);
for i = 1:n
    s(:,i) = sFun(nIndex(i),b1);
end