clc;
clear all;

load('Westados_tripartite.mat');
load('Wa_peso.mat');

% Aplica critério de biseparabilidade (obs.1 do artigo)
for n = 1:1001
    % Cálculo do lado esquerdo da desigualdade
    element_l1_c8 = sqrt((Westados_tripartite{n}(1,8))^2);
    % Cálculo do lado direito da desigualdade
    termo_1 = sqrt(Westados_tripartite{n}(2,2) * Westados_tripartite{n}(7,7));
    termo_2 = sqrt(Westados_tripartite{n}(3,3) * Westados_tripartite{n}(6,6));
    termo_3 = sqrt(Westados_tripartite{n}(4,4) * Westados_tripartite{n}(5,5));
    somatoria = termo_1 + termo_2 + termo_3;
    % Define se é separável: emaranhado = 0 e biseparável = 1
    if (element_l1_c8 <= somatoria)
        Wresultado(n,1) = 1;
        Wrotulos_biseparable{n,1} = 'biseparável';
    else
        Wresultado(n,1) = 0;
        Wrotulos_biseparable{n,1} = 'emaranhado';
    end
    
    % Preparando dados para o gráfico classificatório
    if (Wresultado(n) == 0)
        x(n) = Wa_peso(n);
        y(n) = 1;
    else
        x(n) = -1;
        y(n) = -1;
    end
    if (Wresultado(n) == 1)
        z(n) = Wa_peso(n);
        k(n) = 0;
    else
        z(n) = -1;
        k(n) = -1;
    end
end

% Exportação dos dados
Wtripartite_classification_biseparable = Wresultado;
save('Wtripartite_classification_biseparable.mat', 'Wtripartite_classification_biseparable');

% Gráfico classificatório
x = x(x>=0);
y = y(y>=0);
z = z(z>=0);
k = k(k>=0);
figure
plot(x, y, 'r.', z, k, 'b.', 'MarkerSize', 20)
set(gca,'FontSize',18)
set(gca, 'FontName', 'Times New Roman'); 
%set(gca,'Color','none')
xticks([0:0.1:1])
yticks([0 1])
yticklabels({ })
legend({'Biseparável','Emaranhado'},'Location','southwest', 'Color','none')
title('Classificação de biseparabilidade de estados Wtripartite')
% Fixando um sombreado para P>1/3
%cm = [0 0 0 ;  0.9 0.9 0.9;  1 1 1];
%patch([(1/3) (1/3) 1.01 1.01 (1/3)]', [-0.95 1.95 1.95 -0.95 -0.95]', cm(2,:), 'EdgeColor','none', 'DisplayName', 'Área de emaranhamento')
axis([-0.02 1.02 -1 2])
%set(gca,'children',flipud(get(gca,'children')))
