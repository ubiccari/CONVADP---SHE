function b = targetCoefficients(Vdc,Ma,n,b3)

lMa = length(Ma);
b1 = [Vdc*Ma;b3*ones(1,lMa)];     % first and third Fourier coefficient 
b = zeros(lMa,n);
for i = 1:lMa
    b(i,1:size(b1,1)) = b1(:,i)';
end
