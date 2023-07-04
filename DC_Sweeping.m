function a =DC_Sweeping(A,g)
a=0;
format long;
choice2={'Sweep Voltage Source','Sweep Current Source','Sweep Resistance'};
ch2=listdlg('SelectionMode','single','ListString',choice2);

if ch2==1
    try
        def=(dlmread('Sweep Voltage Source.txt'));
        def1=num2str(def(1));
        def2=num2str(def(2));
        def3=num2str(def(3));
        def4=num2str(def(4));
        def5=num2str(def(5));
        def6=num2str(def(6));
        def7=num2str(def(7));
        def8=num2str(def(8));
        def9=num2str(def(9));
    catch
        def1='';def2='';def3='';def4='';def5='';
        def6='';def7='';def8='';def9='';
    end
    prompt2={'Node1 (Voltage source to be swept)','Node2 (Voltage source to be swept)',...
        'Value (Voltage source to be swept)','From','To','Increment','Node1 (Target Resistance)',...
        'Node2 (Target Resistance)','Value (Target Resistance)'};
    dlg_title='Input';
    definput={def1,def2,def3,def4,def5,def6,def7,def8,def9};
    answer2 = inputdlg(prompt2,dlg_title,[1 50],definput);
    
    if isempty(answer2)==0
        if (~isempty(answer2{1}))
            a1=str2num(answer2{1});
            dlmwrite('Sweep Voltage Source.txt',a1);
        end
        if (~isempty(answer2{2}))
            b1=str2num(answer2{2});
            dlmwrite('Sweep Voltage Source.txt',b1,'-append');
        end
        if (~isempty(answer2{3}))
            V=str2num(answer2{3});
            dlmwrite('Sweep Voltage Source.txt',V,'-append');
        end
        if (~isempty(answer2{4}))
            r1=str2num(answer2{4});
            dlmwrite('Sweep Voltage Source.txt',r1,'-append');
        end
        if (~isempty(answer2{5}))
            r2=str2num(answer2{5});
            dlmwrite('Sweep Voltage Source.txt',r2,'-append');
        end
        if (~isempty(answer2{6}))
            incrmnt=str2num(answer2{6});
            dlmwrite('Sweep Voltage Source.txt',incrmnt,'-append');
        end
        if (~isempty(answer2{7}))
            a2=str2num(answer2{7});
            dlmwrite('Sweep Voltage Source.txt',a2,'-append');
        end
        if (~isempty(answer2{8}))
            b2=str2num(answer2{8});
            dlmwrite('Sweep Voltage Source.txt',b2,'-append');
        end
        if (~isempty(answer2{9}))
            R=str2num(answer2{9});
            dlmwrite('Sweep Voltage Source.txt',R,'-append');
        end
        
        vs_sweep=dlmread('Sweep Voltage Source.txt');
        a1=vs_sweep(1);
        b1=vs_sweep(2);
        V=vs_sweep(3);
        r1=vs_sweep(4);
        r2=vs_sweep(5);
        incrmnt=vs_sweep(6);
        a2=vs_sweep(7);
        b2=vs_sweep(8);
        R=vs_sweep(9);
        
        v_test=r1:incrmnt:r2;
        
        choice3={'Sweep for Power','Sweep for Voltage'};
        ch3=listdlg('SelectionMode','single','ListString',choice3);
        
        if ch3==1
            power=zeros(1,length(v_test));
            v1=0;
            v2=0;
            [r,~]=size(A);
            for j=1:r
                if A(j,1)== a1 && A(j,2)==b1 && A(j,3)==2 && A(j,4)== V
                    for k=1:length(v_test)
                        A(j,4)=v_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        power(k)=(v1-v2)^2/R;
                    end
                elseif A(j,1)== b1 && A(j,2)==a1 && A(j,3)==2 && A(j,4)== V
                    for k=1:length(v_test)
                        A(j,4)=v_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        power(k)=(v1-v2)^2/R;
                    end
                end
            end
            plot(v_test,power);
            x_axis=[' Sweeping Voltage Source  ' '[' num2str(a1) '  ' num2str(b1) '  ' num2str(V) ']' ];
            y_axis=[' Power of R' '[' num2str(a2) '  ' num2str(b2) '  ' num2str(R) ']' ];
            grid on;
            grid minor;
            xlabel(x_axis,'FontSize',12,'FontWeight','bold','Color','b');
            ylabel(y_axis,'FontSize',12,'FontWeight','bold','Color','r');
            title('Power vs Voltage Source','FontSize',12,'FontWeight','bold','Color','k');
        elseif ch3==2
            voltage=zeros(1,length(v_test));
            v1=0;
            v2=0;
            [r,~]=size(A);
            for j=1:r
                if A(j,1)== a1 && A(j,2)==b1 && A(j,3)==2 && A(j,4)== V
                    for k=1:length(v_test)
                        A(j,4)=v_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        voltage(k)=(v1-v2);
                    end
                elseif A(j,1)== b1 && A(j,2)==a1 && A(j,3)==2 && A(j,4)== V
                    for k=1:length(v_test)
                        A(j,4)=v_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        voltage(k)=(v1-v2);
                    end
                end
            end
            plot(v_test,voltage);
            x_axis=[' Sweeping Voltage Source  ' '[' num2str(a1) '  ' num2str(b1) '  ' num2str(V) ']' ];
            y_axis=[' Voltage across R' '[' num2str(a2) '  ' num2str(b2) '  ' num2str(R) ']' ];
            grid on;
            grid minor;
            xlabel(x_axis,'FontSize',12,'FontWeight','bold','Color','b');
            ylabel(y_axis,'FontSize',12,'FontWeight','bold','Color','r');
            title('Voltage Across R vs Voltage Source','FontSize',12,'FontWeight','bold','Color','k');
        end
    end
