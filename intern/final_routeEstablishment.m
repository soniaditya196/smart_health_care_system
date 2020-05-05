function [N] = final_routeEstablishment(Config,Node,special_AP_ID)

    node=Node;

    s=[];
    t=[];
    w=[];

    % connecting every edge nodes to its nearest AP

    for i=2:Config.N_Edge+1
        for j = 1:length(node(i).nearest_AP)
            s = [s node(i).ID];
            t = [t node(i).nearest_AP(j)];
            w = [w node(i).nearest_AP_dist(j)];
        end
    end

    % connecting every AP with its neighbour AP

    for i = Config.N_Edge+2 :  Config.N_Edge + Config.N_Access+1
        for j = 1:length(node(i).neighbour_AP)
            if ~(i==j)
                s = [s node(i).ID];
                t = [t node(i).neighbour_AP(j)];
                w = [w node(i).neighbour_AP_dist(j)];
            end
        end
    end

    % connecting every AP with its neighbour fog


    for i = Config.N_Edge+2: Config.N_Edge + Config.N_Access+1
        for j = 1:length(node(i).neighbour_fog)
            s = [s node(i).ID];
            t = [t node(i).neighbour_fog(j)];
            w = [w node(i).neighbour_fog_dist(j)];
        end
    end

    % creating the directed graph
    G = digraph(s,t,w);  
    plot(G);


    % finding shortest route from every edge node to the cloud
    for i=2:Config.N_Edge+1
       [node(i).route_to_cloud , node(i).route_to_cloud_len] = shortestpath(G , node(i).nearest_AP , special_AP_ID(1));
       [node(i).route_to_cloud] = [node(i).route_to_cloud 1];
       [node(i).route_to_cloud] = [node(i).ID node(i).route_to_cloud];
    end
    

    % finding shortest route from every edge node to its nearest fog node
    for i=2:Config.N_Edge+1
        [node(i).route_to_nearest_fog ,node(i).route_to_nearest_fog_len] = shortestpath(G , node(i).route_to_cloud(1) , node(i).nearest_fog);
    end


    
    % [p,len] = shortestpath(G,sourceID,destID);



    N=node;

end

