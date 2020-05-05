function [Node] = final_node(Config)
    
    disp("Node intialization")
    %% Cloud node
    disp('Cloud initialization !!');
    node(1).ID = 1;
    node(1).x = 500;
    node(1).y = 500;
    node(1).E_max = Inf;
    node(1).E_res = node(1).E_max;
    node(1).process_speed = 100; 
    node(1).nearest_AP = [];
    node(1).nearest_AP_dist = [];


    
    %%  Edge nodes
    disp("Edge Nodes initialisation !!");
    for i = 2:Config.N_Edge+1
        node(i).ID = i;
        node(i).x = unifrnd(0,Config.len,[1,1]);                       
        node(i).y = unifrnd(0,Config.width,[1,1]);                      
        node(i).comm = 300;                                             
        node(i).E_max = 20;                                          
        node(i).E_res = node(i).E_max;
        node(i).nearest_AP = [];
        node(i).nearest_AP_dist = [];
        node(i).nearest_fog = [];
        node(i).nearest_fog_dist = [];
        node(i).route_to_nearest_fog=[];
        node(i).route_to_nearest_fog_len=[];
        node(i).route_to_cloud=[];
        node(i).route_to_cloud_len=[];
        node(i).dist_cloud = sqrt((node(i).x - node(1).x)^2 + (node(i).y - node(1).y)^2);
        node(i).process_speed = 30;
        node(i).neighbour_AP = [];
        node(i).neighbour_AP_dist = [];
    end
    
    %% Access points
    disp('Access points !!');
    for i = Config.N_Edge+2: Config.N_Edge + Config.N_Access+1
        node(i).ID = i;
        node(i).x = unifrnd(0,Config.len,[1,1]);                       
        node(i).y = unifrnd(0,Config.width,[1,1]);                      
        node(i).comm = 400;                                            
        node(i).E_max = 10;                                           
        node(i).E_res = node(i).E_max; 
        node(i).neighbour_AP=[];
        node(i).neighbour_AP_dist=[];
        node(i).neighbour_fog=[];
        node(i).neighbour_fog_dist=[];
        node(i).dist_cloud = sqrt((node(i).x - node(1).x)^2 + (node(i).y - node(1).y)^2);
        node(i).process_speed = 10;
    end


    %% fog nodes
    disp('Fog nodes Initialisation !!');
    for i = Config.N_Edge + Config.N_Access+2 : Config.N_Edge + Config.N_Access + Config.N_fog+1
        node(i).ID = i;
        node(i).x = unifrnd(0,Config.len,[1,1]);                       
        node(i).y = unifrnd(0,Config.width,[1,1]);                      
        node(i).comm = 200;                                            
        node(i).E_max = 40;                                             
        node(i).E_res = node(i).E_max;
        node(i).dist_cloud = sqrt((node(i).x - node(1).x)^2 + (node(i).y - node(1).y)^2);
        node(i).process_speed = 40;
    end
 
    Node=node;
end
