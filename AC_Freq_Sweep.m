function out =AC_Freq_Sweep(A,S,gnd,freq,a2,b2)
r=length(freq);
gain=zeros(1,r);
phase=zeros(1,r);
s_ac=zeros(1,4);
v1=0;
v2=0;
for k=1:r
    s_val=S(1,4)*exp(1i*S(1,6)*(pi/180));
    s_ac(1,1:4)=[S(1,1:3) s_val];
    A_temp=vertcat(A,s_ac);
    sol=Circuit_solver_ac(A_temp,gnd,freq(k));
    [b,~]=size(sol);
    for m=1:b
        if sol(m,1)== a2
            v1=sol(m,2);
        end
        if sol(m,1)== b2
            v2=sol(m,2);
        end
    end

    gain(k)=abs(v1-v2)/abs(s_val);
    phase(k)=angle(v1-v2);
    
end
h1=subplot(2,1,1);
h2=h1.Position;
set(h1,'Position',[.08+h2(1) h2(2) h2(3) h2(4)]);
semilogx(freq,20*log10(gain));
grid on;
grid minor;
xlabel('Frequency','FontSize',12,'FontWeight','bold','Color','b');
ylabel(' dB(V_o/V_i) ','FontSize',12,'FontWeight','bold','Color','r');
title('Magnitude vs Frequency','FontSize',12,'FontWeight','bold','Color','k');
h1=subplot(2,1,2);
h2=h1.Position;
set(h1,'Position',[.08+h2(1) h2(2) h2(3) h2(4)]);
semilogx(freq,(180/pi)*phase);
grid on;
grid minor;
xlabel('Frequency','FontSize',12,'FontWeight','bold','Color','b');
ylabel(' P(V_o/V_i) ','FontSize',12,'FontWeight','bold','Color','r');
title('Phase vs Frequency','FontSize',12,'FontWeight','bold','Color','k');
out=0;
end