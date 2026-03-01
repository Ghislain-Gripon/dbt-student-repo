{{ 
    config(
        materialized="incremental", 
        on_schema_change="fail"
    ) 
}}
with src_reviews as (select * from {{ ref("src_reviews") }})

select s.*
from src_reviews as s
where
    s.review_text is not null
    {% if is_incremental() %}
        and s.review_date > (select max(t.review_date) from {{ this }} as t)
    {% endif %}
