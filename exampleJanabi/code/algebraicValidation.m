function answ = algebraicValidation(p,g)

n = 0.5*length(g);
algebraicEq = zeros(1,n);

algebraicEq(1) = g(1) - 2*p(1);
algebraicEq(2) = g(2) - p(1)*g(1);
algebraicEq(3) = g(3) - p(1)*g(2) + p(2)*g(1) - 2*p(3); 
algebraicEq(4) = g(4) - p(1)*g(3) + p(2)*g(2) - p(3)*g(1);

answ = (norm(algebraicEq)<=1e-10);



