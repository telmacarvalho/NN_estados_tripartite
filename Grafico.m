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
%     load('result_SzSxParcial_erro')
%     load('peso_test_SzSxParcial_erro')
%     C = result_SzSxParcial_erro;
%     C1 = peso_test_SzSxParcial_erro;
% load('result_SzOnly_erro')
% load('peso_test_SzOnly_erro')
% C = result_SzOnly_erro;
% C1 = peso_test_SzOnly_erro;

% Preparando dados para o gráfico classificatório
% Para medição em Sz e parcialmente emSx 
% for k = 1:size(C, 1)
%     % Para medição em Sz e parcialmente em Sx (DESCONSIDERADO)
%     % Para medição apenas em Sz
%     if (C(k,1) == 0)
%         z1 = 0.02;
%         z11 = 0.34;
%         x(k) = C1(k);
%         y(k) = (z11-z1).*rand(1,1) + z1;
%     else
%         x(k) = -1;
%         y(k) = -1; 
%     end
%     if (C(k,1) == 1)
%         z1 = 0.02;
%         z11 = 0.34;   
%         z(k) = C1(k);
%         i(k) = (z11-z1).*rand(1,1) + z1;
%     else
%         z(k) = -1;
%         i(k) = -1;
%     end
% end

% Preparando dados para o gráfico classificatório
% Com classificação de separabilidade total
for l = 1:size(A, 1) 
      if (A(l,1) == 0)
        z1 = 0.02;
        z11 = 0.59; 
        q(l) = A1(l);
        r(l) = (z11-z1).*rand(1,1) + z1;
    else
        q(l) = -1;
        r(l) = -1; 
    end
    if (A(l,1) == 1)
        z1 = 0.02;
        z11 = 0.59;
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
        z1 = 0.75;
        z11 = 1.34;
        a(j) = B1(j);
        b(j) = (z11-z1).*rand(1,1) + z1;
    else
        a(j) = -1;
        b(j) = -1; 
    end
    if (B(j,1) == 1)
        z1 = 0.75;
        z11 = 1.34;
        c(j) = B1(j);
        d(j) = (z11-z1).*rand(1,1) + z1;        
    else
        c(j) = -1;
        d(j) = -1;
    end
end

% Gráfico de erros na fase de classificação
% x = x(x>-1);
% y = y(y>-1);
% z = z(z>-1);
% i = i(i>-1);

a = a(a>-1);
b = b(b>-1);
c = c(c>-1);
d = d(d>-1);

q = q(q>-1);
r = r(r>-1);
u = u(u>-1);
v = v(v>-1);

figure
% D1 = plot(z, i, 'c.', x, y, 'b.', 'MarkerSize', 45);
% hold on
D2 = plot(c, d, 'c.', a, b, 'b.', 'MarkerSize', 45);
hold on
D3 = plot( u, v, 'c.', q, r, 'b.', 'MarkerSize', 45);
hold off
set(gca,'FontSize',50)
set(gca, 'FontName', 'Times New Roman'); 
xticks([0:0.1:1])
yticklabels({})
y1 = yline(0.75,'.',' ','LineWidth', 1);
% Classificação de biseparabilidade
y2 = yline(1.34,'','{\ita)}');
y2.LabelHorizontalAlignment = 'left';
set(y2,'FontSize',50, 'FontName', 'Times New Roman   ')
%y3 = yline(0.5,'.',' ','LineWidth',1);
% Classificação de separabilidade total
y4 = yline(0.59,'','{\itb)}');
y4.LabelHorizontalAlignment = 'left';
set(y4,'FontSize',50, 'FontName', 'Times New Roman')
% Measurement in Sz and partial measurement in Sx (DISCONSIDERADED)
% Measurement only in Sz
% y5 = yline(0.36,'','{\itc)}');
% y5.LabelHorizontalAlignment = 'left';
% set(y5,'FontSize',50, 'FontName', 'Times New Roman')

% Fixando um sombreado para P>1/3
cm = [0 0 0 ;  0.9 0.9 0.9;  1 1 1];
patch([(1/3) (1/3) 1.01 1.01 (1/3)]', [-0 1.5 1.5 -0 -0]', cm(2,:), 'EdgeColor','none', 'DisplayName', 'Entanglement area')
axis([-0.02 1.02 -0.02 1.52])
set(gca,'children',flipud(get(gca,'children')))

% Legenda tripla
leg1 = legend(D3,{'Separável', 'Não-separável'},'Location','northwest','Orientation','horizontal', 'Color','none', 'EdgeColor','none');
set(leg1, 'FontSize', 50);
ah1=axes('position',get(gca,'position'),'visible','off');
leg2 = legend(ah1, D2,{'Separável', 'Não-separável'},'Location','southwest','Orientation','horizontal', 'Color','none', 'EdgeColor','none');
ah2=axes('position',get(gca,'position'),'visible','off');
set(leg2, 'FontSize', 50,'FontName', 'Times New Roman');
% leg3 = legend(ah2,D1,{'Separável', 'Não-separável'},'Location','southwest','Orientation','horizontal', 'Color','none', 'EdgeColor','none');
% set(leg3, 'FontSize', 50, 'FontName', 'Times New Roman');
