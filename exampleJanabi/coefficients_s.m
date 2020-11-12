% Coefficients s_i in the algebraic equations (20) - reference to Janabi's 
% paper 

function s = coefficients_s(b,Vdc)

[lMa,n] = size(b);

% The i-th row of the matrix s contains the n coefficients s_i
% corresponding to the i-th value of the modulation index

s = zeros(lMa,n);
for i = 1:lMa
    s(i,:) = coeffSHE(b(i,:),Vdc);
end