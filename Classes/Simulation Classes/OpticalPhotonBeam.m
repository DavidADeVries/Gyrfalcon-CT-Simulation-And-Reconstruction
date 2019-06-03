classdef OpticalPhotonBeam < GyrfalconObject
    % OpticalPhotonBeam
    % This class contains all the data pertaining to a beam of optical photons
    % 
    % FIELDS:
    % *wavelengths:
    % the wavelengths of the optical photons (measured in nm)
    %
    % *intensities:
    % the intensities of the photons at the energies, measured in W/m^2
    
    properties
        wavelengthsInNm
        intensities
    end
    
    methods
        function beam = OpticalPhotonBeam(wavelengths, intensities)
            if nargin > 0
                beam.wavelengthsInNm = wavelengths;
                beam.intensities = intensities;                
            end
        end
        
        function photonBeam = createBlankObject(photonBeam)
            photonBeam = OpticalPhotonBeam;
        end
                
        function name = displayName(photonBeam)
            name = 'Optical Photon Beam';
        end
        
        function photonBeam = setDefaultValues(photonBeam)
            photonBeam.wavelengthsInNm = [];
            photonBeam.intensities = [];
        end
        
        function [saved, beamForGUI, beamForParent, beamForSaving] = saveChildrenObjects(beam, defaultSavePath)
            beamForGUI = beam;
            beamForParent = beam;
            beamForSaving = beam;
            
            saved = true;
        end
        
        function photonBeam = loadFields(photonBeam, defaultLoadPath)
        end 
        
        
        function name = defaultName(photonBeam)
            minWavelength = min(photonBeam.wavelengthsInNm);
            maxWavelength = max(photonBeam.wavelengthsInNm);
            
            minIntensity = min(photonBeam.intensities);
            maxIntensity = max(photonBeam.intensities);
            
            if minWavelength == maxWavelength
                energyString = [num2str(minWavelength), ' nm'];
            else
                energyString = [num2str(minWavelength), '-', num2str(maxWavelength), ' nm'];
            end
            
            if minIntensity == maxIntensity
                intensityString = [num2str(minIntensity), ' Wm-2'];
            else
                intensityString = [num2str(minIntensity), '-', num2str(maxIntensity), ' Wm-2'];
            end
            
            fileName = [Constants.Default_Photon_Beam_Name, ' (', energyString, ', ', intensityString, ')'];
            
            name = [fileName, Constants.Matlab_File_Extension];            
        end
        
        function bool = equal(beam1, beam2)
            b1 = matricesEqual(beam1.wavelengthsInNm, beam2.wavelengthsInNm);
            b2 = matricesEqual(beam1.intensities, beam2.intensities);
            
            
            bool = b1 && b2;
        end
                
        function app = setGUI(photonBeam, app)   
        end
        
        function photonBeam = createFromGUI(photonBeam, app)
        end
    end
    
end

