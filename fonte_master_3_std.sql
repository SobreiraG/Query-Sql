 WITH a0 AS (
         SELECT mv.lead_id,
            min(date(mv.movement_date - '03:00:00'::interval)) AS data_qualificacao
           FROM movements mv
          WHERE mv.column_name::text = 'EM CONTATO'::text OR mv.column_name::text = 'EM CONTATO (1 DIA)'::text OR mv.column_name::text = 'EM CONTATO (3 DIAS)'::text OR mv.column_name::text = 'EM CONTATO (5 DIAS)'::text OR mv.column_name::text = 'RESPONDEU'::text
          GROUP BY mv.lead_id
        ), a1 AS (
         SELECT count(DISTINCT a0.lead_id) AS respondeu,
            cl.client_type,
            cl.client_name,
            cl.client_id,
            cl.client_squad,
            cl.client_cluster,
            cl.client_segment,
            cl.client_main_name,
            cl.client_main_type,
            cl.client_main_id,
            ld.card_creator,
            ld.motivo_de_lost,
            a0.data_qualificacao,
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END AS card_creator_group,
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END AS utm_source_group
           FROM a0
             LEFT JOIN leads ld ON a0.lead_id::text = ld.lead_id::text
             LEFT JOIN clients cl ON ld.client_id::text = cl.client_id::text
          GROUP BY a0.data_qualificacao, cl.client_type, cl.client_name, cl.client_id, cl.client_squad, cl.client_cluster, cl.client_segment, cl.client_main_name, cl.client_main_type, cl.client_main_id, ld.card_creator, ld.motivo_de_lost, (
                CASE
                   WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END), (
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END)
          ORDER BY a0.data_qualificacao DESC
        ), b0 AS (
         SELECT mv.lead_id,
            min(date(mv.movement_date - '03:00:00'::interval)) AS data_oportunidade
           FROM movements mv
          WHERE mv.column_name::text = 'SIMULAÇÃO'::text OR mv.column_name::text = 'SIMULAÇÃO (7 DIAS)'::text OR mv.column_name::text = 'SIMULAÇÃO (7DIAS)'::text OR mv.column_name::text = 'OPORTUNIDADE'::text
          GROUP BY mv.lead_id
        ), b1 AS (
         SELECT count(DISTINCT b0.lead_id) AS oportunidades,
            cl.client_type,
            cl.client_name,
            cl.client_squad,
            cl.client_cluster,
            cl.client_segment,
            cl.client_main_name,
            cl.client_main_type,
            cl.client_main_id,
            ld.client_id,
            ld.card_creator,
            ld.motivo_de_lost,
            b0.data_oportunidade,
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END AS card_creator_group,
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END AS utm_source_group
           FROM b0
             LEFT JOIN leads ld ON b0.lead_id::text = ld.lead_id::text
             LEFT JOIN clients cl ON ld.client_id::text = cl.client_id::text
          GROUP BY b0.data_oportunidade, cl.client_type, cl.client_name, cl.client_squad, cl.client_cluster, cl.client_segment, cl.client_main_name, cl.client_main_type, cl.client_main_id, ld.client_id, ld.card_creator, ld.motivo_de_lost, (
                CASE
                   WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END), (
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END)
          ORDER BY b0.data_oportunidade DESC
        ), c1 AS (
         SELECT count(DISTINCT ld.lead_id) AS leads,
            cl.client_type,
            cl.client_name,
            cl.client_squad,
            cl.client_cluster,
            cl.client_segment,
            cl.client_main_name,
            cl.client_main_type,
            cl.client_main_id,
            ld.client_id,
            ld.card_creator,
            ld.motivo_de_lost,
            date(ld.create_date - '03:00:00'::interval) AS data_periodo,
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END AS card_creator_group,
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END AS utm_source_group
           FROM leads ld
             LEFT JOIN clients cl ON ld.client_id::text = cl.client_id::text
          GROUP BY (date(ld.create_date - '03:00:00'::interval)), cl.client_type, cl.client_name, cl.client_squad, cl.client_cluster, cl.client_segment, cl.client_main_name, cl.client_main_type, cl.client_main_id, ld.client_id, ld.card_creator, ld.motivo_de_lost, (
                CASE
                   WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END), (
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END)
          ORDER BY (date(ld.create_date - '03:00:00'::interval)) DESC
        ), d0 AS (
         SELECT mv.lead_id,
            min(date(mv.movement_date - '03:00:00'::interval)) AS data_agendamento
           FROM movements mv
          WHERE mv.column_name::text = 'AGENDOU VISITA'::text
          GROUP BY mv.lead_id
        ), d1 AS (
         SELECT count(DISTINCT d0.lead_id) AS agendou,
            cl.client_type,
            cl.client_name,
            cl.client_squad,
            cl.client_cluster,
            cl.client_segment,
            cl.client_main_name,
            cl.client_main_type,
            cl.client_main_id,
            ld.client_id,
            ld.card_creator,
            ld.motivo_de_lost,
            d0.data_agendamento,
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END AS card_creator_group,
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END AS utm_source_group
           FROM d0
             LEFT JOIN leads ld ON d0.lead_id::text = ld.lead_id::text
             LEFT JOIN clients cl ON ld.client_id::text = cl.client_id::text
          GROUP BY d0.data_agendamento, cl.client_type, cl.client_name, cl.client_squad, cl.client_cluster, cl.client_segment, cl.client_main_name, cl.client_main_type, cl.client_main_id, ld.client_id, ld.card_creator, ld.motivo_de_lost, (
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END), (
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END)
          ORDER BY d0.data_agendamento DESC
        ), e0 AS (
         SELECT mv.lead_id,
            min(date(mv.movement_date - '03:00:00'::interval)) AS data_visitou
           FROM movements mv
          WHERE mv.column_name::text = 'VISITOU'::text OR mv.column_name::text = 'NEGOCIANDO PÓS-VISITA'::text OR mv.column_name::text = 'NEGOCIANDO PÓS-VISITA (30 DIAS)'::text
          GROUP BY mv.lead_id
        ), e1 AS (
         SELECT count(DISTINCT e0.lead_id) AS visitou,
            cl.client_type,
            cl.client_name,
            cl.client_squad,
            cl.client_cluster,
            cl.client_segment,
            cl.client_main_name,
            cl.client_main_type,
            cl.client_main_id,
            ld.client_id,
            ld.card_creator,
            ld.motivo_de_lost,
            e0.data_visitou,
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END AS card_creator_group,
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END AS utm_source_group
           FROM e0
             LEFT JOIN leads ld ON e0.lead_id::text = ld.lead_id::text
             LEFT JOIN clients cl ON ld.client_id::text = cl.client_id::text
          GROUP BY e0.data_visitou, cl.client_type, cl.client_name, cl.client_squad, cl.client_cluster, cl.client_segment, cl.client_main_name, cl.client_main_type, cl.client_main_id, ld.client_id, ld.card_creator, ld.motivo_de_lost, (
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END), (
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END)
          ORDER BY e0.data_visitou DESC
        ),
