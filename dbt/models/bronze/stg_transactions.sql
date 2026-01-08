select
  transaction_id,
  origin_account_number,
  desination_account_number, 
  transaction_timestamp,
  amount,
  currency,
  category,
  status
from public.transactions