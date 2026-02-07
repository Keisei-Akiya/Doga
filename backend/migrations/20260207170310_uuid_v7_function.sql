-- UUID v7 Generation Function (RFC 9562)
-- Inspired by common PostgreSQL implementations for UUID v7
CREATE OR REPLACE FUNCTION uuid_generate_v7()
RETURNS uuid
AS $$
DECLARE
  timestamp    timestamptz;
  microseconds bigint;
  unix_ms      bigint;
  buf          bytea;
BEGIN
  timestamp    := clock_timestamp();
  unix_ms      := (EXTRACT(EPOCH FROM timestamp) * 1000)::bigint;
  microseconds := (EXTRACT(MICROSECONDS FROM timestamp))::bigint % 1000000;

  -- 48 bits of unix timestamp (milliseconds)
  buf := set_byte(format('\x%s', lpad(to_hex(unix_ms), 12, '0'))::bytea, 0, (unix_ms >> 40)::int);
  
  -- Version (4) and high bits of random/clock
  -- We'll use some randomness here for the remaining bits
  buf := buf || gen_random_bytes(10);

  -- Set version to 7 (bits 48-51)
  buf := set_byte(buf, 6, (get_byte(buf, 6) & 15) | 112);
  -- Set variant to 10xx (bits 64-65)
  buf := set_byte(buf, 8, (get_byte(buf, 8) & 63) | 128);

  RETURN encode(buf, 'hex')::uuid;
END;
$$ LANGUAGE plpgsql VOLATILE;

-- Update tables to use uuid_generate_v7() as default for ID
ALTER TABLE videos ALTER COLUMN id SET DEFAULT uuid_generate_v7();
ALTER TABLE tags ALTER COLUMN id SET DEFAULT uuid_generate_v7();
ALTER TABLE nut_entries ALTER COLUMN id SET DEFAULT uuid_generate_v7();
