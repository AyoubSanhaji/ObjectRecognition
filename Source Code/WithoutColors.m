clc;
clear all;
close all;

tic


%% Apprentissage
nb_classe = 4;
nb_image = 25;
chemin = '\Pics';
nb_ima = nb_classe*nb_image;
nb_img_train = nb_ima/5;
Attributs = zeros(nb_img_train , 8);
ima_label = 0;

% Matrice de confusion
mat_conf = zeros(100,3);
taux = 0;

% tab (20 lignes: images de la bdd)
% (1 colonne: num de classe)
% (2:end colonnes: les attributs(3 4 5 7))
tab = zeros(20,5);

for i_train = 1 : nb_ima
    if ( ((1<=i_train)&&(i_train<=5)) || ((31<=i_train)&&(i_train<=35)) || ((61<=i_train)&&(i_train<=65)) || ((91<=i_train)&&(i_train<=95)) )
        
        % Incrementaion du label a chaque iteration
        ima_label = ima_label+1;
        
        % Enreg du numero de la classe ds un tableau
        num_classe(ima_label) = floor((i_train-1)/nb_image)+1;
       
        % Concatenation des chaines de caracteres pour le chemin d'acces
        if (i_train/10 < 1)
            fichier_train = [chemin '00' int2str(i_train) '.png'];
        else
            if (i_train/100 < 1)
                fichier_train = [chemin '0' int2str(i_train) '.png'];
            else
                fichier_train = [chemin '' int2str(i_train) '.png'];
            end
        end
        
        % Affichage du num de classe
        disp([fichier_train ' Classe ' int2str(num_classe(ima_label))]);
       
        % Ouverture de l'image d'apprentissage
        Ima_train = imread(fichier_train);
        
        % Extraction des attributs de forme
        Attributs(ima_label,:) = AttributsForme(Ima_train);
        attReduits(ima_label,:) = Attributs(ima_label,[3 4 5 7]);
        
        % Remplissage de tab
        % (1 colonne: num de classe)
        tab(ima_label,1) = num_classe(ima_label);
        % (2:end colonnes: les attributs(3 4 5 7))
        tab(ima_label,2:end) = attReduits(ima_label,:);
    end 
end

% Le choix des variables pour grouper chaque classe 
var1 =  Attributs(:,5)+Attributs(:,2);
x = (var1-mean(var1))/std(var1);
var2 =  Attributs(:,3)+Attributs(:,7);
y = (var2-mean(var2))/std(var2);

% Visualisation de nuages des points
figure(1)
d = scatter(x,y,2*num_classe,num_classe,'filled' ,'LineWidth',1.5); 


%% Test
for i_train = 1 : nb_ima
    if ( ((1<=i_train)&&(i_train<=100)))
        
        % Incrementaion du label a chaque iteration
        ima_label = ima_label+1;
       
        %Enreg du numero de la classe ds un tableau
        num_classe(ima_label) = floor((i_train-1)/nb_image)+1;
        
        % Construction de la matrice de confusion 
        % (1 colonne: Classe réelle)
        mat_conf(i_train,1) = num_classe(ima_label);
        
        %Concatenation des chaines de caracteres pour le chemin d'acces
        if (i_train/10 < 1)
            fichier_train = [chemin '00' int2str(i_train) '.png'];
        else
            if (i_train/100 < 1)
                fichier_train = [chemin '0' int2str(i_train) '.png'];
            else
                fichier_train = [chemin '' int2str(i_train) '.png'];
            end
        end
        
        % Construction de la matrice de confusion
        % (2 colonne: num de l'image)
        mat_conf(i_train,2) = i_train;
        
        % Ouverture de l'image a testé
        Ima_train = imread(fichier_train);
        
        % Construction de la matrice de confusion
        % (3 colonne: distance Euclidienne)
        mat_conf(i_train,3) = algo1_ppv_euclidienne(Ima_train,tab);
        
        % (3 colonne: distance de Manhattan)
        %mat_conf(i_train,3) = algo1_ppv_Manhattan(Ima_train,tab);
        
        % Si la classe réelle = le classe estimée on incremente le taux
        if mat_conf(i_train,3) == mat_conf(i_train,1)
            taux = taux+1;
        end
    end 
end


toc