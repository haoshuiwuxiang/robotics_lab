function T=dof6_forw_model(q)
%--a parameter
a_0=0;
a_1=29.69;
a_2=108;
a_3=20.38;
a_4=0;
a_5=0;
%--alpha parameter
alpha_0=0;
alpha_1=-pi/2;
alpha_2=0;
alpha_3=-pi/2;
alpha_4=pi/2;
alpha_5=-pi/2;
%--d parameter
% d_1=77.98;
d_1=123.99;
d_2=0;
d_3=0;
% d_4=128.64;
d_4=168.67;
d_5=0;
d_6=0;
%link1
RL1=Link([0,d_1,a_0,alpha_0],'modified');
%link2
RL2=Link([0,d_2,a_1,alpha_1],'modified');
%link3
RL3=Link([0,d_3,a_2,alpha_2],'modified');
%link4
RL4=Link([0,d_4,a_3,alpha_3],'modified');
%link5
RL5=Link([0,d_5,a_4,alpha_4],'modified');
%link6
RL6=Link([0,d_6,a_5,alpha_5],'modified');
 
%construct a robot
robot_m=SerialLink([RL1 RL2 RL3 RL4 RL5 RL6],'name','robot');
%calculate forward kinematics
T=robot_m.fkine(q);
%Delete the comment symbol below, you can get the link diagram of the robot arm
%robot_m.plot(q)  
end
