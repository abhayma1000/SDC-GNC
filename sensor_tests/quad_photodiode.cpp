#include <cmath>
#include <Wire.h>

void setup() {
    Serial.begin(9600);
    pinMode(ledPin,  OUTPUT);

}

void loop() {
    float r = 2.0;
    float h = 4.0;

    // Assume we have A, B, C, D as respective voltages on each quad
    float A = 0;
    float B = 0;
    float C = 0;
    float D = 0;


    x = (((C + D) - (A + B)) / (A + B + C + D)) * r;
    y = (((A + D) - (B + C)) / (A + B + C + D)) * r;


    azimuth_sens_frame = std::atan2(x, h);
    elevation_sens_frame = std::atan2(y, h);

    azimuth_spherical = std::atan2(std::sqrtf(x ** 2 + y ** 2), h);
    elevation_spherical = std::atan2(x, y);

    Serial.println("Values: ");
    Serial.println(value);
    
}
