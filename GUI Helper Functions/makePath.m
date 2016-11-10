function path = makePath(varargin)
% path = makePath(varargin)
%takes a series of directories and joins them up with a slash

slash = Constants.Slash;

path = '';

for i=1:length(varargin)
    if ~isempty(varargin{i})
        if isempty(path)
            path = varargin{i};
        else
            path = [path, slash, varargin{i}];
        end
    end
end


end

