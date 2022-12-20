function [Config] = final_getEnviroment(a,N,N_Edge,N_fog,N_Access)                              %a denotes which algorithm wwe will use to reduce data
                                                                                                 % N=TOTAL NODES

    disp('Environment initialization !!');
    temp.N=N;
    temp.N_Edge = N_Edge;  
    temp.N_fog = N_fog;
    temp.N_Access = N_Access;
    temp.len = 1000;                                                                         
    temp.width = 1000;                                                                       
    temp.datarate = 1000;                                                                     
    
    if a == 1
       temp.E_consumpComput =  0.000241573 ;   % for linear regression Energy
    elseif a == 2
       temp.E_consumpComput =  0.000198787 ;   % for SVM Energy
    else
       temp.E_consumpComput =  0.000133496 ;   % for DT Energy
    end
    
    temp.E_th = 0;                                                                            
    temp.c=299792458;                                                                         
    temp.restrictedHop = 30;                                                                 

    Config=temp;

end

