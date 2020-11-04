function p = coefficients_p(g)

% Compute the coefficients of the polynomial P(x) - equation (8) in
% Janabi's paper

lMa = length(g);
for i = 1:lMa
    [gMatrix,gVector] = constructionMatrix_G(g);          
    p = gMatrix\gVector;
end
