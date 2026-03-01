select *
from {{ ref('dim_listings_cleansed') }}
where minimum_nights < 1
order by listing_id
limit 10
