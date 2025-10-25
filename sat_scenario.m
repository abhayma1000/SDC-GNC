% Create Satellite Scenario
startTime = datetime(2026,0,1,0,0,0);
stopTime = startTime + days(1);
sampleTime = 1;

% Create scenario
sc = satelliteScenario(startTime, stopTime, sampleTime);

% Launch Satellite Scenario Viewer
vwr = satelliteScenarioViewer(sc);

% Add Satellite to Scenario
semiMajorAxis = 6865000; % meters
eccentricity = 0.0002105; % unitless
inclination = 97.4; % degrees
rightAscensionOfAscendingNode = 0; % degrees
argumentOfPeriapsis = 0; % degrees
trueAnomaly = 0; % degrees

orbProp = "two-body-keplerian"; % name-value pair
satName = "GOAT-1"; % name-value pair

% Add the satellite with variable name sat
sat = satellite(sc, semiMajorAxis, eccentricity, inclination, rightAscensionOfAscendingNode, argumentOfPeriapsis, trueAnomaly, ...
    OrbitPropagator=orbProp, Name=satName);

% Define rotation variables
rotationRate = [0.01, 0.02, 0.03]; % radians per second (example rates for roll, pitch, yaw)
initialAttitude = [1, 0, 0, 0];    % initial quaternion (assuming no initial rotation)

% Generate Attitude Timetable
numSamples = seconds(stopTime - startTime) / sampleTime + 1; % Number of samples
timeVector = (startTime:seconds(sampleTime):stopTime)'; % Time vector

% Initialize quaternion data array
quaternionData = zeros(numSamples, 4);
quaternionData(1, :) = initialAttitude;

% Calculate quaternions based on defined tumble
for k = 2:numSamples
    deltaT = sampleTime;
    deltaAngle = rotationRate * deltaT;
    deltaQuaternion = angle2quat(deltaAngle(1), deltaAngle(2), deltaAngle(3), 'XYZ');
    quaternionData(k, :) = quatmultiply(quaternionData(k-1, :), deltaQuaternion);
end

% Normalize the quaternions to ensure they represent valid rotations
quaternionData = quaternionData ./ vecnorm(quaternionData, 2, 2);

% Create the timetable
attitudeTable = timetable(timeVector, quaternionData, 'VariableNames', {'Quaternions'});

% Add Conical Sensor to Satellite
maxViewingAngle = 60;  % degrees in the range [0,180]
csName = "Camera";     % name-value pair

% Add the conical sensor with variable name camera
camera = conicalSensor(sat, MaxViewAngle=maxViewingAngle, Name=csName);

% Enable field of view visualization of the conical sensor
fieldOfView(camera);

% Add Ground Station to Scenario
latitude = 42.2746;  % degrees
longitude = -71.8068; % degrees
wpiName = "WPI";  % name-value pair

% Add ground station with variable name wpi
wpi = groundStation(sc, latitude, longitude, Name=wpiName);

% Point Satellite at Ground Station
pointAt(sat, attitudeTable);

% Add Access Analysis and Visualize Scenario
ac = access(camera, wpi);

% Determine Times When Access Is Achieved, and Visualize Access
accessIntervals(ac)

% Play the scenario
speedMultiplier = 100;  % name-value pair
play(sc, PlaybackSpeedMultiplier=speedMultiplier);