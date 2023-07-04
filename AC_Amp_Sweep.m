function out=AC_Amp_Sweep(A,S,gnd,amp,a2,b2)
out=0;
r=length(amp);
    voltage=zeros(1,r);
    v1=0;
    v2=0;
    s_ac=zeros(1,4);
    for k=1:r
        s_val=amp(k)*exp(1i*S(1,6)*(pi/180));
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
        voltage(k)=abs(v1-v2);
    end
    plot(amp,voltage);
    grid on;
grid minor;
xlabel('V_i','FontSize',12,'FontWeight','bold','Color','b');
ylabel('V_o','FontSize',12,'FontWeight','bold','Color','r');
title('V_o vs V_i','FontSize',12,'FontWeight','bold','Color','k');
end