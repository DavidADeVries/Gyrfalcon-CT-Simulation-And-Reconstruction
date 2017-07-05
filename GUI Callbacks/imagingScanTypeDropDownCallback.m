function [] = imagingScanTypeDropDownCallback(app)
%[] = imagingScanTypeDropDownCallback(app)

imagingScan = app.ImagingScanTypeDropDown.Value.imagingScanObject;

imagingScan = imagingScan.setDefaultValues();

imagingScan.setGUI(app);

end

