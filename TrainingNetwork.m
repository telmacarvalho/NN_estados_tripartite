clear all;
clc;

% Introdução de dados para a Rede Neural
load('Wa_peso.mat');
load('tripartite.mat');
load('Wtripartite_classification_biseparable.mat');

% Ajuste para entrada de dados tripartite
input = tripartite;
W_PPT = Wtripartite_classification_biseparable;
W_Peso = Wa_peso;

%  Definindo a porcentagem de dados usados em cada etapa
total = 1001;
n = round(total*0.7); % 70% dos dados serão usados para treinamento e 30% para teste
% Dados para a fase de treinamento
N =  randperm(total,n);
for k = 1:n
    N1 = N(1,k);
    input_Data(k, :) = input(N1, :);
    correct_Output(k, :) = W_PPT(N1, :);
end
% Dados para a fase de teste
for j = 1:total
    if (j ~= N)
        T(j) = j;
    else
        T(j) = 0;
    end
end
t = nonzeros(T)';
for m = 1: size(t,2)
    T1 = t(1,m);
    input_Data_test(m, :) = input(T1, :);  
    correct_Output_test(m, :) = W_PPT(T1, :);
    peso_test_tripartite_biseparable(m, :) = W_Peso(T1, :);
    T2 = ismember(T1,N);
    assert(T2 == 0)
end

% Criando os pesos iniciais de maneira aleatória
w1 = 2*rand(10, 64)-1;
w2 = 2*rand(1, 10)-1;

for epoch = 1:10000
    [w1, w2] = NeuralNetwork(w1, w2, input_Data, correct_Output,n);
end
      
save('NeuralNetwork.mat')
disp('Treinamento finalizado.')