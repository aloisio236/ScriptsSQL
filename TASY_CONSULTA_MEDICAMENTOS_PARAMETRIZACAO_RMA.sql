SELECT DISTINCT
A.CD_ESTABELECIMENTO,
(SELECT DISTINCT COUNT (A.CD_ESTABELECIMENTO) FROM REGRA_APRESENTACAO_QUIMIO A WHERE A.CD_ESTABELECIMENTO = :CD_ESTABELECIMENTO) TOTAL,
--((SELECT DISTINCT COUNT (A.CD_ESTABELECIMENTO) FROM REGRA_APRESENTACAO_QUIMIO A) /'16')
--FROM REGRA_APRESENTACAO_QUIMIO B WHERE A.CD_ESTABELECIMENTO = :CD_ESTABELECIMENTO) PAGINA,
obter_dados_estab (A.CD_ESTABELECIMENTO,1) Estabelecimento,
A.CD_CONVENIO,
Obter_Nome_Convenio (A.CD_CONVENIO) Conv�nio,
A.CD_MATERIAL,
Obter_Desc_Material (A.CD_MATERIAL) Medicamento,
--A.IE_REGRA_APLICACAO,
(CASE WHEN A.IE_REGRA_APLICACAO = 'P'
THEN 'Prescri��o de quimioterapia'
WHEN A.IE_REGRA_APLICACAO = 'A'
THEN 'Ambos'
WHEN A.IE_REGRA_APLICACAO = 'D'
THEN 'Dispensa��o'
WHEN A.IE_REGRA_APLICACAO = 'G'
THEN 'Gera��o de ordem'
END) "Regra aplicaca��o",
A.CD_PESSOA_FISICA,
A.DT_INICIO_VIGENCIA "In�cio vig�ncia",
--A.IE_REGRA,
(CASE WHEN A.IE_REGRA = 'MA'
THEN 'Melhor apresenta��o'
WHEN A.IE_REGRA = 'ME'
THEN 'Medicamento espec�fico'
WHEN A.IE_REGRA = 'MF'
THEN 'Medicamento exclusivo para faturamento com a mesma ficha t�cnica'
WHEN A.IE_REGRA = 'MG'
THEN 'Medicamento Gen�rico'
END) "Regra apresenta��o",
A.CD_MATERIAL_ESPECIFICO "Medicamento espec�fico",
A.IE_TIPO_MATERIAL_CONSIDERAR,
A.IE_PRESCRICAO,
A.IE_SITUACAO,
A.NR_SEQUENCIA,
A.NM_USUARIO,
A.CD_GRUPO_MATERIAL,
A.CD_SUBGRUPO_MATERIAL,
A.CD_CLASSE_MATERIAL,
A.IE_TIPO_MATERIAL,
A.NR_SEQUENCIA
FROM REGRA_APRESENTACAO_QUIMIO A
WHERE A.CD_ESTABELECIMENTO = :CD_ESTABELECIMENTO
AND A.CD_MATERIAL = 91430
ORDER BY 2, 4, 6;


EDIT REGRA_APRESENTACAO_QUIMIO WHERE NR_SEQUENCIA = 156227