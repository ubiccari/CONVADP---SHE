function [gMatrix,gVector] = constructionMatrix_G(g)

n = 0.5*length(g);
gMatrix = zeros(n,n);
for i = n:-1:1
    gMatrix(:,n+1-i) = ((-1)^i)*g(i:n+i-1)';
end

gVector = g(n+1:end)';