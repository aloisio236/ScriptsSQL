SELECT *
FROM    (SELECT PAGING.*,
    ROWNUM PAGING_RN
FROM    (SELECT CASE WHEN ie_tipo_pendencia = 'A' THEN 1 ELSE 0 END nr_status,
    
 NVL(a.nr_sequencia,0) sequencia,
 c.nr_sequencia,
 SUBSTR(DECODE(nr_seq_ehr_reg,NULL,DECODE(ie_gerado_funcao_ehr,'S',coalesce

(b.ds_item_instituicao,a.ds_item_instituicao,a.ds_item,c.ds_item) || ' (Gerado por 

template)',coalesce

(b.ds_item_instituicao,a.ds_item_instituicao,a.ds_item,c.ds_item)),coalesce

(b.ds_item_instituicao,a.ds_item_instituicao,a.ds_item,c.ds_item) || ' (' || 

obter_desc_expressao(299216) || ')'),1,200) ds_item,
 NVL(b.nr_seq_apres,99999) nr_seq_apres,
 d.nm_pessoa_fisica nm_pessoa_fisica,
 c.nr_atendimento nr_atendimento,
 SUBSTR(obter_tipo_pendencia_pep(c.nr_sequencia,'D'),1,200) ds_tipo_pendencia,
 c.ie_tipo_pendencia,
 c.ie_gerado_funcao_ehr,
 c.dt_registro dt_registro,
 d.cd_pessoa_fisica cd_pessoa_fisica,
 c.nr_prescricao nr_prescricao,
 c.nm_usuario nm_usuario, 
 NVL(c.nr_seq_item_orig_pront,0) nr_seq_item_pend,
 SUBSTR(obter_valor_dominio(1799,ie_escala),1,100) ds_escala_pend,
 SUBSTR(DECODE(c.nr_seq_item_orig_pront,NULL,'',SUBSTR(obter_desc_pront_item_pend

(c.nr_seq_item_orig_pront),1,200)),1,200) ds_item_origem
FROM    pessoa_fisica d,
    
 pep_item_pendente c,
 prontuario_item a,
 perfil_item_pront b,
 atendimento_paciente e
WHERE a.nr_sequencia = b.nr_seq_item_pront(+)

    AND    c.nr_seq_item_pront = a.nr_sequencia(+)

    AND    c.nr_atendimento = e.nr_atendimento(+)

    AND    d.cd_pessoa_fisica = c.cd_pessoa_fisica

    AND    (('A' = 'U' AND(null IS NULL OR c.nm_usuario = null)) OR ('A' <> 'U' 
    AND    c.nm_usuario = 'soraia.souza')) -- ====================== Selecionar o nome do usuario ===================
    and (('N' = 'S' 
    AND    e.CD_ESTABELECIMENTO = 1) OR ('N' = 'N'))

    AND    b.cd_perfil(+) = 2059

    AND    (obter_se_pendencia_prescr(c.nr_sequencia,'PEP') = 'S')

    AND    ((e.dt_cancelamento IS NULL) OR ('N' = 'S'))

    AND    (NVL(c.ie_gerado_funcao_pepo,'N') = 'N')

    AND    ((('N' = 'S') 
    AND    (e.dt_alta IS NULL)) OR
 (('N' = 'L') 
    AND    (((c.ie_tipo_pendencia = 'L') 
    AND    (e.dt_alta IS NULL)) OR (c.ie_tipo_pendencia = 'A'))) OR
 (('N' = 'A') 
    AND    (((c.ie_tipo_pendencia = 'A') 
    AND    (e.dt_alta IS NULL)) OR (c.ie_tipo_pendencia = 'L'))) OR
 ('N' = 'N'))

    AND    NVL(c.ie_pendente_assinat_usuario,'N') = 'N'

    AND    ((0 = 0) OR (c.nr_atendimento = 0))

    AND    ((to_date('01/01/2010 00:00:00', 'dd/mm/yyyy hh24:mi:ss') IS NULL) OR 

(c.dt_registro BETWEEN to_date('01/01/2010 00:00:00', 'dd/mm/yyyy hh24:mi:ss') 
    AND    fim_dia(to_date('27/07/2030 15:06:55', 'dd/mm/yyyy hh24:mi:ss'))))

    AND    (('T' = 'T') OR (c.ie_tipo_pendencia = 'T'))

    AND    ((null IS NULL) OR (coalesce

(b.ds_item_instituicao,a.ds_item_instituicao,a.ds_item,c.ds_item) = null))
ORDER BY b.nr_seq_apres,
    
 a.ds_item,
 c.dt_registro) PAGING )
WHERE (PAGING_RN > 0 ) 
    AND    (PAGING_RN <= 1000 ) 
    
delete pep_item_pendente
where nr_sequencia = 25877103;