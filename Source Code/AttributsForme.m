% Recuperation des differents attributs de forme
function [res] = AttributsForme(img)

    i = RGBtoBIN(img);
    
    tmp = regionprops(i,'Area','Perimeter','EquivDiameter','MajorAxisLength','MinorAxisLength','Orientation','Centroid');
    a = tmp.Area;
    b = tmp.Centroid(1);
    c = tmp.Centroid(2);
    d = tmp.MajorAxisLength;
    e = tmp.MinorAxisLength;
    f = tmp.Orientation;
    g = tmp.EquivDiameter;
    h = tmp.Perimeter;
    
    res=[a,b,c,d,e,f,g,h];
    
end