elseif ch2==2
    try
        def=(dlmread('Sweep Current Source.txt'));
        def1=num2str(def(1));
        def2=num2str(def(2));
        def3=num2str(def(3));
        def4=num2str(def(4));
        def5=num2str(def(5));
        def6=num2str(def(6));
        def7=num2str(def(7));
        def8=num2str(def(8));
        def9=num2str(def(9));
    catch
        def1='';def2='';def3='';def4='';def5='';
        def6='';def7='';def8='';def9='';
    end
    prompt2={'Node1 (Current source to be swept)','Node2 (Current source to be swept)',...
        'Value (Current source to be swept)','From','To','Increment','Node1 (Target Resistance)',...
        'Node2 (Target Resistance)','Value (Target Resistance)'};
    dlg_title='Input';
    definput={def1,def2,def3,def4,def5,def6,def7,def8,def9};
    answer2 = inputdlg(prompt2,dlg_title,[1 50],definput);
    if isempty(answer2)==0
        if (~isempty(answer2{1}))
            a1=str2num(answer2{1});
            dlmwrite('Sweep Current Source.txt',a1);
        end
        if (~isempty(answer2{2}))
            b1=str2num(answer2{2});
            dlmwrite('Sweep Current Source.txt',b1,'-append');
        end
        if (~isempty(answer2{3}))
            I=str2num(answer2{3});
            dlmwrite('Sweep Current Source.txt',I,'-append');
        end
        if (~isempty(answer2{4}))
            r1=str2num(answer2{4});
            dlmwrite('Sweep Current Source.txt',r1,'-append');
        end
        if (~isempty(answer2{5}))
            r2=str2num(answer2{5});
            dlmwrite('Sweep Current Source.txt',r2,'-append');
        end
        if (~isempty(answer2{6}))
            incrmnt=str2num(answer2{6});
            dlmwrite('Sweep Current Source.txt',incrmnt,'-append');
        end
        if (~isempty(answer2{7}))
            a2=str2num(answer2{7});
            dlmwrite('Sweep Current Source.txt',a2,'-append');
        end
        if (~isempty(answer2{8}))
            b2=str2num(answer2{8});
            dlmwrite('Sweep Current Source.txt',b2,'-append');
        end
        if (~isempty(answer2{9}))
            R=str2num(answer2{9});
            dlmwrite('Sweep Current Source.txt',R,'-append');
        end
        
        cs_sweep=dlmread('Sweep Current Source.txt');
        a1=cs_sweep(1);
        b1=cs_sweep(2);
        I=cs_sweep(3);
        r1=cs_sweep(4);
        r2=cs_sweep(5);
        incrmnt=cs_sweep(6);
        a2=cs_sweep(7);
        b2=cs_sweep(8);
        R=cs_sweep(9);
        
        I_test=r1:incrmnt:r2;
        
        choice3={'Sweep for Power','Sweep for Voltage'};
        ch3=listdlg('SelectionMode','single','ListString',choice3);
        
        if ch3==1
            power=zeros(1,length(I_test));
            v1=0;
            v2=0;
            [r,~]=size(A);
            for j=1:r
                if A(j,1)== a1 && A(j,2)==b1 && A(j,3)==3 && A(j,4)== I
                    for k=1:length(I_test)
                        A(j,4)=I_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        power(k)=(v1-v2)^2/R;
                    end
                elseif A(j,1)== b1 && A(j,2)==a1 && A(j,3)==3 && A(j,4)== I
                    for k=1:length(I_test)
                        A(j,4)=I_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        power(k)=(v1-v2)^2/R;
                    end
                end
            end
            plot(I_test,power);
            x_axis=[' Sweeping Current Source  ' '[' num2str(a1) '  ' num2str(b1) '  ' num2str(I) ']' ];
            y_axis=[' Power of R' '[' num2str(a2) '  ' num2str(b2) '  ' num2str(R) ']' ];
            grid on;
            grid minor;
            xlabel(x_axis,'FontSize',12,'FontWeight','bold','Color','b');
            ylabel(y_axis,'FontSize',12,'FontWeight','bold','Color','r');
            title('Power vs Current Source','FontSize',12,'FontWeight','bold','Color','k');
        elseif ch3==2
            voltage=zeros(1,length(I_test));
            v1=0;
            v2=0;
            [r,~]=size(A);
            for j=1:r
                if A(j,1)== a1 && A(j,2)==b1 && A(j,3)==3 && A(j,4)== I
                    for k=1:length(I_test)
                        A(j,4)=I_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        voltage(k)=(v1-v2);
                    end
                elseif A(j,1)== b1 && A(j,2)==a1 && A(j,3)==3 && A(j,4)== I
                    for k=1:length(I_test)
                        A(j,4)=I_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        voltage(k)=(v1-v2);
                    end
                end
            end
            plot(I_test,voltage);
            x_axis=[' Sweeping Current Source  ' '[' num2str(a1) '  ' num2str(b1) '  ' num2str(I) ']' ];
            y_axis=[' Voltage across R' '[' num2str(a2) '  ' num2str(b2) '  ' num2str(R) ']' ];
            grid on;
            grid minor;
            xlabel(x_axis,'FontSize',12,'FontWeight','bold','Color','b');
            ylabel(y_axis,'FontSize',12,'FontWeight','bold','Color','r');
            title('Voltage Across R vs Current Source','FontSize',12,'FontWeight','bold','Color','k');
        end
    end
