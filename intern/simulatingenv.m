function [N,data] = simulatingenv(size,Node,Config)

    % energy equation banao
    % linear regression,svm,decision tree
    % cross validation and 100 iterations for delay ko excel sheets me likhna hai
    
    %% traditional cloud
    node=Node;
    for i = 2 : Config.N_Edge+1
        edge_delay_trad(i)=0;

        for j = 1 : ( length(node(i).route_to_cloud) - 1)
            id1 = node(i).route_to_cloud(j);
            id2 = node(i).route_to_cloud(j+1);
            dist = sqrt((node(id1).x - node(id2).x)^2 + (node(id1).y - node(id2).y)^2);
            edge_delay_trad(i) = edge_delay_trad(i) +  (size/Config.datarate) +  dist/Config.c ;  % transmission and propagation delay
            %edge_res_energy_trad() = edge_res_energy_trad(i) - Config.E_consumpComput * size/Config.datarate;
        end
        edge_delay_trad(i) = edge_delay_trad(i) +   size/node(i).process_speed ;     %  processing delay by each edge node
        edge_delay_trad(i) = edge_delay_trad(i) + size/node(1).process_speed;        %  processing delay by cloud
        %edge_res_energy_trad(i) = edge_res_energy_trad
    end

    avg_delay_trad = mean(edge_delay_trad);
    %avg_energy_trad = mean(edge_res_energy_trad);
 


    %% our model

    % edge ---> fog 

    size = size/2;

    for i = 2 : Config.N_Edge + 1
        edge_delay(i)=0;
        for j = 1 : length(node(i).route_to_nearest_fog) - 1
            id1 = node(i).route_to_nearest_fog(j);
            id2 = node(i).route_to_nearest_fog(j+1);
            dist = sqrt((node(id1).x - node(id2).x)^2 + (node(id1).y - node(id2).y)^2);
            edge_delay(i) = edge_delay(i) + size/Config.datarate + dist/Config.c ;                   % transimission delay and propagation delay
            %edge_res_energy(i) = 
        end
        edge_delay(i) = edge_delay(i) + size/node(i).process_speed;
    end

    % edge ---> cloud

    for i = 2 : Config.N_Edge + 1 
        for j = 1 : length(node(i).route_to_cloud) - 1
            id1 = node(i).route_to_cloud(j);
            id2 = node(i).route_to_cloud(j+1);
            dist = sqrt((node(id1).x - node(id2).x)^2 + (node(id1).y - node(id2).y)^2);
            edge_delay(i) = edge_delay(i) + size/Config.datarate + dist/Config.c;                   % transmission and propagation delay
        end

        edge_delay(i) = edge_delay(i) + size / node(i).process_speed ;                              % processing delay by each edge node
        edge_delay(i) = edge_delay(i) + size/ node(1).process_speed;                                % processing delay by cloud
    end 

    avg_delay = mean(edge_delay);
    data = [avg_delay_trad,avg_delay];
    N=node;


end

       
 
     