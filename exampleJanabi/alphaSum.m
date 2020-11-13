function A = alphaSum(alpha)

[lMa,n] = size(alpha);

A = zeros(1,lMa);

for i = 1:lMa
    for j = 1:n
        A(i) = A(i) + 2*((-1)^j)*cos(j*alpha(i,j));
    end
end

        