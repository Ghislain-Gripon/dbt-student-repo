with
fct_reviews as (
    select
        listing_id,
        review_date
    from {{ ref('fct_reviews') }}
),

dim_listings_cleansed as (
    select
        listing_id,
        created_at
    from {{ ref('dim_listings_cleansed') }}
)

select f.*
from fct_reviews as f
inner join
    dim_listings_cleansed as l
    on f.listing_id = l.listing_id and f.review_date < l.created_at
