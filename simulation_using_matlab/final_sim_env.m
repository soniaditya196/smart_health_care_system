function [N,data] = final_sim_env(size,app,a_no,n_no,Node,Config)

    node=Node;
    for app_id = 1:app
        app_delay(app_id) = 0;
        start = randi([2,Config.N+1]);
        startActual = start;                                 
        %layer = 1;
        for l = 1:Config.L
            flag = 0;
            start = startActual;                             
            if ~ismember(l, node(start).layerID)
                flag = 1;                                    
                for n = 1:length(node(start).dest)
                    desti = node(start).dest(n);             
                    if ismember(l, node(desti).layerID) && (node(desti).E_res > Config.E_th)
                        hopcount = node(start).hop(n);   
                        nnd = node(start).nextnodeDist(n);
                        while (1)
                            hopcount = hopcount - 1;         
                            app_delay(app_id) = app_delay(app_id)+ (size/Config.datarate)+ size*1048576*nnd/Config.c; %% Transmission, propagation delay 
                            node(start).E_res = node(start).E_res - Config.E_consumpComput(l)*size/Config.datarate;
                            if (hopcount == 0)
                                break;
                            else
                                start = node(start).nextnode(n);    
                                index = find(node(start).dest == desti);
                                nnd = node(start).nextnodeDist(index);
                            end	
                        end
                        app_delay(app_id) = app_delay(app_id) + Config.L_consumpComput(l)+ size/node(desti).processSpeed; % processing
                        node(desti).E_res = node(desti).E_res - Config.E_consumpComput(l); 

                        flag = 0;
                    end
                    if ~flag
                        break;
                    end
                end
                if flag
                    disp('cloud')
                    app_delay(app_id) = app_delay(app_id) + (size/Config.datarate)+ size*1048576*node(start).cloudDist/Config.c + size/node(1).processSpeed;
                    node(start).E_res = node(start).E_res - Config.E_consumpComput(l)*size/Config.datarate;
                    flag = 0;
                end
            else
                app_delay(app_id) = app_delay(app_id) + Config.L_consumpComput(l) + size/node(start).processSpeed;
                node(start).E_res = node(start).E_res - Config.E_consumpComput(l);
            end
        end

        %% for Traditional Cloud

        start = startActual;
        app_delayTrad(app_id) = 0;
        app_delayTrad(app_id) = app_delayTrad(app_id) +  (size/Config.datarate) + node(start).cloudDist/Config.c;
        for l = 1:Config.L
            app_delayTrad(app_id) = app_delayTrad(app_id) + Config.L_consumpComput(l) + size/node(1).processSpeed;
        end
    end
    
    res=[];
    
    for i=2:Config.N+1
        res=horzcat(res,node(i).E_res);
    end
    
    avg_res=mean(res);
    avg_del=mean(app_delay);
    avg_delT=mean(app_delayTrad);
    
    data=[n_no,a_no,size,app,avg_res,avg_del,avg_delT];
    N=node;

end

