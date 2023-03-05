clc;
clear all;

load('estados_tripartite.mat');
load('a_peso.mat');

% Aplica critério de biseparabilidade
for n = 1:1001
    element_l1_c8 = sqrt((estados_tripartite{n}(1,8))^2);
    termo_1 = sqrt((estados_tripartite{n}(2,2) + (estados_tripartite{n}(7,7))^2));
    termo_2 = sqrt((estados_tripartite{n}(3,3) + (estados_tripartite{n}(6,6))^2));
    termo_3 = sqrt((estados_tripartite{n}(4,4) + (estados_tripartite{n}(5,5))^2));
    somatoria = termo_1 + termo_2 + termo_3;
    % Defini se é separável: emaranhado = 0 e biseparável = 1
    if (element_l1_c8 <= somatoria)
        resultado(n,1) = 1;
        rotulos{n,1} = 'biseparável';
    else
        resultado(n,1) = 0;
        rotulos{n,1} = 'emaranhado';
    end
    
    % Preparando dados para o gráfico classificatório
    if (resultado(n) == 1)
        x(n) = a_peso(n);
        y(n) = 1;
    else
        x(n) = -1;
        y(n) = -1;
    end
    if (resultado(n) == 0)
        z(n) = a_peso(n);
        k(n) = 0;
    else
        z(n) = -1;
        k(n) = -1;
    end
end

% Exportação dos dados
rotulos = categorical(rotulos);
classification_biseparable = dummyvar(rotulos);
tripartite_classification_biseparable = classification_biseparable( :, 2);
save('tripartite_classification_biseparable.mat', 'tripartite_classification_biseparable');

% Gráfico classificatório
x = x(x>=0);
y = y(y>=0);
z = z(z>=0);
k = k(k>=0);
figure
plot(x, y, 'b.', z, k, 'r.', 'MarkerSize', 20)
set(gca,'FontSize',18)
set(gca, 'FontName', 'Times New Roman'); 
%set(gca,'Color','none')
xticks([0:0.1:1])
yticks([0 1])
yticklabels({ })
legend({'Biseparável','Emaranhado'},'Location','southwest', 'Color','none')
title('Classificação de biseparabilidade de estados tripartite')
% Fixando um sombreado para P>1/3
cm = [0 0 0 ;  0.9 0.9 0.9;  1 1 1];
patch([(1/3) (1/3) 1.01 1.01 (1/3)]', [-0.95 1.95 1.95 -0.95 -0.95]', cm(2,:), 'EdgeColor','none', 'DisplayName', 'Área de emaranhamento')
axis([-0.02 1.02 -1 2])
set(gca,'children',flipud(get(gca,'children')))
