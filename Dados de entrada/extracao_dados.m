clc;
clear all;

% Importa os dados
load('Wtripartite.txt');

% Define início e término de cada matriz
linha_inicial = 1;
linha_final = 8;

% Determina o inínio do parâmetro de variação a
parametro = -0.001;

% Armazena todas as matrizes dentro de células
for n = 1:1001
    estados = Wtripartite(linha_inicial:linha_final,1:8);
    tripartite1 = reshape(estados, 8, 8);
    Westados_tripartite{n,1} = tripartite1;
    linha_inicial = linha_final + 1;
    linha_final = linha_final + 8;
    % Variação do parâmetro a
    a = parametro + 0.001;
    Wa_peso(n,1) = a;
    parametro = a;
end

save('Westados_tripartite.mat', 'Westados_tripartite');
save('Wa_peso.mat', 'Wa_peso');
