clear all;
clc; 
N=[1200];                           %No of Total nodes (excluding cloud) which includes ( N_Edge+ N_Fog + N_Access )
N_Edge=1000;                        %No of edge nodes
N_fog=100;                          %No of Fog nodes
N_Access=100;                       %No of Access points
A = [1,2,3];                       %No of Algorithm---- the algorithm which we will apply to reduce data in the edge
vol = [500];                       %volume of data of each application (in Mb)  
data = [];

disp('Simulation of NoAA started with different environment parameter');
for n=1:length(N)
    %for a=1:length(A)
        disp('=================================================');
        disp(horzcat('For [N,A]=[',int2str([N(n),A(1)]),']'));
        [Config] = final_getEnviroment(A(1),N,N_Edge,N_fog,N_Access);
        [Node] = final_node(Config);
        [Node,special_AP_ID] = final_getNetwork(Config, Node);
        [Node] = final_routeEstablishment(Config,Node,special_AP_ID);
        for v=1:length(vol)
            disp(horzcat('For [size]=[',int2str([vol(v)]),']'));
            [Node,d] = simulatingenv(vol(v),Node,Config);
            data = vertcat(data, d);
        end
        disp('=================================================');
    %end
end

%% Data=[No_Node, Type of Algorithm, No_DataVol, No_appsize, NoAA_avg_res_E, NoAA_avg_del,Trad_avg_del]
%fileID1 = fopen(['energyConsumtion_JINN' num2str(N) '.txt'],'a+');