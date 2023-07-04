function sum =diag_term(node,A)
[n,~]=size(A);
sum=0;
for j=1:2
    for i=1:n
        if A(i,j)== node
            sum=sum+A(i,4);
        end
    end
end