INSERT INTO public.customers (customer_id, first_name, last_name, email, country, created_at, account_number, account_type) VALUES
-- invalid email
('fc666cb7-7c27-4739-89a8-853de8f7b10e','Alice','Miller','alice.miller-at-example.com','US', NOW() - INTERVAL '20 days', '10026346', 'personal'),
-- missing customer name
('b1d2e3a4-1111-4bbb-8ccc-9999ddddaaaa',NULL,NULL,'trexcv123@hotmail.co.uk','GB', NOW() - INTERVAL '15 days', '88776325', 'business'),
-- invalid country (not ISO-2)
('d9aa1e6f-4c55-4a8a-b0c4-123456789abc','Carlos','Rodriguez','carlos.rodriguez@gmail.com','UNITED_STATES', NOW() - INTERVAL '10 days', '77615544', 'personal');

INSERT INTO public.transactions (origin_account_number, destination_account_number, transaction_timestamp, amount, currency, merchant, category, payment_status) VALUES
-- transaction timestamp in the future
('77615544', '84161726', NOW() + INTERVAL '5 days', 120.00, 'GBP', 'Amazon', 'retail', 'pending'),
-- invalid currency
('77615544', '36498011', NOW() - INTERVAL '7 days', 75.50, 'EURO', 'Spotify', 'digital', 'settled'),
-- missing category
('88776325', '53995099', NOW() - INTERVAL '3 days', 42.00, 'USD', 'Uber', NULL, 'settled'),
-- transaction amount is 0 and no matching customer record
('14555221', '14556333', NOW() - INTERVAL '1 day', 0.00, 'USD', 'Apple', 'electronics', 'settled');
