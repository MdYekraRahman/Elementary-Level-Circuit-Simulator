function [power,r_th]=max_power(A,gnd)

A_1=A;
A_2=A;
maximum_power=0;
R_th=0;

try
    def=(dlmread('Max Power Transfer.txt'));
    def1=num2str(def(1));
    def2=num2str(def(2));
    def3=num2str(def(3));
catch
    def1=''; def2=''; def3='';
end
prompt1={'Node1','Node2','Value'};
title='Select Resistor';
definput={def1,def2,def3};
ans1=inputdlg(prompt1,title,[1 50],definput);
if isempty(ans1)==0
    if (~isempty(ans1{1}))
        node1=str2double(ans1{1});
        dlmwrite('Max Power Transfer.txt',node1);
    end
    if (~isempty(ans1{2}))
        node2=str2double(ans1{2});
        dlmwrite('Max Power Transfer.txt',node2,'-append');
    end
    if (~isempty(ans1{3}))
        val=str2double(ans1{3});
        dlmwrite('Max Power Transfer.txt',val,'-append');
    end
    max_pt=dlmread('Max Power Transfer.txt');
    node1=max_pt(1);
    node2=max_pt(2);
    val=max_pt(3);
    
    [r,~]=size(A);
    
    for i=1:r
        if A(i,3)==2
            A_1(i,3)=0;
            A_1(i,4)=.00000001;
        elseif A(i,3)==3
            A_1(i,3)=0;
            A_1(i,4)=10^6;
        end
    end
    
    for i=1:r
        if A(i,1)==node1 && A(i,2)==node2 && A(i,3)==0 && A(i,4)==val
            A_1(i,3)=3; A_1(i,4)=1;
            break;
        elseif A(i,2)==node1 && A(i,1)==node2 && A(i,3)==0 && A(i,4)==val
            A_1(i,3)=3; A_1(i,4)=1;
            break;
        end
    end
    
    solv=circuit_solver(A_1,gnd);
    [r1,~]=size(solv);
    if node1==gnd
        for i=1:r1
            if node2==solv(i,1)
                R_th=abs(solv(i,2));
                break;
            end
        end
    elseif node2==gnd
        for i=1:r1
            if node1==solv(i,1)
                R_th=abs(solv(i,2));
                break;
            end
        end
    else
        for i=1:r1
            if node1==solv(i,1)
                x1=solv(i,2);
                break;
            end
        end
        for i=1:r1
            if node2==solv(i,1)
                x2=solv(i,2);
                break;
            end
        end
        R_th=abs(x1-x2);
    end
    
    
    for i=1:r
        if A(i,1)==node1 && A(i,2)==node2 && A(i,3)==0 && A(i,4)==val
            A_2(i,4)=R_th;
            break;
        elseif A(i,2)==node1 && A(i,1)==node2 && A(i,3)==0 && A(i,4)==val
            A_2(i,4)=R_th;
            break;
        end
    end
    
    
    solv1=circuit_solver(A_2,gnd);
    [r2,~]=size(solv1);
    if node1==gnd
        for i=1:r2
            if node2==solv1(i,1)
                maximum_power=solv1(i,2)^2/R_th;
                break;
            end
        end
    elseif node2==gnd
        for i=1:r2
            if node1==solv1(i,1)
                maximum_power=solv1(i,2)^2/R_th;
                break;
            end
        end
    else
        for i=1:r2
            if node1==solv1(i,1)
                x1=solv1(i,2);
                break;
            end
        end
        for i=1:r2
            if node2==solv1(i,1)
                x2=solv1(i,2);
                break;
            end
        end
        maximum_power=(x1-x2)^2/R_th;
    end
end
    power=maximum_power;
    r_th=R_th;
end
