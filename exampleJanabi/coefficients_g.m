% Coefficients g_i in the polynomila G(x) - equation (13) in Janabi's paper 

function g = coefficients_g(v)

[lMa,n] = size(v);

% The i-th row of the matrix g contains the 2n coefficients g_i
% corresponding to the i-th value of the modulation index

g = zeros(lMa,n+1);
g(:,1) = 1;
for l = 2:n+1
    G = 0;
    for k = 1:l-1
        G = G + (k/(l-1))*v(:,k).*g(:,l-k);
    end
    g(:,l) = G;
end
