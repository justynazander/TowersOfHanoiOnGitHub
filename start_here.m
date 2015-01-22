load cps_workspace_variables_v2;
open_system('cps_blockR_camera_v2');
open_system('cps_blockG_camera_v2');
open_system('cps_blockB_camera_v2');
open_system('cps_cameras_v2');
open_system('smart_manufacturing_robotics_cyber_physical_system_v2');
disp('Start simulation by clicking the Run button of the model');
disp('smart_manufacturing_robotics_cyber_physical_system_v2');
disp(' ');
disp('Turn off stereoscopic vision (useStereopsis = 0) if you');
disp('do not have a Computer Vision System Toolbox license.');
disp(' ');
disp('If you want to use a multirate controller, set the workspace');
disp('variable useMultirate to 1.');
disp(' ');
disp('If you want to create the dialogs for the custom Simscape blocks,');
disp('build the library by typing ssc_build(''cps_physics'') at the');
disp('command prompt.');
% eclipse 