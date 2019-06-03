function window = getMaxImageWindow(image)
%function window = getMaxImageWindow(image)

window = [min(min(image)), max(max(image))];

end

