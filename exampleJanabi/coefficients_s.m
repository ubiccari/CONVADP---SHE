% Coefficients s_i in the algebraic equations (20) - reference to Janabi's 
% paper 

function s = coefficients_s(n,lMa,b1,Vdc)


sFun = @(n,b) 0.5*(1 + pi*b/(4^n*Vdc)*nchoosek(2*n-1,n-1)); 
% sFun gives the coefficients s_i when all the harmonics except b1 are set to zero

nIndex = 1:1:n;

% The i-th row of the matrix s contains the n coefficients s_i
% corresponding to the i-th value of the modulation index

s = zeros(lMa,n);
for i = 1:n
    s(:,i) = sFun(nIndex(i),b1);
end