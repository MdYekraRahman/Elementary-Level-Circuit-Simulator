clear all;
clc;
choice={'Circuit Solving','Frequency Sweeping','Amplitude Sweeping','Phase Sweeping'};
ch=listdlg('SelectionMode','single','ListString',choice);
if ch==1
    try
        def1=num2str(dlmread('Give circuit(Without Source) for ckt solve.txt'));
    catch
        def1='';
    end
    try
        def2=num2str(dlmread('Give source for ckt solve.txt'));
    catch
        def2='';
    end
    try
        def3=num2str(dlmread('Ground for ckt solve.txt'));
    catch
        def3='';
    end
    prompt={'Give circuit without Source ','Give source','Ground'};
    title='Input';
    definput={def1,def2,def3};
    answer=inputdlg(prompt,title,[8 50;8 50;1 20],definput);
    if (~isempty(answer))
        if(~isempty(answer{1}))
            A=str2num(answer{1});
            dlmwrite('Give circuit(Without Source) for ckt solve.txt',A,'delimiter',' ');
        end
        if(~isempty(answer{2}))
            S=str2num(answer{2});
            dlmwrite('Give source for ckt solve.txt',S,'delimiter',' ');
        end
        if(~isempty(answer{3}))
            gnd=str2num(answer{3});
            dlmwrite('Ground for ckt solve.txt',gnd);
        end
        A=dlmread('Give circuit(Without Source) for ckt solve.txt');
        S=dlmread('Give source for ckt solve.txt');
        gnd=dlmread('Ground for ckt solve.txt');
        [solution,freq]=AC_ckt_solve(A,S,gnd);
        nodes=(real(solution(:,1)));
        
        [r,c]=size(solution);
        fId=fopen('AC solution.txt','w');
        for i=1:r
            for j=2:c
                if isreal(solution(i,j))==1
                    fprintf(fId,'%f ',solution(i,j));
                else
                    fprintf(fId,'%f<%f ',abs(solution(i,j)),(180/pi)*angle(solution(i,j)));
                end
            end
            fprintf(fId,'\n');
        end
        fclose(fId);
        
        fId=fopen('AC solution.txt');
        sol=textscan(fId,'%s','Delimiter',' ');
        fclose(fId);
        cell=sol{1};
        
        count=1;
        cell_sol={};
        for i=1:length(nodes)
            for j=1:length(freq)
                cell_sol{i,j}=cell{count};
                count=count+1;
            end
        end
        
        data=cell_sol;
        t = uitable('Position',[20 20 500 70],'Data',data);
        t.ColumnWidth={120};
        table_extent = get(t,'Extent');
        set(t,'Position',[540 350-table_extent(4) table_extent(3) table_extent(4)]);
        t.ColumnName={freq};
        t.RowName={nodes};
        
    end
    
elseif ch==2
    
    try
        def1=num2str(dlmread('Give circuit(Without Source) for Freq sweep.txt'));
    catch
        def1='';
    end
    try
        def2=num2str(dlmread('Give source for Freq sweep.txt'));
    catch
        def2='';
    end
    try
        def=dlmread('AC.txt');
        def3=num2str(def(1));
        def4=num2str(def(2));
        def5=num2str(def(3));
        def6=num2str(def(4));
        def7=num2str(def(5));
        def8=num2str(def(6));
    catch
        def3='';def4='';def5='';def6='';def7='';def8='';
    end
    
    prompt={'Give circuit without Source ','Give source','Ground','Frequency From','Frequency To','Increment','Target Node1','Target Node2'};
    title='Input';
    definput={def1,def2,def3,def4,def5,def6,def7,def8};
    answer=inputdlg(prompt,title,[10 50;1 50;1 50;1 50;1 50;1 50;1 50;1 50],definput);
    if (~isempty(answer))
        if(~isempty(answer{1}))
            A=str2num(answer{1});
            dlmwrite('Give circuit(Without Source) for Freq sweep.txt',A,'delimiter',' ');
        end
        if(~isempty(answer{2}))
            S=str2num(answer{2});
            dlmwrite('Give source for Freq sweep.txt',S,'delimiter',' ');
        end
        if(~isempty(answer{3}))
            gnd=str2num(answer{3});
            dlmwrite('AC.txt',gnd);
        end
        if(~isempty(answer{4}))
            f1=str2num(answer{4});
            dlmwrite('AC.txt',f1,'-append');
        end
        if(~isempty(answer{5}))
            f2=str2num(answer{5});
            dlmwrite('AC.txt',f2,'-append');
        end
        if(~isempty(answer{6}))
            in=str2num(answer{6});
            dlmwrite('AC.txt',in,'-append');
        end
        if(~isempty(answer{7}))
            a2=str2num(answer{7});
            dlmwrite('AC.txt',a2,'-append');
        end
        if(~isempty(answer{8}))
            b2=str2num(answer{8});
            dlmwrite('AC.txt',b2,'-append');
        end
        
        A=dlmread('Give circuit(Without Source) for Freq sweep.txt');
        S=dlmread('Give source for Freq sweep.txt');
        
        ac_cir=dlmread('AC.txt');
        gnd=ac_cir(1);
        f1=ac_cir(2);
        f2=ac_cir(3);
        in=ac_cir(4);
        a2=ac_cir(5);
        b2=ac_cir(6);
        freq=f1:in:f2;
        AC_Freq_Sweep(A,S,gnd,freq,a2,b2);
    end
