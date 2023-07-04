function [out,frequency]=AC_ckt_solve(A,S,gnd)

[r,~]=size(S);
d=0;
freq=unique(S(:,5));
s_ac=zeros(1,4);
k1=2;
k3=1;
s_ac_sup=zeros(1,4);
k4=1;
for i=1:length(freq)
    for j=1:r
        if freq(i)==S(j,5)
            s_val=S(j,4)*exp(1i*S(j,6)*(pi/180));
            s_ac(k3,1:4)=[S(j,1:3) s_val];
            k3=k3+1;
        else
            d=1;
            if S(j,3)==2
                s_ac_sup(k4,1:4)=[S(j,1:2) 0 1e-10];
                k4=k4+1;
            end
            if S(j,3)==3
                s_ac_sup(k4,1:4)=[S(j,1:2) 0 1e10];
                k4=k4+1;
            end
        end
    end
    if d==1
        A_temp=vertcat(A,s_ac,s_ac_sup);
    else
        A_temp=vertcat(A,s_ac);
    end
    
    if freq(i)==0
        temp1=real(Circuit_solver_ac(A_temp,gnd,1e-15));
        out(:,1)=temp1(:,1);
        out(:,k1)=real(temp1(:,2));
        k1=k1+1;
    else
        temp2=Circuit_solver_ac(A_temp,gnd,freq(i));
        out(:,1)=temp2(:,1);
        out(:,k1)=temp2(:,2);
        k1=k1+1;
        
    end
    s_ac=zeros(1,4);
    k3=1;
    s_ac_sup=zeros(1,4);
    k4=1;
end
frequency=freq';
end