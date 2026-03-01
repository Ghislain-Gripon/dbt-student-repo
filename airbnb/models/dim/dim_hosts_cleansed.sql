{{
      config(
        materialized = 'view',
        )
}}
with src_hosts as (select * from {{ ref("src_hosts") }})

select
    host_id,
    is_superhost,
    created_at,
    updated_at,
    coalesce(
        case when host_name = '' then null else host_name end, 'Anonymous'
    ) as host_name

from src_hosts
