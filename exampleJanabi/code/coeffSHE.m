% Coefficients s_i in the algebraic equations (20) for a general target 
% vector b of Fourier coefficients - reference to Janabi's paper 

function S = coeffSHE(b,Vdc)

n = length(b);
s = 0.5 + (pi*b(1)/(8*Vdc));
s = [0 s 0];

rhs = 0.5 + (1/(4*Vdc))*[1:2:2*n].*b;

j = 2;
for i = 3:2:2*n
    c = ChebPoly(i);
    aux = (rhs(j)-c(2:end)*s')/c(1);
    s = [0 aux s];
    j = j+1;
end

s = fliplr(double(s));
S = s(s~=0);




