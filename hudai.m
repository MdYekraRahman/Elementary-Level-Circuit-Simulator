clc;
clear all;
close all;

choice={'DC','AC','NON SINUSOIDAL'};
ch=listdlg('ListString',choice);

if ch==1
    try
        def=num2str(dlmread('DC circuit.txt'));
        def1=def(1:end-1,:);
        def2=str2num(def(end,:));
        def2=num2str(def2(1));
    catch
        def1='';
        def2='';
    end
    prompt={'Give circuit','Ground'};
    title='Input';
    definput={def1,def2};
    answer=inputdlg(prompt,title,[15 50;1 20],definput);
    if isempty(answer)==0
       
        if (~isempty(answer{1}))
            A=str2num(answer{1});
            dlmwrite('DC Circuit.txt',A,'delimiter',' ');
        end
        if (~isempty(answer{2}))
            gnd=str2num(answer{2});
            dlmwrite('DC Circuit.txt',gnd,'-append');
        end
        dc_cir=dlmread('DC Circuit.txt');
        A=dc_cir(1:end-1,:);
        gnd=dc_cir(end,1);
        
        choice1={'Solve For Node Voltages','Sweeping','Maximum Power Transfer'};
        ch1=listdlg('ListString',choice1);
        if ch1==3
            [maximum,R_th]=max_power(A,gnd);
            if R_th~=0
                data = [R_th maximum];
                t = uitable('Position',[20 20 500 70],'data',data);
                table_extent = get(t,'Extent');
                set(t,'Position',[125 350-table_extent(4) 350 table_extent(4)])
                t.ColumnName={'R Thevenin','Maximum Power'};
                t.RowName={};
                t.ColumnWidth={120 228};
            end
        elseif ch1==2
            m=sweeping(A,gnd);
        elseif ch1==1
            node_voltages=circuit_solver(A,gnd);
            [~,clm]=size(node_voltages);
            
            data = node_voltages;
            t = uitable('Position',[20 20 500 70],'Data',data);
            table_extent = get(t,'Extent');
            set(t,'Position',[120 350-table_extent(4) 350 table_extent(4)])
            t.ColumnName={'Node','Voltage'};
            t.RowName={};
            t.ColumnWidth={120 228};
        end
    end
elseif ch==3
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
end