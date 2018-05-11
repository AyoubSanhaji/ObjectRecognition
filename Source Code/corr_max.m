function numclass = corr_max(Ima_test)
    
    nb_ima = 100;
    % t est un tableau dont on voit la correspondance entre l'image
    % requete et les images d'apprentissages
    t = zeros(20,2);
    chemin = '\';
    ima_label = 0;
    nb_image = 25;
    
    % Decomposition de l'image requete par composante
    Ima_testR = Ima_test(:,:,1);
    Ima_testG = Ima_test(:,:,2);
    Ima_testB = Ima_test(:,:,3);
    i = 1;
    
    for i_train = 1 : nb_ima
        if ( ((1<=i_train)&&(i_train<=5)) || ((31<=i_train)&&(i_train<=35)) || ((61<=i_train)&&(i_train<=65)) || ((91<=i_train)&&(i_train<=95)) )
            ima_label = ima_label+1;
            num_classe(ima_label) = floor((i_train-1)/nb_image)+1;
            if (i_train/10 < 1)
                    fichier_train = [chemin '00' int2str(i_train) '.png'];
                else
                    if (i_train/100 < 1)
                        fichier_train = [chemin '0' int2str(i_train) '.png'];
                    else
                        fichier_train = [chemin '' int2str(i_train) '.png'];
                    end 
            end
            % Ouverture de l'image d'apprentissage (une par une)
            Ima_train = imread(fichier_train);
            % Decomposition de l'image d'apprentissage par composante
            Ima_trainR = Ima_train(:,:,1);
            Ima_trainG = Ima_train(:,:,2);
            Ima_trainB = Ima_train(:,:,3);
            
            % Remplissage de t
            % (1 colonne: Classe des images de bdd)
            t(ima_label,1) = num_classe(ima_label);
            % (2 colonne: la correlation entre l'image requete et toutes les images d'apprentissage)
            t(i,2) = corr2(Ima_trainR,Ima_testR);
            i = i+1;
        end 
    end
    indice = find((t(:,2) == max(t(:,2))));  
    numclass = t(indice,1);   
end