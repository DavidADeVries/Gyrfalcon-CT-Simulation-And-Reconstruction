function bool = equalWithinBound(val1, val2)
% bool = equalWithinBound(val1, val2)

bool = abs(val1 - val2) <= Constants.Round_Off_Error_Bound;


end

