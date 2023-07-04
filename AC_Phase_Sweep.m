function out =AC_Phase_Sweep(A,S,gnd,ph,a2,b2)
out=0;
r=length(ph);
phase=zeros(1,r);
v1=0;
v2=0;
s_ac=zeros(1,4);
for k=1:r
    s_val=S(1,4)*exp(1i*ph(k)*(pi/180));
    s_ac(1,1:4)=[S(1,1:3) s_val];
    A_temp=vertcat(A,s_ac);
    sol=Circuit_solver_ac(A_temp,gnd,S(1,5));
    [b,~]=size(sol);
    for m=1:b
        if sol(m,1)== a2
            v1=sol(m,2);
        end
        if sol(m,1)== b2
            v2=sol(m,2);
        end
    end
    phase(k)=angle(v1-v2);
end
plot((180/pi)*ph,(180/pi)*phase);
grid minor;
xlabel('Phase(V_i)','FontSize',10,'FontWeight','Bold','Color','b');
ylabel('Phase(V_o)','FontSize',10,'FontWeight','bold','Color','r');
title('Phase(V_o) vs Phase(V_i)','FontSize',10,'FontWeight','bold','Color','k');
end