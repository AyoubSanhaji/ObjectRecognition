function numclasse = algo1_ppv_euclidienne(img,tab)

    % Recuperation des attributs de formes de l'image requete
    attributs = AttributsForme(img);
    
    % Choix des certains attributs pour avoir un taux de 100%
    attReduits = attributs(:,[3 4 5 7]);
    
    % Description de t 
    % (1 colonne: num de classe des images d'apprentissage)
    % (2 colonne: distance entre les attributs de l'image requete et chacune des images d'appprentissage)
    t=zeros(20,2);
    a = 0;
    
    % Distance euclidienne
    % Centre reduite
%     for i=1:size(tab,1)
%         t(i,1)=tab(i,1);
%         a = (attReduits - tab(i,2:end)) .^ 2;
%         a = [a (a - mean(a)) / std(a)];
%         t(i,2) = sqrt(sum( a ));
%     end;
    
    % Non centre reduite
    for i=1:size(tab,1)
        t(i,1)=tab(i,1);
        t(i,2) = sqrt(sum( (attReduits - tab(i,2:end)) .^ 2 ));
    end;
    
    % Recuperation de num de classe de l'image requete dont la distance est minimale
    indice = find((t(:,2) == min(t(:,2))));  
    numclasse = t(indice,1);
    
end