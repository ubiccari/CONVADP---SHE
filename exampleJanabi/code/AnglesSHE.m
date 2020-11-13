%%
% SHE via Chebyshev polynomials - quarter wave symmetry
% 
% modulates the 1st harmonic and set the 3rd, 5th and 7th to zero.
%
% REFERENCE: Janabi et al. - Generalized Chudnovsky algorithm for real-time
% PWM Selective Harmonic Elimination/Modulation: two-level VSI example

function [alpha,val,Gdet,rootsPoly] = AnglesSHE(b,Vdc)

s = coefficients_s(b,Vdc);          % Coefficients s_i in the algebraic 
                                    % equations (20) - reference to
                                    % Janabi's paper
                                    
v = coefficients_v(s);              % Coefficients of the polynomial V(x) 
                                    % equation (14) in Janabi's paper

                                    
gExt = coefficients_g(v);           % Coefficients of the polynomial G(x) 
                                    % equation (13) in Janabi's paper


[lMa,n] = size(b);

g = gExt(:,2:end);
alpha = zeros(lMa,n);
rootsPoly = zeros(lMa,n);
val = zeros(1,lMa);
pVector = zeros(lMa,n);
Gdet = zeros(1,lMa);

% Computation of the switching angles: the i-th row of the matrix alpha
% contains the n switching angles corresponding to the i-th value of the
% modulation index

for i = 1:lMa
 
    % Compute the coefficients of the polynomial P(x) - equation (8) in
    % Janabi's paper
    
    [pVectorAux,detG] = coefficients_p(g(i,:));
    pVector(i,:) = pVectorAux;
    Gdet(i) = detG;
    pVectorExt = [1 pVectorAux'];
    r = sort(roots(pVectorExt),'descend');  % The solutions of the 
                                            % algebraic equations are the
                                            % roots of P(x)
    rootsPoly(i,:) = r';
    val(i) = algebraicValidation(pVector,g(i,:)); 
    
    % Compute the switching angles
    
    for j = 1:n
        alpha(i,j) = acos((-1)^j*r(j));
        if alpha(i,j) > 0.5*pi
           alpha(i,j) = abs(alpha(i,j)-pi);  % Projection on (0,pi/2)
        end
    end
    alpha(i,:) = sort(alpha(i,:));
end