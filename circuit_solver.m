function solution=circuit_solver(A1,ground)

% clc;
% close all;
% clear all;
%
% A1=input('Give the Circuit:\n');
% ground=input('Give ground node:');
[A,I,Node]=A_and_I(A1,ground);
A(:,4)=1./A(:,4);
current=I(:,2);

C=zeros(length(Node));

% finding diagonal terms
for i=1:length(Node)
    C(i,i)=diag_term(Node(i),A);
end
% Finding Non Diagonal Elements
for i=1:length(Node)
    for j=1:length(Node)
        if(i~=j)
            C(i,j)=non_diag_term(Node(i),Node(j),A);
        end
    end
end

%The solution
v=C\current;
solution=zeros(length(Node),2);
for i=1:length(Node)
    solution(i,1)=Node(i);
    solution(i,2)=v(i);
end
end
