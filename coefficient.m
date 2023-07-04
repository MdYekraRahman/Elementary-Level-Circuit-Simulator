function [a0,a,b]=coefficient(period,nof,n)

a=zeros(1,n);
a1=zeros(1,n);
b=zeros(1,n);
b1=zeros(1,n);
a0=0;

for i=1:nof
    try
        def1=num2str(dlmread(['Lower Limit' num2str(i) '.txt']));
    catch
        def1='';
    end
    try
        def2=num2str(dlmread(['Upper Limit' num2str(i) '.txt']));
    catch
        def2='';
    end
    try
        def3=fileread(['Give function' num2str(i)  '.txt']);
    catch
        def3='';
    end
    definput={def1,def2,def3};
    prompt={['Lower Limit' num2str(i)],['Upper Limit' num2str(i)],['Give Function' num2str(i)]};
    inpu=inputdlg(prompt,'Signal Input',[1 50],definput);
    if(~isempty(inpu))
        if(~isempty(inpu{1}))
            low=str2num(inpu{1});
            dlmwrite(['Lower Limit' num2str(i) '.txt'],low);
        end
        if(~isempty(inpu{2}))
            up=str2num(inpu{2});
            dlmwrite(['Upper Limit' num2str(i) '.txt'],up);
        end
        if(~isempty(inpu{3}))
            fun=str2num(inpu{3});
            fun_str=func2str(fun);
            name=['Give function' num2str(i) '.txt'];
            f1=fopen(name,'w');
            fwrite(f1,fun_str);
            fclose(f1);
        end
        low=dlmread(['Lower Limit' num2str(i) '.txt']);
        up=dlmread(['Upper Limit' num2str(i) '.txt']);
        funh=fileread(['Give function' num2str(i)  '.txt']);
        fun=str2num(funh);
        
        a0=a0+(1/period)*integral(fun,low,up,'ArrayValued',true);
        
        for j=1:n
            funa=@(x) fun(x).*cos((j*2*pi*x)/period);
            a1(j)=(2/period)*integral(funa,low,up);
            funb=@(x) fun(x).*sin((j*2*pi*x)/period);
            b1(j)=(2/period)*integral(funb,low,up);
        end
        
        a=a+a1;
        b=b+b1;
    end
end
