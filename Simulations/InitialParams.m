%%% Parameters to run the SimulinkModel.slx model

%% Initialize time

startTime = datetime(2027, 10, 10, 10, 10, 10);
julianDate = juliandate(startTime);

%% Orbit parameters

semiMajorAxis = 6865000; % meters
eccentricity = 0.0002105; % unitless
inclination = 97.4; % degrees
rightAscensionOfAscendingNode = 0; % degrees
argumentOfPeriapsis = 0; % degrees
trueAnomaly = 0; % degrees

%% Initialize sat dynamics properties

mass = 0.25; % [kg]
inertia_tensor = [0.2273, 0, 0; 0, 0.2273, 0; 0, 0, .0040]; % TODO example for now


%% Initialize DCM R_BI

random_quat = rand(1, 4);
initial_q_BI = random_quat / norm(random_quat);
initial_R_BI = quat2dcm(initial_q_BI);

%% Initialize tumble rate

rotationRate = [0.01, 0.02, 0.03]; % radians per second (example rates for roll, pitch, yaw)
% On the high side compared to survey:
% https://ui.adsabs.harvard.edu/abs/2014amos.confE..61B/abstract#:~:text=Results%20show%20that%20observed%20satellites,can%20help%20to%20resolve%20ambiguities.



%% Initialize position, velocity

initialLLA = [42.2746, -71.8068, 1000000];

% TODO

