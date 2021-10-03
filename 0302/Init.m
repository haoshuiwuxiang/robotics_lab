function handles = Init(vrep, id)

handles = struct('id', id);

Joints = [-1,-1,-1,-1,-1,-1]; 

% Get the handle of Joints
[res Joints(1)] = vrep.simxGetObjectHandle(id, 'joint1', vrep.simx_opmode_oneshot_wait); vrchk(vrep, res);
[res Joints(2)] = vrep.simxGetObjectHandle(id, 'joint2', vrep.simx_opmode_oneshot_wait); vrchk(vrep, res);
[res Joints(3)] = vrep.simxGetObjectHandle(id, 'joint3', vrep.simx_opmode_oneshot_wait); vrchk(vrep, res);
[res Joints(4)] = vrep.simxGetObjectHandle(id, 'joint4', vrep.simx_opmode_oneshot_wait); vrchk(vrep, res);
[res Joints(5)] = vrep.simxGetObjectHandle(id, 'joint5', vrep.simx_opmode_oneshot_wait); vrchk(vrep, res);
[res Joints(6)] = vrep.simxGetObjectHandle(id, 'joint6', vrep.simx_opmode_oneshot_wait); vrchk(vrep, res);

handles.Joints = Joints;

% Get the handle of robot_tip
[res robot_tip] = vrep.simxGetObjectHandle(id, 'tip', vrep.simx_opmode_oneshot_wait); vrchk(vrep, res);

handles.robot_tip = robot_tip;

% Get feedback value for the first time
for i = 1:6
  res = vrep.simxGetJointPosition(id, Joints(i), vrep.simx_opmode_streaming); vrchk(vrep, res, true);
end

res = vrep.simxGetObjectPosition(id, robot_tip, -1, vrep.simx_opmode_streaming); vrchk(vrep, res, true);
res = vrep.simxGetObjectOrientation(id, robot_tip, -1, vrep.simx_opmode_streaming); vrchk(vrep, res, true);

end
