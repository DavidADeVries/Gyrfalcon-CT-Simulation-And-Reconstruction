object = load('C:\Users\MPRadmin\Git Repos\Gyrfalcon Data\Phantoms\Head CT (512x512x144).mat');
object = object.object;
oldData = object.data;

data = zeros(50,50,47);

r_del = 8;
c_del = 8;
s_del = 3;

for r=1:50
    for c=1:50
        for s=1:47
            r_start = 112 + (r-1)*r_del;
            c_start = 112 + (c-1)*c_del;
            s_start = 1 + (s-1)*s_del;
            
            value = sum(sum(sum(oldData(...
                r_start:r_start+r_del,...
                c_start:c_start+c_del,...
                s_start:s_start+s_del)))) ./ (r_del*c_del*s_del);
                        
            data(r,c,s) = value;
        end
    end
end

object.data = data;
disp('Done');
        