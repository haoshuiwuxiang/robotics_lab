function dof6_forward_test()
 
disp('Program started');
% Import library functions
vrep=remApi('remoteApi');
% End the communication thread
vrep.simxFinish(-1);
% Start communication connection
id = vrep.simxStart('127.0.0.1', 19997, true, true, 2000, 5);
% Determine whether the communication is successful
if id < 0
disp('Failed connecting to remote API server. Exiting.');
vrep.delete();
return;
end
fprintf('Connection %d to remote API server open.\n', id);
% When the program is interrupted, clear all between connections MATLAB and V-rep 
cleanupObj = onCleanup(@() cleanup_vrep(vrep, id));
% This will only work in "continuous remote API server service"
% See http://www.v-rep.eu/helpFiles/en/remoteApiServerSide.htm
% Start simulation
res = vrep.simxStartSimulation(id, vrep.simx_opmode_oneshot_wait);
% Initialize all objects that need to be manipulated
h = Init(vrep, id);
pause(.2);
disp('Starting robot');
% Get joint position
for i=1:1:6
    [res,pos(i)] = vrep.simxGetJointPosition(id, h.Joints(i),vrep.simx_opmode_buffer );
    vrchk(vrep, res, true);
end
% Call the forward kinematics function to calculate the end pose matrix
T=dof6_forw_model(pos)

% Pause for 5s
pause(5);   
% End simulation
res = vrep.simxStopSimulation(id, vrep.simx_opmode_oneshot);
end