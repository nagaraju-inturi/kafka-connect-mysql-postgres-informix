CREATE USER connect_user WITH PASSWORD 'asgard';
CREATE SCHEMA demo AUTHORIZATION connect_user;
GRANT ALL PRIVILEGES ON DATABASE postgres TO connect_user;

create table demo.customers (
        customer_id SERIAL PRIMARY KEY,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        email VARCHAR(50),
        gender VARCHAR(50),
        comments VARCHAR(90),
        update_ts TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
GRANT SELECT ON demo.customers TO connect_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA demo TO connect_user;

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.update_ts = NOW();
    RETURN NEW;
  END;
$$;

CREATE TRIGGER customers_updated_at_modtime BEFORE UPDATE ON demo.customers FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();



