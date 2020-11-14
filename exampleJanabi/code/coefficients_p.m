function [p,detG] = coefficients_p(g)

% Compute the coefficients of the polynomial P(x) - equation (8) in
% Janabi's paper

[gMatrix,gVector] = constructionMatrix_G(g);          
p = gMatrix\gVector;
detG = det(gMatrix);

