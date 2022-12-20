function [N,special_AP_ID] = final_getNetwork(Config, Node)
    disp('Neighbour Finding !!');
    node=Node;
    
        
    %%  Neighbour finding for F-->AP
    for i = Config.N_Edge+2: Config.N_Edge + Config.N_Access+1
        for j = Config.N_Edge + Config.N_Access+2 : Config.N_Edge + Config.N_Access + Config.N_fog+1
            dist = sqrt((node(i).x - node(j).x)^2 + (node(i).y - node(j).y)^2);
            if dist <= node(j).comm
                node(i).neighbour_fog = [node(i).neighbour_fog node(j).ID]
                node(i).neighbour_fog_dist = [node(i).neighbour_fog_dist dist];
            end
        end
    end
    
    
    %% finding the Nearest Neighbour fog for each E--->F 
    %% pehle E--->F connect karo jo nearest hai, uske baad waha tak jane ka raasta hoga usko nikalo
    
    for i = 2:Config.N_Edge+1
        dist_min = 20000;
        for j = Config.N_Edge + Config.N_Access+2 : Config.N_Edge + Config.N_Access + Config.N_fog+1
            dist = sqrt((node(i).x - node(j).x)^2 + (node(i).y - node(j).y)^2);
            if dist <= node(i).comm && dist<dist_min
            dist_min=dist;
            index=node(j).ID;
            end
        end
        % disp(index);
        node(i).nearest_fog = [node(i).nearest_fog index];
        node(i).nearest_fog_dist = [node(i).nearest_fog_dist dist_min];
    end
    
    
     %% finding the Nearest AP for each E--->AP 
    for i = 2:Config.N_Edge+1
        dist_min = 20000;
         for j = Config.N_Edge+2 :  Config.N_Edge + Config.N_Access+1
            dist = sqrt((node(i).x - node(j).x)^2 + (node(i).y - node(j).y)^2);
            if dist <= node(i).comm && dist<dist_min
            dist_min=dist;
            index=node(j).ID;
            end
        end
        % disp(index);
        node(i).nearest_AP = [node(i).nearest_AP index];
        node(i).nearest_AP_dist = [node(i).nearest_AP_dist dist_min];
    end


    %% Neighbour finding for AP--->AP
    for i = Config.N_Edge+2 :  Config.N_Edge + Config.N_Access+1
        for j = Config.N_Edge+2 :  Config.N_Edge + Config.N_Access+1
            if ~(i==j)
                dist = sqrt((node(i).x - node(j).x)^2 + (node(i).y - node(j).y)^2);
                if dist <= node(i).comm
                    node(i).neighbour_AP = [node(i).neighbour_AP node(j).ID];
                    node(i).neighbour_AP_dist = [node(i).neighbour_AP_dist dist];
                end
            end
        end
    end
    
    
    %% Neighbour finding for AP--->C
  
    dist_min=20000;
    for i = Config.N_Edge+2 : Config.N_Edge + Config.N_Access+1
        dist = sqrt((node(i).x - node(1).x)^2 + (node(i).y - node(1).y)^2);
        if dist <= node(i).comm && dist<dist_min
            dist_min=dist;
            index1=node(i).ID; 
        end
    end
    %disp(index);
    special_AP_ID = index1;
    node(1).nearest_AP = special_AP_ID;
    node(1).nearest_AP_dist = dist_min;
    %disp(special_AP_ID);
    
    
    
    N=node;
    
end

