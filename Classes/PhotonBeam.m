classdef PhotonBeam
    % PhotonBeam
    % This class contains all the data pertaining to a beam of photons
    % 
    % FIELDS:
    % *energy:
    % the energy of one photon in the beam, measured in keV (electron volts)
    %
    % *intensity:
    % the intensity of the photons at the photonEnergy, measured in W/m^2
    
    
    
    properties
        energy
        intensity
    end
    
    methods
        function beam = PhotonBeam(energy, intensity)
            beam.energy = energy;
            beam.intensity = intensity;
        end
        
        function finalIntensity = modelAbsorption(photonBeam, absorptionValues, absorptionValueDistances)
            % STEP 1
            % sum over absorption values times distance
            
            absorptionSum = sum(absorptionValues .* absorptionValueDistances);
            
            % STEP 2
            % apply Lambert-Beer's Law
            
            finalIntensity = photonBeam.intensity .* exp(-absorptionSum);
        end
    end
    
end

