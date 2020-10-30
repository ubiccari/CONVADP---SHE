% Coefficients v_i in the polynomila V(x) - equation (14) in Janabi's paper 

function v = coefficients_v(s)

[lMa,n] = size(s);

% The i-th row of the matrix v contains the 2n coefficients v_i
% corresponding to the i-th value of the modulation index

v = zeros(lMa,2*n);
for l = 1:n
    v(:,2*l-1) = -(2/(2*l-1))*s(:,l);
end
