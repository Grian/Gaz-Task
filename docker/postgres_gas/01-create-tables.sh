#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOL
CREATE TABLE messages (
    id uuid,
    message text
)
EOL
