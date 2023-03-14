clear all,
clc,

load ('NeuralNetwork.mat');
% Definindo os estados que serão testados com dados parciais
dados_parciais = 'biseparable';
percent = 0;
for k = 1:size(input_Data_test, 1)
    % Conversão dos dados de cada estado em uma matriz com uma única coluna e 16 linhas 
    ...referente aos valores de cada matriz densidade.
    input_Data = input_Data_test(k, :)';

    % Enviando o sinal para as camadas ocultas
    input_of_hidden_layer1 = w1*input_Data;
    output_of_hidden_layer1 = ReLU(input_of_hidden_layer1);

    input_of_output_node = w2*output_of_hidden_layer1;
    final_output = Sigmoid(input_of_output_node);
    if (dados_parciais == 'biseparable')
        result_tripartite_biseparable(k, :) = round(final_output)';
         % Porcentagem de acertos na classificação
        cont = isequal(result_tripartite_biseparable(k, :), correct_Output_test(k, :));
        percent_tripartite_biseparable = percent + cont;
        percent = percent_tripartite_biseparable;
    elseif (dados_parciais == 'f_separable')
        result_tripartite_fully_separable(k, :) = round(final_output)';
        % Porcentagem de acertos na classificação
        cont = isequal(result_tripartite_fully_separable(k, :), correct_Output_test(k, :));
        percent_tripartite_fully_separable = percent + cont;
        percent = percent_tripartite_fully_separable;
    end        
end

% Armazenando dos resultados e dos pesos para o gráfico
if (dados_parciais == 'biseparable')
    percent_tripartite_biseparable = percent_tripartite_biseparable/size(input_Data_test, 1)*100;
    save('result_tripartite_biseparable.mat', 'result_tripartite_biseparable');
    save('peso_test_tripartite_biseparable.mat', 'peso_test_tripartite_biseparable');
    % Comparação do resultado com as respostas corretas
    check = isequal(result_tripartite_biseparable, correct_Output_test);
        if (check == 1)
            disp('A rede neural acertou todas as classificações com classificação de biseparabilidade.');
        else
            fprintf('A rede neural acertou %.1f por cento das classificações com classificação de biseparabilidade.', percent_tripartite_biseparable);
        end
elseif (dados_parciais == 'f_separable')
    percent_tripartite_fully_separable = percent_tripartite_fully_separable/size(input_Data_test, 1)*100;
    save('result_tripartite_fully_separable.mat', 'result_tripartite_fully_separable');
    save('peso_test_tripartite_fully_separable.mat', 'peso_test_tripartite_fully_separable');
    % Comparação do resultado com as respostas corretas
    check = isequal(result_tripartite_fully_separable, correct_Output_test);
        if (check == 1)
            disp('A rede neural acertou todas as classificações com classificação total de separabilidade.');
        else
            fprintf('A rede neural acertou %.1f por cento das classificações com classificação total de separabilidade.', percent_tripartite_fully_separable);
        end            
end