last_movement_and_date AS (
    SELECT
        mv.lead_id,
        mv.column_name as movement_name,
        DATE(mv.movement_date - interval '3 hours') as movement_date,
        ROW_NUMBER() OVER (PARTITION BY mv.lead_id ORDER BY mv.movement_date DESC) as rn
    FROM
        movements mv
),
final_movements AS (
    SELECT 
        lead_id, 
        movement_name, 
        movement_date
    FROM 
        last_movement_and_date
    WHERE 
        rn = 1
),
f0 AS (
    SELECT
        f.lead_id,
        f.movement_date as data_fechamento
    FROM
        final_movements f
    WHERE
        f.movement_name = 'FECHOU'
),
        f1 AS (
         SELECT count(DISTINCT f0.lead_id) AS fechou,
            cl.client_type,
            cl.client_name,
            cl.client_squad,
            cl.client_cluster,
            cl.client_segment,
            cl.client_main_name,
            cl.client_main_type,
            cl.client_main_id,
            ld.client_id,
            ld.card_creator,
            ld.motivo_de_lost,
            f0.data_fechamento,
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END AS card_creator_group,
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END AS utm_source_group
           FROM f0
             LEFT JOIN leads ld ON f0.lead_id::text = ld.lead_id::text
             LEFT JOIN clients cl ON ld.client_id::text = cl.client_id::text
          GROUP BY f0.data_fechamento, cl.client_type, cl.client_name, cl.client_squad, cl.client_cluster, cl.client_segment, cl.client_main_name, cl.client_main_type, cl.client_main_id, ld.client_id, ld.card_creator, ld.motivo_de_lost, (
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END), (
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END)
          ORDER BY f0.data_fechamento DESC
        ), g0 AS (
         SELECT mv.lead_id,
            min(date(mv.movement_date - '03:00:00'::interval)) AS data_lost
           FROM movements mv
          WHERE mv.column_name::text = 'LOST'::text
          GROUP BY mv.lead_id
        ), g1 AS (
         SELECT count(DISTINCT g0.lead_id) AS lost,
            cl.client_type,
            cl.client_name,
            cl.client_squad,
            cl.client_cluster,
            cl.client_segment,
            cl.client_main_name,
            cl.client_main_type,
            cl.client_main_id,
            ld.client_id,
            ld.card_creator,
            ld.motivo_de_lost,
            g0.data_lost,
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END AS card_creator_group,
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END AS utm_source_group
           FROM g0
             LEFT JOIN leads ld ON g0.lead_id::text = ld.lead_id::text
             LEFT JOIN clients cl ON ld.client_id::text = cl.client_id::text
          GROUP BY g0.data_lost, cl.client_type, cl.client_name, cl.client_squad, cl.client_cluster, cl.client_segment, cl.client_main_name, cl.client_main_type, cl.client_main_id, ld.client_id, ld.card_creator, ld.motivo_de_lost, (
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END), (
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END)
          ORDER BY g0.data_lost DESC
        ), h0 AS (
         SELECT mv.lead_id,
            min(date(mv.movement_date - '03:00:00'::interval)) AS data_contato_futuro
           FROM movements mv
          WHERE mv.column_name::text = 'CONTATO FUTURO'::text
          GROUP BY mv.lead_id
        ), h1 AS (
         SELECT count(DISTINCT h0.lead_id) AS contato_futuro,
            cl.client_type,
            cl.client_name,
            cl.client_squad,
            cl.client_cluster,
            cl.client_segment,
            cl.client_main_name,
            cl.client_main_type,
            cl.client_main_id,
            ld.client_id,
            ld.card_creator,
            ld.motivo_de_lost,
            h0.data_contato_futuro,
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END AS card_creator_group,
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END AS utm_source_group
           FROM h0
             LEFT JOIN leads ld ON h0.lead_id::text = ld.lead_id::text
             LEFT JOIN clients cl ON ld.client_id::text = cl.client_id::text
          GROUP BY h0.data_contato_futuro, cl.client_type, cl.client_name, cl.client_squad, cl.client_cluster, cl.client_segment, cl.client_main_name, cl.client_main_type, cl.client_main_id, ld.client_id, ld.card_creator, ld.motivo_de_lost, (
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END), (
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END)
          ORDER BY h0.data_contato_futuro DESC
        ), i0 AS (
         SELECT mv.lead_id,
            min(date(mv.movement_date - '03:00:00'::interval)) AS data_pre_oportunidade
           FROM movements mv
          WHERE mv.column_name::text = 'PRÉ OPORTUNIDADE'::text
          GROUP BY mv.lead_id
        ), i1 AS (
         SELECT count(DISTINCT i0.lead_id) AS pre_oportunidade,
            cl.client_type,
            cl.client_name,
            cl.client_squad,
            cl.client_cluster,
            cl.client_segment,
            cl.client_main_name,
            cl.client_main_type,
            cl.client_main_id,
            ld.client_id,
            ld.card_creator,
            ld.motivo_de_lost,
            i0.data_pre_oportunidade,
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END AS card_creator_group,
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END AS utm_source_group
           FROM i0
             LEFT JOIN leads ld ON i0.lead_id::text = ld.lead_id::text
             LEFT JOIN clients cl ON ld.client_id::text = cl.client_id::text
          GROUP BY i0.data_pre_oportunidade, cl.client_type, cl.client_name, cl.client_squad, cl.client_cluster, cl.client_segment, cl.client_main_name, cl.client_main_type, cl.client_main_id, ld.client_id, ld.card_creator, ld.motivo_de_lost, (
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END), (
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END)
          ORDER BY i0.data_pre_oportunidade DESC
        ), j0 AS (
         SELECT mv.lead_id,
            min(date(mv.movement_date - '03:00:00'::interval)) AS data_em_negociacao
           FROM movements mv
          WHERE mv.column_name::text = 'EM NEGOCIAÇÃO'::text
          GROUP BY mv.lead_id
        ), j1 AS (
         SELECT count(DISTINCT i0.lead_id) AS em_negociacao,
            cl.client_type,
            cl.client_name,
            cl.client_squad,
            cl.client_cluster,
            cl.client_segment,
            cl.client_main_name,
            cl.client_main_type,
            cl.client_main_id,
            ld.client_id,
            ld.card_creator,
            ld.motivo_de_lost,
            i0.data_pre_oportunidade,
            j0.em_negociacao,
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END AS card_creator_group,
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END AS utm_source_group
           FROM j0
             LEFT JOIN leads ld ON i0.lead_id::text = ld.lead_id::text
             LEFT JOIN clients cl ON ld.client_id::text = cl.client_id::text
          GROUP BY j0.em_negociacao, cl.client_type, cl.client_name, cl.client_squad, cl.client_cluster, cl.client_segment, cl.client_main_name, cl.client_main_type, cl.client_main_id, ld.client_id, ld.card_creator, ld.motivo_de_lost, (
                CASE
                    WHEN ld.card_creator::text = '-::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    WHEN ld.card_creator::text = '-'::text THEN 'Lead HP'::text
                    ELSE 'Outros'::text
                END), (
                CASE
                    WHEN ld.utm_source::text = 'facecbook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'fb_leadads'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'facebook - Whatsapp'::text THEN 'Facebook Ads'::text
                    WHEN ld.utm_source::text = 'Google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source::text = 'google'::text THEN 'Google Ads'::text
                    WHEN ld.utm_source IS NULL THEN 'Não identificado'::text
                    ELSE 'Outros'::text
                END)
          ORDER BY j0.em_negociacao DESC
        )
 SELECT COALESCE(c1.data_periodo, a1.data_qualificacao, b1.data_oportunidade, d1.data_agendamento, e1.data_visitou, f1.data_fechamento, g1.data_lost, h1.data_contato_futuro, i1.data_pre_oportunidade, j1.em_negociacao) AS data_periodo,
    COALESCE(c1.client_type, a1.client_type, b1.client_type, d1.client_type, e1.client_type, f1.client_type, g1.client_type, h1.client_type, i1.client_type, j1.client_type) AS client_type,
    COALESCE(c1.client_id, a1.client_id, b1.client_id, d1.client_id, e1.client_id, f1.client_id, g1.client_id, h1.client_id, i1.client_id, j1.client_id) AS client_id,
    COALESCE(c1.client_name, a1.client_name, b1.client_name, d1.client_name, e1.client_name, f1.client_name, g1.client_name, h1.client_name, i1.client_name, j1.client_name) AS client_name,
    COALESCE(c1.client_main_name, a1.client_main_name, b1.client_main_name, d1.client_main_name, e1.client_main_name, f1.client_main_name, g1.client_main_name, h1.client_main_name, i1.client_main_name, j1.client_main_name) AS client_main_name,
    COALESCE(c1.client_main_type, a1.client_main_type, b1.client_main_type, d1.client_main_type, e1.client_main_type, f1.client_main_type, g1.client_main_type, h1.client_main_type, i1.client_main_type, j1.client_main_type) AS client_main_type,
    COALESCE(c1.client_main_id, a1.client_main_id, b1.client_main_id, d1.client_main_id, e1.client_main_id, f1.client_main_id, g1.client_main_id, h1.client_main_id, i1.client_main_id, j1.client_main_id) AS client_main_id,
    COALESCE(c1.client_segment, a1.client_segment, b1.client_segment, d1.client_segment, e1.client_segment, f1.client_segment, g1.client_segment, h1.client_segment, i1.client_segment, j1.client_segment) AS client_segment,
    COALESCE(c1.client_squad, a1.client_squad, b1.client_squad, d1.client_squad, e1.client_squad, f1.client_squad, g1.client_squad, h1.client_squad, i1.client_squad, j1.client_squad) AS client_squad,
    COALESCE(c1.client_cluster, a1.client_cluster, b1.client_cluster, d1.client_cluster, e1.client_cluster, f1.client_cluster, g1.client_cluster, h1.client_cluster, i1.client_cluster, j1.client_cluster) AS client_cluster,
    COALESCE(c1.card_creator, a1.card_creator, b1.card_creator, d1.card_creator, e1.card_creator, f1.card_creator, g1.card_creator, h1.card_creator, i1.card_creator, j1.card_creator) AS card_creator,
    COALESCE(c1.motivo_de_lost, a1.motivo_de_lost, b1.motivo_de_lost, d1.motivo_de_lost, e1.motivo_de_lost, f1.motivo_de_lost, g1.motivo_de_lost, h1.motivo_de_lost, i1.motivo_de_lost, j1.motivo_de_lost) AS motivo_de_lost,
    COALESCE(c1.card_creator_group, a1.card_creator_group, b1.card_creator_group, d1.card_creator_group, e1.card_creator_group, f1.card_creator_group, g1.card_creator_group, h1.card_creator_group, i1.card_creator_group, j1.card_creator_group) AS card_creator_group,
    COALESCE(c1.utm_source_group, a1.utm_source_group, b1.utm_source_group, d1.utm_source_group, e1.utm_source_group, f1.utm_source_group, g1.utm_source_group, h1.utm_source_group, i1.utm_source_group, j1.utm_source_group) AS utm_source_group,
    c1.leads,
    a1.respondeu,
    b1.oportunidades,
    d1.agendou,
    e1.visitou,
    f1.fechou,
    g1.lost,
    h1.contato_futuro,
    i1.pre_oportunidade,
    j1.em_negociacao
   FROM c1
     FULL JOIN a1 ON c1.data_periodo = a1.data_qualificacao AND c1.client_type::text = a1.client_type::text AND c1.client_id::text = a1.client_id::text AND c1.client_cluster::text = a1.client_cluster::text AND c1.client_squad::text = a1.client_squad::text AND c1.client_segment::text = a1.client_segment::text AND c1.client_main_name::text = a1.client_main_name::text AND c1.client_main_type::text = a1.client_main_type::text AND c1.client_main_id::text = a1.client_main_id::text AND c1.card_creator::text = a1.card_creator::text AND c1.motivo_de_lost::text = a1.motivo_de_lost::text AND c1.card_creator_group = a1.card_creator_group AND c1.utm_source_group = a1.utm_source_group
     FULL JOIN b1 ON c1.data_periodo = b1.data_oportunidade AND c1.client_type::text = b1.client_type::text AND c1.client_id::text = b1.client_id::text AND c1.client_cluster::text = b1.client_cluster::text AND c1.client_squad::text = b1.client_squad::text AND c1.client_segment::text = b1.client_segment::text AND c1.client_main_name::text = b1.client_main_name::text AND c1.client_main_type::text = b1.client_main_type::text AND c1.client_main_id::text = b1.client_main_id::text AND c1.card_creator::text = b1.card_creator::text AND c1.motivo_de_lost::text = b1.motivo_de_lost::text AND c1.card_creator_group = b1.card_creator_group AND c1.utm_source_group = b1.utm_source_group
     FULL JOIN d1 ON c1.data_periodo = d1.data_agendamento AND c1.client_type::text = d1.client_type::text AND c1.client_id::text = d1.client_id::text AND c1.client_cluster::text = d1.client_cluster::text AND c1.client_squad::text = d1.client_squad::text AND c1.client_segment::text = d1.client_segment::text AND c1.client_main_name::text = d1.client_main_name::text AND c1.client_main_type::text = d1.client_main_type::text AND c1.client_main_id::text = d1.client_main_id::text AND c1.card_creator::text = d1.card_creator::text AND c1.motivo_de_lost::text = d1.motivo_de_lost::text AND c1.card_creator_group = d1.card_creator_group AND c1.utm_source_group = d1.utm_source_group
     FULL JOIN e1 ON c1.data_periodo = e1.data_visitou AND c1.client_type::text = e1.client_type::text AND c1.client_cluster::text = e1.client_cluster::text AND c1.client_squad::text = e1.client_squad::text AND c1.client_segment::text = e1.client_segment::text AND c1.client_main_name::text = e1.client_main_name::text AND c1.client_main_type::text = e1.client_main_type::text AND c1.client_id::text = e1.client_id::text AND c1.client_main_id::text = e1.client_main_id::text AND c1.card_creator::text = e1.card_creator::text AND c1.motivo_de_lost::text = e1.motivo_de_lost::text AND c1.card_creator_group = e1.card_creator_group AND c1.utm_source_group = e1.utm_source_group
     FULL JOIN f1 ON c1.data_periodo = f1.data_fechamento AND c1.client_type::text = f1.client_type::text AND c1.client_id::text = f1.client_id::text AND c1.client_cluster::text = f1.client_cluster::text AND c1.client_squad::text = f1.client_squad::text AND c1.client_segment::text = f1.client_segment::text AND c1.client_main_name::text = f1.client_main_name::text AND c1.client_main_type::text = f1.client_main_type::text AND c1.client_main_id::text = f1.client_main_id::text AND c1.card_creator::text = f1.card_creator::text AND c1.motivo_de_lost::text = f1.motivo_de_lost::text AND c1.card_creator_group = f1.card_creator_group AND c1.utm_source_group = f1.utm_source_group
     FULL JOIN g1 ON c1.data_periodo = g1.data_lost AND c1.client_type::text = g1.client_type::text AND c1.client_id::text = g1.client_id::text AND c1.client_cluster::text = g1.client_cluster::text AND c1.client_squad::text = g1.client_squad::text AND c1.client_segment::text = g1.client_segment::text AND c1.client_main_name::text = g1.client_main_name::text AND c1.client_main_type::text = g1.client_main_type::text AND c1.client_main_id::text = g1.client_main_id::text AND c1.card_creator::text = g1.card_creator::text AND c1.motivo_de_lost::text = g1.motivo_de_lost::text AND c1.card_creator_group = g1.card_creator_group AND c1.utm_source_group = g1.utm_source_group
     FULL JOIN h1 ON c1.data_periodo = h1.data_contato_futuro AND c1.client_type::text = h1.client_type::text AND c1.client_id::text = h1.client_id::text AND c1.client_cluster::text = h1.client_cluster::text AND c1.client_squad::text = h1.client_squad::text AND c1.client_segment::text = h1.client_segment::text AND c1.client_main_name::text = h1.client_main_name::text AND c1.client_main_type::text = h1.client_main_type::text AND c1.client_main_id::text = h1.client_main_id::text AND c1.card_creator::text = h1.card_creator::text AND c1.motivo_de_lost::text = h1.motivo_de_lost::text AND c1.card_creator_group = h1.card_creator_group AND c1.utm_source_group = h1.utm_source_group
     FULL JOIN i1 ON c1.data_periodo = i1.data_pre_oportunidade AND c1.client_type::text = i1.client_type::text AND c1.client_id::text = i1.client_id::text AND c1.client_cluster::text = i1.client_cluster::text AND c1.client_squad::text = i1.client_squad::text AND c1.client_segment::text = i1.client_segment::text AND c1.client_main_name::text = i1.client_main_name::text AND c1.client_main_type::text = i1.client_main_type::text AND c1.client_main_id::text = i1.client_main_id::text AND c1.card_creator::text = i1.card_creator::text AND c1.motivo_de_lost::text = i1.motivo_de_lost::text AND c1.card_creator_group = i1.card_creator_group AND c1.utm_source_group = i1.utm_source_group
     FULL JOIN i1 ON c1.data_periodo = j1.data_pre_oportunidade AND c1.client_type::text = j1.client_type::text AND c1.client_id::text = j1.client_id::text AND c1.client_cluster::text = j1.client_cluster::text AND c1.client_squad::text = j1.client_squad::text AND c1.client_segment::text = j1.client_segment::text AND c1.client_main_name::text = j1.client_main_name::text AND c1.client_main_type::text = j1.client_main_type::text AND c1.client_main_id::text = j1.client_main_id::text AND c1.card_creator::text = j1.card_creator::text AND c1.motivo_de_lost::text = j1.motivo_de_lost::text AND c1.card_creator_group = j1.card_creator_group AND c1.utm_source_group = j1.utm_source_group
  ORDER BY (COALESCE(c1.data_periodo, a1.data_qualificacao, b1.data_oportunidade, d1.data_agendamento, e1.data_visitou, f1.data_fechamento, g1.data_lost, h1.data_contato_futuro, i1.data_pre_oportunidade, j1.em_negociacao)) DESC;
