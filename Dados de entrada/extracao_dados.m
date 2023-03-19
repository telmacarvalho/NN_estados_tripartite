clc;
clear all;

% Importa os dados
load('Sigmaz.txt');

% Define início e término de cada matriz
linha_inicial = 1;
linha_final = 8;

% Determina o inínio do parâmetro de variação a
parametro = -0.001;

% Armazena todas as matrizes dentro de células
for n = 1:1001
    estados = Sigmaz(linha_inicial:linha_final,1:8);
    % Armazena matrizes no formato 8 x 8 dentro de uma lista
    tripartite1 = reshape(estados, 8, 8);
    estados_tripartite{n,1} = tripartite1;
    % Armazena matrizes no formato 1 x 64 para alimentar a rede neural
    tripartite(n,1:64) = reshape(estados, 1, 64);
    linha_inicial = linha_final + 1;
    linha_final = linha_final + 8;
    % Variação do parâmetro a
    a = parametro + 0.001;
    a_peso(n,1) = a;
    parametro = a;
end

save('estados_tripartite.mat', 'estados_tripartite');
save('a_peso.mat', 'a_peso');
save('tripartite.mat','tripartite');
