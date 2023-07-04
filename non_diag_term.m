function val=non_diag_term(a,b,A)
[n,~]=size(A);
val=0;
for i=1:n
    if (A(i,1)==a)
        if (A(i,2)==b)
            val=val-A(i,4);
        end
    end
    if(A(i,1)==b)
        if (A(i,2)==a)
            val=val-A(i,4);
        end
    end
end
end