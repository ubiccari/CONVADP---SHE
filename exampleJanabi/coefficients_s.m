% Coefficients s_i in the algebraic equations (20) - reference to Janabi's 
% paper 

function s = coefficients_s(n,lMa,b1,Vdc)

b = zeros(1,n);
B = size(b1,1);
% The i-th row of the matrix s contains the n coefficients s_i
% corresponding to the i-th value of the modulation index

s = zeros(lMa,n);
for i = 1:lMa
    for j = 1:B
        b(j) = b1(j,i);
    end
    s(i,:) = coeffSHE(b,Vdc);
end