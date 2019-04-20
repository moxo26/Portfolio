%% Set comunication
delete(instrfind({'Port'},{'COM6'})); %COM can change so check
obj = serial('COM6');
set(obj, 'Terminator', 'CR');
set(obj, 'BaudRate',9600,'DataBits',8,'Parity','none','StopBits',1);
obj.FlowControl = 'none';
fopen(obj);
%% Note: Pay attention to the following
%% The angles are in rad
%% Link Parameter in cm
L_1= 7.0;    % distance from the surface       % distance from joint 1 and 2
L_3=14.7574; % distance from joint 3 and 2
L_4=18.4404; % distance from joint 4 and 3
L_5=7;   % distance from joint 5 and 4
%% Creating
% % L0 = Link('d', 0 , 'a', 0, 'alpha',0);
L1 = Revolute('d', L_1, 'a', 0, 'alpha',pi/2,'qlim',[-pi/2 pi/2]);
L2 = Revolute('d', 0 , 'a', L_3, 'alpha', 0,'qlim',[0 pi/2]);
L3 = Revolute('d', 0, 'a', L_4, 'alpha',0,'qlim',[-pi/2 pi/2]);
L4 = Revolute('d', 0, 'a', L_5, 'alpha',0,'qlim',[-pi/2 pi/2]);
% L6 =Revolute('d', 0, 'a', 10, 'alpha',pi/2);

%% Creates serial link
Robot = SerialLink([L1 L2 L3 L4], 'name', 'RobotArm');
q0= [0 0 0 0];

axes(handles.axes1)
camroll(-90);
 hold on
fprintf(obj,'#0 P1500 T1500')
fprintf(obj,'#1 P500 T1500')
fprintf(obj,'#2 P600 T1500')
fprintf(obj,'#3 P1250 T1500')
pause(1)
%% Plot Robot
axes(handles.axes2)
% figure(2)
% view([0,-pi,pi])
view(0,0)
Robot.plot(q0,'workspace', [-40, 40, -40, 40 -40, 40 ]);
hold on
for h = 1:size(CCx,2)
    plot3(CCx{h}(1,:),CCy{h}(1,:),zeros(1,size(CCx{h},2)));
end
pause(2)
%% inverse kinematics
T={};
count1=1;
for h = 1:size(CCx,2)
    for i = 1:10:size(CCx{h},2)
        beta= atan2(CCy{h}(1,i),CCx{h}(1,i));
        R =[cos(beta) -sin(beta), 0; sin(beta) cos(beta), 0; 0, 0, 1];
        T= [R,[CCx{h}(1,i), CCy{h}(1,i), 4]';0, 0 ,0,1];
        qi = Robot.ikine(T,'mask', [1 1 1 0 0 1],'q0', q0);
        q0= qi;
        if isempty(qi) ==0
            q1=round((qi).*(2000/pi));
            q2=[-q1(1)+1500, q1(2)+500, -q1(3)+600, (q1(4)+1200)]
            
            %% Figure Plot
            axes(handles.axes1)
            %figure(1)
            hold on
            axis([0 40 -40 40])
            plot(CCx{1,h}(1,i), CCy{1,h}(1,i),'.')
            
            %% Manipulator Plot
            axes(handles.axes2)
            %figure(2)
            Robot.plot([qi],'workspace', [-40, 40, -40, 40 -40, 40 ]);
            fprintf(obj,'#0P%d T300\n',q2(1));
            fprintf(obj,'#1P%d T300\n',q2(2));
            fprintf(obj,'#2P%d T300\n',q2(3));
            fprintf(obj,'#3P%d T300\n',q2(4));
            pause(.5)      
            
        end
        
    end
end
