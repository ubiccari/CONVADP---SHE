function v = coefficients_v(s)

[lMa,n] = size(s);

v = zeros(lMa,2*n);
for l = 1:n
    v(:,2*l-1) = -(2/(2*l-1))*s(:,l);
end
