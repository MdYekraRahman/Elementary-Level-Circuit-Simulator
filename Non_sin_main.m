clear all;
clc;
try
    def1=num2str(dlmread('Give circuit(Without Source).txt'));
catch
    def1='';
end
try
    def2=num2str(dlmread('Ground.txt'));
catch
    def2='';
end
prompt={'Give circuit(Without Source)','Ground'};
title='Input';
definput={def1,def2};
answer=inputdlg(prompt,title,[15 50;1 20],definput);

if (~isempty(answer))
    if(~isempty(answer{1}))
        A=str2num(answer{1});
        dlmwrite('Give circuit(Without Source).txt',A,'delimiter',' ');
    end
    if(~isempty(answer{2}))
        gnd=str2num(answer{2});
        dlmwrite('Ground.txt',gnd);
    end
    
    A=dlmread('Give circuit(Without Source).txt');
    gnd=dlmread('Ground.txt');
    call=non_sin(A,gnd);
end
