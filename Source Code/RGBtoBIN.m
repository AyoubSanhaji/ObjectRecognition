function [ imbin2 ] = RGBtoBIN( img )
    
    % Determination du seuil de facon automatique
    seuil = graythresh(img)+0.17;
    % Binarisation
    imbin = im2bw(img , seuil);
    % Inversion des bites noirs en blanc et vice versa
    imbininv = imcomplement(imbin);
    % Elimination des regions de petites surfaces
    imbin1 = bwareaopen(imbininv,870);
    % Application d'une fermeture
    imbin1 = imclose(imbin1 , strel('disk',3));
    % Elimination des regions qui sont au contact des bords de l'image
    imbin2 = imclearborder(imbin1);

end

