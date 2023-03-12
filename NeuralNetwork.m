function  [w1, w2] = NeuralNetworkg(w1, w2, input_Data, correct_Output, n)
alpha =  0.3; % Para controlar a taxa de aprendizagem

for k= 1:n
    input_Data_transposed = input_Data(k, :)'; % Conversão dos dados em uma...
    % matriz com uma única coluna e 16 linhas referente aos valores de cada matriz densidade
    
    input_of_hidden_layer1 = w1*input_Data_transposed; % Entrada de sinal para e 1ª camada de nós.
    output_of_hidden_layer1 = ReLU(input_of_hidden_layer1); % Os sinais que entram na camada
    % oculta são processada pela função de ativação RELU.
     
    input_of_hidden_node = w2*output_of_hidden_layer1; 
    final_output = Sigmoid(input_of_hidden_node); % Os sinais de saída da última 
    % camada serão processados pela função de ativação sigmoid.
    
    correct_Output_transpose = correct_Output(k,:)'; % Transposição da matriz de entrada para 
    % possbilitar o cálculo do erro.
    error = correct_Output_transpose - final_output;
    
    delta = final_output*(1-final_output)*error; % Para aplicar a Regra de Delta. 
    
    error_of_hidden_layer1 = w2'*delta;
    delta1 = input_of_hidden_layer1.*error_of_hidden_layer1;
    
    % Ajuste dos pesos nas camadas ocultas que precisam ser atualizados.
    adjustment_of_w2 = alpha*delta*output_of_hidden_layer1';
    adjustment_of_w1 = alpha*delta1*input_Data_transposed';
    
    % Atualização dos pesos os valores de ajuste
    w1 = w1 + adjustment_of_w1;
    w2 = w2 + adjustment_of_w2;
end

end
