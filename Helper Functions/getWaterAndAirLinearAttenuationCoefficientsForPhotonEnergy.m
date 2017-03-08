function [waterCoeff, airCoeff] = getWaterAndAirLinearAttenuationCoefficientsForPhotonEnergy(photonEnergy)
% [waterCoeff, airCoeff] = getWaterAndAirLinearAttenuationCoefficientsForPhotonEnergy(photonEnergy)
%
% Units:
% Photon Energy: Mev
% Mass Attenuation Coefficient: cm^2/g
% Density (at 20 C, standard pressure): g/cm^3

waterDensity = 0.9982; % from IUPAC
airDensity = 0.0012041; % from IUPAC

% attenuation coefficient values from National Bureau of Standards (US
% Department of Commerce) [Apr 1, 1994]
% at: http://dtic.mil/dtic/tr/fulltext/u2/a278139.pdf

waterMassAttenuationCoefficients = [...
    0.01, 5.10;
    0.015, 1.53;
    0.02, 0.722;
    0.03, 0.336;
    0.04, 0.245;
    0.05, 0.212;
    0.06, 0.196;
    0.08, 0.178;
    0.10, 0.167;
    0.15, 0.149;
    0.20, 0.136;
    0.30, 0.118;
    0.40, 0.106;
    0.50, 0.0966;
    0.60, 0.0896;
    0.80, 0.0786;
    1.0, 0.0706;
    1.5, 0.0575;
    2.0, 0.0493;
    3.0, 0.0396;
    4.0, 0.0339;
    5.0, 0.0301;
    6.0, 0.0275;
    8.0, 0.0240;
    10, 0.0219;
    15, 0.0190;
    20, 0.0177;
    30, 0.0166;
    40, 0.0162;
    50, 0.0161;
    60, 0.0161;
    80, 0.0163;
    100, 0.0166];

airMassAttenuationCoefficients = [...
    0.01, 4.89;
    0.015, 1.48;
    0.02, 0.697;
    0.03, 0.317;
    0.04, 0.226;
    0.05, 0.194;
    0.06, 0.178;
    0.08, 0.161;
    0.10, 0.151;
    0.15, 0.134;
    0.20, 0.123;
    0.30, 0.106;
    0.40, 0.0953;
    0.50, 0.0868;
    0.60, 0.0804;
    0.80, 0.0706;
    1.0, 0.0635;
    1.5, 0.0517;
    2.0, 0.0445;
    3.0, 0.0357;
    4.0, 0.0307;
    5.0, 0.0274;
    6.0, 0.0250;
    8.0, 0.0220;
    10, 0.0202;
    15, 0.0178;
    20, 0.0166;
    30, 0.0158;
    40, 0.0156;
    50, 0.0157;
    60, 0.0158;
    80, 0.0160;
    100, 0.0164];

waterMassCoeffVal = findInterpolatedValue(waterMassAttenuationCoefficients, photonEnergy);
airMassCoeffVal = findInterpolatedValue(airMassAttenuationCoefficients, photonEnergy);

waterLinearCoeffVal = waterMassCoeffVal * waterDensity;
airLinearCoeffVal = airMassCoeffVal * airDensity;

% convert to m^-1 from cm^-1
waterCoeff = waterLinearCoeffVal * 100;
airCoeff = airLinearCoeffVal * 100;

end

function coeffVal = findInterpolatedValue(energyAndCoeffValues, energyVal)
    coeffVal = [];

    for i=1:length(energyAndCoeffValues)-1
        lowEnergy = energyAndCoeffValues(i,1);
        highEnergy = energyAndCoeffValues(i+1,1);
        
        if energyVal >= lowEnergy && energyVal <= highEnergy
            lowCoeff = energyAndCoeffValues(i,2);
            highCoeff = energyAndCoeffValues(i+1,2);
            
            slope = (highCoeff-lowCoeff) / (highEnergy-lowEnergy);
            
            % interpolate val between two set points
            coeffVal = lowCoeff + slope*(energyVal-lowEnergy);
            
            break;
        end
    end
    
    if isempty(coeffVal)
        error('Photon energy is outside of calibrated range.');
    end
end