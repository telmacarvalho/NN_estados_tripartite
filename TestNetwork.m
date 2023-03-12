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
    elseif (dados_parciais == 'SzSx_inteiro')
        result_SzSx_erro(k, :) = round(final_output)';
        % Porcentagem de acertos na classificação
        cont = isequal(result_SzSx_erro(k, :), correct_Output_test(k, :));
        percent_SzSx_erro = percent + cont;
        percent = percent_SzSx_erro;
    elseif (dados_parciais == 'SzSx_parcial')
        result_SzSxParcial_erro(k, :) = round(final_output)';
        % Porcentagem de acertos na classificação
        cont = isequal(result_SzSxParcial_erro(k, :), correct_Output_test(k, :));
        percent_SzSxParcial_erro = percent + cont;
        percent = percent_SzSxParcial_erro;
    elseif (dados_parciais == 'Sz___inteiro')
        result_SzOnly_erro(k, :) = round(final_output)';
        % Porcentagem de acertos na classificação
        cont = isequal(result_SzOnly_erro(k, :), correct_Output_test(k, :));
        percent_SzOnly_erro = percent + cont;
        percent = percent_SzOnly_erro;
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
elseif (dados_parciais == 'SzSx_inteiro')
    percent_SzSx_erro = percent_SzSx_erro/size(input_Data_test, 1)*100;
    save('result_SzSx_erro.mat', 'result_SzSx_erro');
    save('peso_test_SzSx_erro.mat', 'peso_test_SzSx_erro');
    % Comparação do resultado com as respostas corretas
    check = isequal(result_SzSx_erro, correct_Output_test);
        if (check == 1)
            disp('A rede neural acertou todas as classificações com medição contendo erro nos intrumentos ópticos em Sz e Sx.');
        else
            fprintf('A rede neural acertou %.1f por cento das classificações com medição contendo erro nos intrumentos ópticos em Sz e Sx.', percent_SzSx_erro);
        end            
elseif (dados_parciais == 'SzSx_parcial')
    percent_SzSxParcial_erro = percent_SzSxParcial_erro /size(input_Data_test, 1)*100;
    save('result_SzSxParcial_erro.mat', 'result_SzSxParcial_erro');
    save('peso_test_SzSxParcial_erro.mat', 'peso_test_SzSxParcial_erro');
    % Comparação do resultado com as respostas corretas
    check = isequal(result_SzSxParcial_erro, correct_Output_test);
        if (check == 1)
            disp('A rede neural acertou todas as classificações com medição contendo erro nos intrumentos ópticos em Sz e parcialmente em Sx.');
        else
            fprintf('A rede neural acertou %.1f por cento das classificações com medição contendo erro nos intrumentos ópticos em Sz e e parcialmente em Sx.', percent_SzSxParcial_erro);
        end
elseif (dados_parciais == 'Sz___inteiro')
        percent_SzOnly_erro = percent_SzOnly_erro /size(input_Data_test, 1)*100;
        save('result_SzOnly_erro.mat', 'result_SzOnly_erro');
        save('peso_test_SzOnly_erro.mat', 'peso_test_SzOnly_erro');
        % Comparação do resultado com as respostas corretas
        check = isequal(result_SzOnly_erro, correct_Output_test);
            if (check == 1)
                disp('A rede neural acertou todas as classificações com medição contendo erro nos intrumentos ópticos apenas em Sz.');
            else
                fprintf('A rede neural acertou %.1f por cento das classificações com medição contendo erro nos intrumentos ópticos apenas em Sz.', percent_SzOnly_erro);
            end
end