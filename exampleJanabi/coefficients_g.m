function g = coefficients_g(v)

[lMa,n] = size(v);

g = zeros(lMa,n+1);
g(:,1) = 1;
for l = 2:n+1
    G = 0;
    for k = 1:l-1
        G = G + (k/(l-1))*v(:,k).*g(:,l-k);
    end
    g(:,l) = G;
end
