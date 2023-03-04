
load("tripartite.txt");
linha_inicial = 1;
linha_final = 8;
for n = 1:2002
    estados = tripartite(linha_inicial:linha_final,1:8);
    tripartite1 = reshape(estados, 8, 8);
    estados_tripartite{n,1} = tripartite1;
    linha_inicial = n * 8;
    linha_final = linha_final + 8;
end