elseif ch==3
    try
        def1=num2str(dlmread('Give circuit(Without Source) for Amp sweep.txt'));
    catch
        def1='';
    end
    try
        def2=num2str(dlmread('Give source for Amp sweep.txt'));
    catch
        def2='';
    end
    try
        def=dlmread('AC1.txt');
        def3=num2str(def(1));
        def4=num2str(def(2));
        def5=num2str(def(3));
        def6=num2str(def(4));
        def7=num2str(def(5));
        def8=num2str(def(6));
    catch
        def3='';def4='';def5='';def6='';def7='';def8='';
    end
    prompt={'Give circuit without Source ','Give source','Ground','Amp1','Amp2','increment','Target Node1','Target Node2'};
    title='Input';
    definput={def1,def2,def3,def4,def5,def6,def7,def8};
    answer=inputdlg(prompt,title,[10 50;1 50;1 50;1 50;1 50;1 50;1 50;1 50],definput);
    if (~isempty(answer))
        if(~isempty(answer{1}))
            A=str2num(answer{1});
            dlmwrite('Give circuit(Without Source) for Amp sweep.txt',A,'delimiter',' ');
        end
        if(~isempty(answer{2}))
            S=str2num(answer{2});
            dlmwrite('Give source for Amp sweep.txt',S,'delimiter',' ');
        end
        if(~isempty(answer{3}))
            gnd=str2num(answer{3});
            dlmwrite('AC1.txt',gnd);
        end
        if(~isempty(answer{4}))
            f1=str2num(answer{4});
            dlmwrite('AC1.txt',f1,'-append');
        end
        if(~isempty(answer{5}))
            f2=str2num(answer{5});
            dlmwrite('AC1.txt',f2,'-append');
        end
        if(~isempty(answer{6}))
            in=str2num(answer{6});
            dlmwrite('AC1.txt',in,'-append');
        end
        if(~isempty(answer{7}))
            a2=str2num(answer{7});
            dlmwrite('AC1.txt',a2,'-append');
        end
        if(~isempty(answer{8}))
            b2=str2num(answer{8});
            dlmwrite('AC1.txt',b2,'-append');
        end
        
        
        A=dlmread('Give circuit(Without Source) for Amp sweep.txt');
        S=dlmread('Give source for Amp sweep.txt');
        ac_amp=dlmread('AC1.txt');
        gnd=ac_amp(1);
        amp1=ac_amp(2);
        amp2=ac_amp(3);
        in=ac_amp(4);
        a2=ac_amp(5);
        b2=ac_amp(6);
        amp=amp1:in:amp2;
        AC_Amp_Sweep(A,S,gnd,amp,a2,b2);
    end
    
elseif ch==4
    try
        def1=num2str(dlmread('Give circuit(Without Source) for phase sweep.txt'));
    catch
        def1='';
    end
    try
        def2=num2str(dlmread('Give source for phase sweep.txt'));
    catch
        def2='';
    end
    try
        def=dlmread('AC2.txt');
        def3=num2str(def(1));
        def4=num2str(def(2));
        def5=num2str(def(3));
        def6=num2str(def(4));
        def7=num2str(def(5));
        def8=num2str(def(6));
    catch
        def3='';def4='';def5='';def6='';def7='';def8='';
    end
    
    prompt={'Give circuit without Source ','Give source','Ground','From','To','increment','Target Node1','Target Node2'};
    title='Input';
    definput={def1,def2,def3,def4,def5,def6,def7,def8};
    answer=inputdlg(prompt,title,[10 50;1 50;1 50;1 50;1 50;1 50;1 50;1 50],definput);
    if (~isempty(answer))
        if(~isempty(answer{1}))
            A=str2num(answer{1});
            dlmwrite('Give circuit(Without Source) for phase sweep.txt',A,'delimiter',' ');
        end
        if(~isempty(answer{2}))
            S=str2num(answer{2});
            dlmwrite('Give source for phase sweep.txt',S,'delimiter',' ');
        end
        if(~isempty(answer{3}))
            gnd=str2num(answer{3});
            dlmwrite('AC2.txt',gnd);
        end
        if(~isempty(answer{4}))
            f1=str2num(answer{4});
            dlmwrite('AC2.txt',f1,'-append');
        end
        if(~isempty(answer{5}))
            f2=str2num(answer{5});
            dlmwrite('AC2.txt',f2,'-append');
        end
        if(~isempty(answer{6}))
            in=str2num(answer{6});
            dlmwrite('AC2.txt',in,'-append');
        end
        if(~isempty(answer{7}))
            a2=str2num(answer{7});
            dlmwrite('AC2.txt',a2,'-append');
        end
        if(~isempty(answer{8}))
            b2=str2num(answer{8});
            dlmwrite('AC2.txt',b2,'-append');
        end
        
        A=dlmread('Give circuit(Without Source) for phase sweep.txt');
        S=dlmread('Give source for phase sweep.txt');
        
        ac_phase=dlmread('AC2.txt');
        gnd=ac_phase(1);
        p1=(pi/180)*ac_phase(2);
        p2=(pi/180)*ac_phase(3);
        in=(pi/180)*ac_phase(4);
        a2=ac_phase(5);
        b2=ac_phase(6);
        ph=p1:in:p2;
        AC_Phase_Sweep(A,S,gnd,ph,a2,b2);
    end
end