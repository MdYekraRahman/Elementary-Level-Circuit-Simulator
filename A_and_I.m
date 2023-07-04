function [A,I,node]=A_and_I(a,gnd)
A1=a;ground=gnd;
r=.00000001;

[row,~]=size(A1);
cnt1=0;cnt3=0;
for i=1:row
    if A1(i,3)==3
        cnt1=cnt1+1;
    elseif A1(i,3)==2
        cnt1=cnt1+1;
    else
        cnt3=cnt3+1;
    end
end
i1=zeros(cnt1,4);
% v1=zeros(cnt2,4);
A=zeros(cnt3,4);
k1=1;k3=1;
for i=1:row
    if A1(i,3)==3
        i1(k1,:)=A1(i,:);
        k1=k1+1;
    elseif A1(i,3)==2
        i1(k1,1:2)=A1(i,1:2);  i1(k1,3)=3;  i1(k1,4)=A1(i,4)/r;
        k1=k1+1; 
        A(k3,1:2)=A1(i,1:2);  A(k3,3)=0;  A(k3,4)=r;
        k3=k3+1;
%         v1(k2,:)=A1(i,:);
%         k2=k2+1;
    else
        A(k3,:)=A1(i,:);
        k3=k3+1;
    end
end

B=A(:,1:2);
Node=unique(reshape(B,1,[]));
% eliminating ground to select non refernce nodes
for i=1:length(Node)
    if Node(i)==ground
        Node(i)=[];
        break;
    end
end
node=Node;

I_temp=zeros(1,Node(end));

if isempty(i1)==0
    [row1,~]=size(i1);
    for j=1:row1
        if i1(j,1)~=ground
            I_temp(i1(j,1))=I_temp(i1(j,1))-i1(j,4);
        end
        if i1(j,2)~=ground
            I_temp(i1(j,2))=I_temp(i1(j,2))+i1(j,4);
        end
    end
end
cnt4=0;
for i=1:length(I_temp)
    if I_temp(i)~=0
        cnt4=cnt4+1;
    end
end
I=zeros(length(Node),2);
k4=1;
for i=1:length(Node) 
    I(k4,1)=Node(i);
    I(k4,2)=I_temp(Node(i));
    k4=k4+1;
end
end