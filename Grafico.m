clear all;
clc;

load('result_tripartite_biseparable')
load('peso_test_tripartite_biseparable')
B = result_tripartite_biseparable;
B1 = peso_test_tripartite_biseparable;
load('result_tripartite_fully_separable')
load('peso_test_tripartite_fully_separable')
A = result_tripartite_fully_separable;
A1 = peso_test_tripartite_fully_separable;  

% Preparando dados para o gráfico classificatório
% Com classificação de separabilidade total
for l = 1:size(A, 1) 
      if (A(l,1) == 0)
        z1 = 0.02;
        z11 = 0.57; 
        q(l) = A1(l);
        r(l) = (z11-z1).*rand(1,1) + z1;
    else
        q(l) = -1;
        r(l) = -1; 
    end
    if (A(l,1) == 1)
        z1 = 0.02;
        z11 = 0.57;
        u(l) = A1(l);
        v(l) = (z11-z1).*rand(1,1) + z1;
    else
        u(l) = -1;
        v(l) = -1;
    end
end

% Com classificação de biseparabilidade
for  j = 1:size(B, 1)  
    if (B(j,1) == 0)
        z1 = 0.79;
        z11 = 1.31;
        a(j) = B1(j);
        b(j) = (z11-z1).*rand(1,1) + z1;
    else
        a(j) = -1;
        b(j) = -1; 
    end
    if (B(j,1) == 1)
        z1 = 0.79;
        z11 = 1.31;
        c(j) = B1(j);
        d(j) = (z11-z1).*rand(1,1) + z1;        
    else
        c(j) = -1;
        d(j) = -1;
    end
end

% Gráfico de erros na fase de classificação
a = a(a>-1);
b = b(b>-1);
c = c(c>-1);
d = d(d>-1);

q = q(q>-1);
r = r(r>-1);
u = u(u>-1);
v = v(v>-1);

figure
D2 = plot(c, d, 'c.', a, b, 'b.', 'MarkerSize', 45);
hold on
D3 = plot( u, v, 'c.', q, r, 'b.', 'MarkerSize', 45);
hold off
set(gca,'FontSize',40)
set(gca, 'FontName', 'Times New Roman'); 
xticks([0:0.1:1])
xlabel('\ita')
yticklabels({})
y1 = yline(0.75,'.',' ','LineWidth', 1);
% Classificação de biseparabilidade
y2 = yline(1.38,'','{\ita)}');
y2.LabelHorizontalAlignment = 'left';
y2.LineStyle = 'none';
set(y2,'FontSize',40, 'FontName', 'Times New Roman   ')
% Classificação de separabilidade total
y4 = yline(0.63,'','{\itb)}');
y4.LabelHorizontalAlignment = 'left';
y4.LineStyle = 'none';
set(y4,'FontSize',40, 'FontName', 'Times New Roman')

% Fixando um sombreado para a > 0,4280 (biseparable)
cm = [0 0 0 ;  0.9 0.9 0.9;  1 1 1];
patch([(0.4280) (0.428) 1.01 1.01 (0.28)]', [0.75 1.5 1.5 0.75 0.75]', cm(2,:), 'EdgeColor','none', 'DisplayName', 'Entanglement area')
% Fixando um sombreado para a > 0,2000 (fully separable)
patch([(0.200) (0.200) 1.01 1.01 (0.200)]', [0 0.75 0.75 0 0]', cm(2,:), 'EdgeColor','none', 'DisplayName', 'Entanglement area')
axis([-0.02 1.02 -0.02 1.52])
set(gca,'children',flipud(get(gca,'children')))

% cm = [0 0 0 ;  0.9 0.9 0.9;  1 1 1];
% patch([(0.280) (0.428) 1.01 1.01 (0.428)]', [-0 1.5 1.5 -0 -0]', cm(2,:), 'EdgeColor','none', 'DisplayName', 'Entanglement area')
% axis([-0.02 1.02 -0.02 1.52])
% set(gca,'children',flipud(get(gca,'children')))

% Legenda dupla
leg1 = legend(D3,{'Biseparable', 'Non-separable'},'Location','northwest','Orientation','horizontal', 'Color','none', 'EdgeColor','none');
set(leg1, 'FontSize', 40);
ah1=axes('position',get(gca,'position'),'visible','off');
leg2 = legend(ah1, D2,{'Fully Separable', 'Non-separable'},'Location','southwest','Orientation','horizontal', 'Color','none', 'EdgeColor','none');
ah2=axes('position',get(gca,'position'),'visible','off');
set(leg2, 'FontSize', 40,'FontName', 'Times New Roman');

