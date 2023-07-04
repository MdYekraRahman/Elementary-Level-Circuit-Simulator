function out=non_sin(A,gnd)
out=0;
try
    def1=num2str(dlmread('Voltage Source or Current Source.txt'));
catch
    def1='';
end
try
    def2=num2str(dlmread('Input Node1.txt'));
catch
    def2='';
end
try
    def3=num2str(dlmread('Input Node2.txt'));
catch
    def3='';
end
try
    def4=num2str(dlmread('Output Node.txt'));
catch
    def4='';
end
try
    def5=num2str(dlmread('Number of Fourier Terms.txt'));
catch
    def5='';
end
try
    def6=num2str(dlmread('Period.txt'));
catch
    def6='';
end
try
    def7=num2str(dlmread('Number of Functions within Period.txt'));
catch
    def7='';
end
definput={def1,def2,def3,def4,def5,def6,def7};
prompt={'Voltage Source/Current Source','Input Node1','Input Node2','Output Node',...
    'Number of Fourier Terms','Period','Number of Functions within Period'};
inp=inputdlg(prompt,'Input',[1 50],definput);

if(~isempty(inp))
    if(~isempty(inp{1}))
        vc=str2num(inp{1});
        dlmwrite('Voltage Source or Current Source.txt',vc);
    end
    if(~isempty(inp{2}))
        node1=str2num(inp{2});
        dlmwrite('Input Node1.txt',node1);
    end
    if(~isempty(inp{3}))
        node2=str2num(inp{3});
        dlmwrite('Input Node2.txt',node2);
    end
    if(~isempty(inp{4}))
        out_node=str2num(inp{4});
        dlmwrite('Output Node.txt',out_node);
    end
    if(~isempty(inp{5}))
        n=str2num(inp{5});
        dlmwrite('Number of Fourier Terms.txt',n);
    end
    if(~isempty(inp{6}))
        period=str2num(inp{6});
        dlmwrite('Period.txt',period);
    end
    if(~isempty(inp{7}))
        nof=str2num(inp{7});
        dlmwrite('Number of Functions within Period.txt',nof);
    end
    
    vc=dlmread('Voltage Source or Current Source.txt');
    node1=dlmread('Input Node1.txt');
    node2=dlmread('Input Node2.txt');
    out_node=dlmread('Output Node.txt');
    n=dlmread('Number of Fourier Terms.txt');
    period=dlmread('Period.txt');
    nof=dlmread('Number of Functions within Period.txt');
    
    [a0,a,b]=coefficient(period,nof,n);
  
   
    
    A1=A;
    ground=gnd;
    [r,~]=size(A1);
    [~,~,non]=A_and_I(A1,ground);
    complete1=zeros(n,length(non));
    complete2=zeros(n,length(non));
    A2=A1;
    A1=[A1;zeros(1,4)];
    for i=1:n
        w=i*2*pi/period;
        for j=1:r
            if A1(j,3)==-1
                A1(j,4)=1/(1i*w*A2(j,4));
            elseif A1(j,3)==1
                A1(j,4)=1i*w*A2(j,4);
            end
        end
        temp1=[node1 node2 vc a(i)];
        A1(end,:)=temp1;
        v=circuit_solver(A1,ground);
        complete1(i,:)=v(:,2);
        
        temp2=[node1 node2 vc b(i)];
        A1(end,:)=temp2;
        v=circuit_solver(A1,ground);
        complete2(i,:)=v(:,2);
        
    end
    
    A3=[A;node1 node2 vc a0];
    dc_sol=real(Circuit_solver_ac(A3,ground,.0000001));
    
    out=find(non==out_node);
    t=0:period/100000:5*period;
    sum=dc_sol(out,2);
    mag_spec=zeros(1,n+1);
    mag_spec(1)=sum;
    
    for i=1:n
        sum=sum+abs(complete1(i,out))*cos((i*2*pi*t)/period+angle(complete1(i,out)))+abs(complete2(i,out))*sin((i*2*pi*t)/period+angle(complete2(i,out)));
        mag_spec(i+1)=abs(complete1(i,out)+complete2(i,out));
    end
    
    prmpt={'Show Output','Magnitude Spectrum of I/O'};
    ch=listdlg('SelectionMode','single','ListString',prmpt);
    
    if ch==1
        plot(t,sum);
        y_axis=['Voltage (Node'  num2str(out_node) ')' ];
        grid on;
        grid minor;
        xlabel('Time','FontSize',12,'FontWeight','bold','Color','b');
        ylabel(y_axis,'FontSize',12,'FontWeight','bold','Color','r');
        title('Node Voltage vs Time','FontSize',12,'FontWeight','bold','Color','k');
    elseif ch==2
        h1=subplot(2,1,1);
        h2=h1.Position;
        set(h1,'Position',[.08+h2(1) h2(2) h2(3) h2(4)]); 
        stem(0:n,abs([a0 a+b]));
        title('Magnitude Spectrum of Input Signal');
        h1=subplot(2,1,2);
        h2=h1.Position;
        set(h1,'Position',[.08+h2(1) h2(2) h2(3) h2(4)]);
        stem(0:n,mag_spec);
        title('Magnitude Spectrum of Output Signal');
    end
end
end