elseif ch2==3
    try
        def=(dlmread('Sweep Resistance.txt'));
        def1=num2str(def(1));
        def2=num2str(def(2));
        def3=num2str(def(3));
        def4=num2str(def(4));
        def5=num2str(def(5));
        def6=num2str(def(6));
        def7=num2str(def(7));
        def8=num2str(def(8));
        def9=num2str(def(9));
    catch
        def1='';def2='';def3='';def4='';def5='';
        def6='';def7='';def8='';def9='';
    end
    prompt2={'Node1 (Resistance to be swept)','Node2 (Resistance to be swept)',...
        'Value (Resistance to be swept)','From','To','Increment','Node1 (Target Resistance)',...
        'Node2 (Target Resistance)','Value (Target Resistance)'};
    dlg_title='Input';
    definput={def1,def2,def3,def4,def5,def6,def7,def8,def9};
    answer2 = inputdlg(prompt2,dlg_title,[1 50],definput);
    
    if isempty(answer2)==0
        if (~isempty(answer2{1}))
            a1=str2num(answer2{1});
            dlmwrite('Sweep Resistance.txt',a1);
        end
        if (~isempty(answer2{2}))
            b1=str2num(answer2{2});
            dlmwrite('Sweep Resistance.txt',b1,'-append');
        end
        if (~isempty(answer2{3}))
            R1=str2num(answer2{3});
            dlmwrite('Sweep Resistance.txt',R1,'-append');
        end
        if (~isempty(answer2{4}))
            r1=str2num(answer2{4});
            dlmwrite('Sweep Resistance.txt',r1,'-append');
        end
        if (~isempty(answer2{5}))
            r2=str2num(answer2{5});
            dlmwrite('Sweep Resistance.txt',r2,'-append');
        end
        if (~isempty(answer2{6}))
            incrmnt=str2num(answer2{6});
            dlmwrite('Sweep Resistance.txt',incrmnt,'-append');
        end
        if (~isempty(answer2{7}))
            a2=str2num(answer2{7});
            dlmwrite('Sweep Resistance.txt',a2,'-append');
        end
        if (~isempty(answer2{8}))
            b2=str2num(answer2{8});
            dlmwrite('Sweep Resistance.txt',b2,'-append');
        end
        if (~isempty(answer2{9}))
            R2=str2num(answer2{9});
            dlmwrite('Sweep Resistance.txt',R2,'-append');
        end
        
        r_sweep=dlmread('Sweep Resistance.txt');
        a1=r_sweep(1);
        b1=r_sweep(2);
        R1=r_sweep(3);
        r1=r_sweep(4);
        r2=r_sweep(5);
        incrmnt=r_sweep(6);
        a2=r_sweep(7);
        b2=r_sweep(8);
        R2=r_sweep(9);
        
        R_test=r1:incrmnt:r2;
        
        
        choice3={'Sweep for Power','Sweep for Voltage'};
        ch3=listdlg('SelectionMode','single','ListString',choice3);
        
        [row,~]=size(A);
        index=0;
        for j=1:row
            if A(j,1)== a2 && A(j,2)==b2 && A(j,3)==0 && A(j,4)== R2
                index=j;
            elseif A(j,1)== b2 && A(j,2)==a2 && A(j,3)==0 && A(j,4)== R2
                index=j;
            end
        end
        
        if ch3==1
            power=zeros(1,length(R_test));
            v1=0;
            v2=0;
            [r,~]=size(A);
            for j=1:r
                if A(j,1)== a1 && A(j,2)==b1 && A(j,3)==0 && A(j,4)== R1
                    for k=1:length(R_test)
                        A(j,4)=R_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        power(k)=(v1-v2)^2/A(index,4);
                    end
                elseif A(j,1)== b1 && A(j,2)==a1 && A(j,3)==0 && A(j,4)== R1
                    for k=1:length(R_test)
                        A(j,4)=R_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        power(k)=(v1-v2)^2/A(index,4);
                    end
                end
            end
            plot(R_test,power);
            x_axis=['Resistance ' '[' num2str(a1) '  ' num2str(b1) '  ' num2str(R1) ']' ];
            y_axis=[' Power of R' '[' num2str(a2) '  ' num2str(b2) '  ' num2str(R2) ']' ];
            grid on;
            grid minor;
            xlabel(x_axis,'FontSize',10,'FontWeight','bold','Color','b');
            ylabel(y_axis,'FontSize',10,'FontWeight','bold','Color','r');
            title(' Power of R vs Sweeping R ','FontSize',10,'FontWeight','bold','Color','k');
        elseif ch3==2
            voltage=zeros(1,length(R_test));
            v1=0;
            v2=0;
            [r,~]=size(A);
            for j=1:r
                if A(j,1)== a1 && A(j,2)==b1 && A(j,3)==0 && A(j,4)== R1
                    for k=1:length(R_test)
                        A(j,4)=R_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        voltage(k)=(v1-v2);
                    end
                elseif A(j,1)== b1 && A(j,2)==a1 && A(j,3)==0 && A(j,4)== R1
                    for k=1:length(R_test)
                        A(j,4)=R_test(k);
                        sol=circuit_solver(A,g);
                        [b,~]=size(sol);
                        for m=1:b
                            if sol(m,1)== a2
                                v1=sol(m,2);
                            end
                            if sol(m,1)== b2
                                v2=sol(m,2);
                            end
                        end
                        voltage(k)=(v1-v2);
                    end
                end
            end
            plot(R_test,voltage);
            x_axis=[' Sweeping Resistance   ' '[' num2str(a1) '  ' num2str(b1) '  ' num2str(R1) ']' ];
            y_axis=[' Voltage Across R' '[' num2str(a2) '  ' num2str(b2) '  ' num2str(R2) ']' ];
            grid on;
            grid minor;
            xlabel(x_axis,'FontSize',12,'FontWeight','bold','Color','b');
            ylabel(y_axis,'FontSize',12,'FontWeight','bold','Color','r');
            title('Voltage Across R vs Sweeping R','FontSize',12,'FontWeight','bold','Color','k');
        end
    end
end