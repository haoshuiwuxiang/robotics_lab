function binding_test()
disp('Program started');
vrep=remApi('remoteApi'); % using the prototype file(remoteApiProto.m)
% Close all V-REPcurrent remoteAPI connection
vrep.simxFinish(-1);
% Connect to 127.0.0.1£¬Namely V-REP software, the port number is 19997
clientID=vrep.simxStart('127.0.0.1',19997,true,true,5000,5);
% capture execution error caused by the code between try-catch, 
% once detected, stop and delete the connection 
try
if (clientID>-1)
disp('Connected to remote API server!');
% Get all the entities in the current V-REP scene to the structure objs, 
% and save the feedback state in res
% res = vrep.simxStartSimulation(clientID, vrep.simx_opmode_oneshot_wait);
[res,objs]=vrep.simxGetObjects(clientID,vrep.sim_handle_all,vrep.simx_opmode_blocking); 
% If the feedback connection status is normal, calculate the number of 
% entities in the current simulation scene, and print it to the command
% window, otherwise display the connection error and close the connection
if (res==vrep.simx_return_ok)
fprintf('Number of objects in the scene: %d\n',length(objs));
fprintf('The remote API is working!\n');
else
fprintf('Remote API function call returned with errorcode: %d\n',res);
end
vrep.simxFinish(clientID);
else
disp('Failed connecting to remote API server');
end
vrep.delete(); % call the destructor!
catch err
vrep.simxFinish(clientID); % close the line if still open
vrep.delete(); % call the destructor!
end;
disp('Program ended');
end