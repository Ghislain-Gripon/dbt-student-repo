{{ 
    config(
        materialized="incremental", 
        on_schema_change="fail"
    ) 
}}
with src_reviews as (select * from {{ ref("src_reviews") }})

select {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id, s.* -- noqa
from src_reviews as s
where
    s.review_text is not null
    {% if is_incremental() %}
        and s.review_date > (select max(t.review_date) from {{ this }} as t)
    {% endif %}
