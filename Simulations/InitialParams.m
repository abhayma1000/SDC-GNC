%%% Parameters to run the SimulinkModel.slx model

%% Initialize time

startTime = datetime(2027, 10, 10, 10, 10, 10);


%% Initialize DCM R_BI

random_quat = rand(1, 4);
initial_q_BI = quaternion(norm(random_quat));
initial_R_BI = quat2dcm(initial_q_BI);

%% Initialize tumble rate

rotationRate = [0.01, 0.02, 0.03]; % radians per second (example rates for roll, pitch, yaw)
% On the high side compared to survey:
% https://ui.adsabs.harvard.edu/abs/2014amos.confE..61B/abstract#:~:text=Results%20show%20that%20observed%20satellites,can%20help%20to%20resolve%20ambiguities.



%% Initialize position, velocity

initialLLA = [42.2746, -71.8068, 1000000];

% TODO
