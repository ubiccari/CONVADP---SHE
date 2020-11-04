% Coefficients of the n-th Chebyshev polynomial

function c = ChebPoly(n)

PolyOrder = 1:2:2*n-1;
L = length(PolyOrder);
C = zeros(L+1,L+1);

C(1,end) = 1;
C(2,end-1) = 1;

for i = 3:L+1
    aux = 2*circshift(C(i-1,:),-1);
    C(i,:) = aux-C(i-2,:);
end

c = C(end,:);


    