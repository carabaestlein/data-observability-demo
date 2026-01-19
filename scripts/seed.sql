DROP TABLE IF EXISTS public.transactions CASCADE;
DROP TABLE IF EXISTS public.customers CASCADE;
DROP TABLE IF EXISTS public.customer_transactions CASCADE;

CREATE TABLE public.customers (
  customer_id   TEXT PRIMARY KEY,
  first_name    TEXT,
  last_name     TEXT,
  email         TEXT,
  country       TEXT,
  created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
  account_number TEXT NOT NULL,
  account_type TEXT
);

CREATE TABLE public.transactions (
  transaction_id              BIGSERIAL PRIMARY KEY,
  origin_account_number       TEXT NOT NULL,
  destination_account_number   TEXT NOT NULL,
  transaction_timestamp       TIMESTAMP NOT NULL,
  amount                      NUMERIC(12,2) NOT NULL,
  currency                    TEXT NOT NULL,
  merchant                    TEXT,
  category                    TEXT,
  payment_status              TEXT NOT NULL
);

INSERT INTO public.customers (customer_id, first_name, last_name, email, country, created_at, account_number, account_type) VALUES
('4f337a6f-92e4-4024-bcda-759b7a54b9c9','Ava','Johnson','ava.johnson@hotmail.co.uk','GB', NOW() - INTERVAL '120 days', '84159732', 'personal'),
('98d20223-e0ff-466a-b429-2486a6af9337','Noah','Koening','nkoenig@yahoo.de','DE', NOW() - INTERVAL '90 days', '36497043', 'personal'),
('3315e297-1a15-4745-8844-a33c70ed61af','Mia','Brown','mia_brown@outlook.com','US', NOW() - INTERVAL '60 days', '53994020', 'business'),
('bbdd537e-c511-4b7c-ba1e-a4f157958e85','Leo','Penet','leopenet123@gmail.com','US', NOW() - INTERVAL '30 days', '14555221', 'personal');

INSERT INTO public.transactions (origin_account_number, destination_account_number, transaction_timestamp, amount, currency, merchant, category, payment_status) VALUES
('84159732', '84161726', NOW() - INTERVAL '10 days',  54.23, 'GBP', 'Tesco',        'groceries', 'settled'),
('84159732', '51794851', NOW() - INTERVAL '8 days',  120.00, 'GBP', 'British Gas',  'utilities', 'settled'),
('14555221', '90256299', NOW() - INTERVAL '7 days',   15.99, 'USD', 'Spotify',      'digital',   'settled'),
('36497043', '99554022', NOW() - INTERVAL '5 days',  320.10, 'EUR', 'Lufthansa',    'travel',    'pending'),
('14555221', '99809306', NOW() - INTERVAL '3 days',   42.50, 'USD', 'Whole Foods',  'groceries', 'settled'),
('14555221', '09848773', NOW() - INTERVAL '2 days',  250.00, 'USD', 'Apple',        'retail',    'settled'),
('53994020', '97220409', NOW() - INTERVAL '1 days',   12.40, 'USD', 'Walmart',    'groceries', 'settled');
