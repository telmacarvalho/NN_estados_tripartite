clear all;
clc;

% Introdução de dados para a Rede Neural
error_angle = 'S';
dados_parciais = 'Sz___inteiro';
if (error_angle == 'N')
    load('W_parcial_SzSy.mat');
    load('W_parcial_SzSx.mat');
    load('W_parcial_SzSxParcial.mat');
    if (dados_parciais == 'SzSy_inteiro')
        input = W_parcial_SzSy;
    elseif (dados_parciais == 'SzSx_inteiro')
        input = W_parcial_SzSx;
    elseif (dados_parciais == 'SzSx_parcial')
        input = W_parcial_SzSxParcial;
    end
elseif (error_angle == 'S')
    load('W_parcial_SzSy_erro.mat');
    load('W_parcial_SzSx_erro.mat');
    load('W_parcial_SzSxParcial_erro.mat');
    load('W_parcial_SzOnly_erro')
    if (dados_parciais == 'SzSy_inteiro')
        input = W_parcial_SzSy_erro;
    elseif (dados_parciais == 'SzSx_inteiro')
        input = W_parcial_SzSx_erro;
    elseif (dados_parciais == 'SzSx_parcial')
        input = W_parcial_SzSxParcial_erro;
    elseif (dados_parciais == 'Sz___inteiro')
        input = W_parcial_SzOnly_erro;
    end
end
load('W_PPT.mat');
load('W_Peso.mat');

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
    if (error_angle == 'N')
        if (dados_parciais == 'SzSy_inteiro')
             peso_test_SzSy(m, :) = W_Peso(T1, :);
        elseif (dados_parciais == 'SzSx_inteiro')
             peso_test_SzSx(m, :) = W_Peso(T1, :);
        elseif (dados_parciais == 'SzSx_parcial')
             peso_test_SzSxParcial(m, :) = W_Peso(T1, :);
        end
    elseif (error_angle == 'S')
        if (dados_parciais == 'SzSy_inteiro')
             peso_test_SzSy_erro(m, :) = W_Peso(T1, :);
        elseif (dados_parciais == 'SzSx_inteiro')
             peso_test_SzSx_erro(m, :) = W_Peso(T1, :);
        elseif (dados_parciais == 'SzSx_parcial')
             peso_test_SzSxParcial_erro(m, :) = W_Peso(T1, :);
        elseif (dados_parciais == 'Sz___inteiro')
             peso_test_SzOnly_erro(m, :) = W_Peso(T1, :);
        end
    end
    T2 = ismember(T1,N);
    assert(T2 == 0)
end

% Criando os pesos iniciais de maneira aleatória
w1 = 2*rand(10, 16)-1;
w2 = 2*rand(1, 10)-1;

for epoch = 1:10000
    [w1, w2] = NeuralNetwork(w1, w2, input_Data, correct_Output,n);
end
      
save('NeuralNetwork.mat')
disp('Treinamento finalizado.')