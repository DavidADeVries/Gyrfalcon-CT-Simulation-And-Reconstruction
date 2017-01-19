function bool = valueWithinRange(val, range)
% bool = valueWithinRange(val, range)
% checks whether val is in range (may equal range values)

within1 = val >= range(1) && val <= range(2);
within2 = val <= range(1) && val >= range(2);

bool = within1 || within2;


end

