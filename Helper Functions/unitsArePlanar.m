function bool = unitsArePlanar(dimensions)
% bool = unitsArePlanar(dimensions)
% returns true if all units in vector of dimensions are non-angular

bool = true;

for i=1:length(dimensions)
    units = dimensions(i).units;
    
    if units.isAngular()
        bool = false;
        break;
    end
end


end

