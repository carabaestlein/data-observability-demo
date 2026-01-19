select
  transaction_id,
  origin_account_number,
  destination_account_number, 
  transaction_timestamp,
  amount,
  currency,
  category,
  payment_status
from public.transactions