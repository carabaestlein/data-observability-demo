select
  t.transaction_id,
  t.transaction_timestamp,
  t.origin_account_number as customer_account_number,
  c.account_type as customer_account_type,
  c.customer_id,
  c.first_name,
  c.last_name,
  c.email,
  c.country,
  t.destination_account_number,
  t.amount,
  t.currency,
  t.category,
  t.status
from {{ ref('stg_transactions') }} t
join {{ ref('stg_customers') }} c
  on t.origin_account_number = c.account_number
