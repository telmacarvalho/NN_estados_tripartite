clc;
clear all;

load('Westados_tripartite');


% Conversão de dados
for i=1:1001
    estados_tripartite1 = reshape(Westados_tripartite, 1, 64);
    estados_tripartite2 = real(estados_tripartite1);
    estados_tripartite(i, 1:64) = (estados_tripartite2);    
end


