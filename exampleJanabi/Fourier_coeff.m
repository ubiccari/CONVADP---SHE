function b = Fourier_coeff(alpha,Vdc)

[lMa,n] = size(alpha);
b = zeros(lMa,n);

A = alphaSum(alpha);

for i = 1:lMa
    for k = 1:n
        b(i,k) = -(4*Vdc)/(k*pi)*(1+A(i));
    end
end

b = b';


