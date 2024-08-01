-- Escolhemos os dados de 2015 até 2023
-- A coluna id foi modificado para partida_id com o ojetivo de padronizar igual as outras tabelas
-- O nome da coluna 'rodata' mudou para 'rodada'
-- Foi renomeado os valores em branco da coluna tecnico_mandante e tecnico_visitante para 'Não informado'
-- foi retirado as colunas que não seriam relevantes para a análise
SELECT id AS partida_id, rodata AS rodada, data, hora, mandante, visitante, 
    IF(tecnico_mandante = '' OR tecnico_mandante IS NULL, 'Não informado', tecnico_mandante) AS tecnico_mandante, 
    IF(tecnico_visitante = '' OR tecnico_visitante IS NULL, 'Não informado', tecnico_visitante) AS tecnico_visitante, 
    vencedor, arena, mandante_placar, visitante_placar, mandante_estado, visitante_estado
FROM campeonato_brasileiro_full
WHERE YEAR(data) >= 2015;

-- A coluna 'rodata' já está representadada em partidas.csv
-- A coluna 'chute_no_alvo' grande maioria estar preenchida por 0
-- As colunas 'cartao_amarelo' e 'cartão_vermelho' foram desconsideradas pois já está contida no arquivo cartoes.csv

SELECT BE.partida_id, BE.posse_de_bola, BE.passes, BE.precisao_passes, BE.faltas, BE.impedimentos, BE.escanteios
FROM campeonato_brasileiro_estatisticas_full BE
INNER JOIN campeonato_brasileiro_full BF
ON BE.partida_id = BF.id
WHERE YEAR(F.data) >= 2015;

-- A coluna 'rodata' não foi selecionada por representar um dado já contido em partidas.csv
-- Foi renomeado os dados não preenchidos em 'tipo_de_gol' para 'gol normal'
SELECT G.partida_id, G.clube, G.atleta, G.minuto, 
    IF(G.tipo_de_gol IS NULL, 'gol normal', G.tipo_de_gol) AS tipo_de_gol
FROM campeonato_brasileiro_full F 
INNER JOIN campeonato_brasileiro_gols G
ON F.id = G.partida_id
WHERE YEAR(F.data) >= 2015;

-- A coluna 'rodata' não foi selecionada por representar um dado já contido em partidas.csv
-- A coluna 'num_camisa' não foi selecionada pois não é uma informação relevante para analise
SELECT C.partida_id, C.clube, C.cartao, C.atleta, C.posicao, C.minuto
FROM campeonato_brasileiro_cartoes C
INNER JOIN campeonato_brasileiro_full F
ON C.partida_id = F.id
WHERE YEAR(F.data) >= 2015;