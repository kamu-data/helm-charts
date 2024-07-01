#!/bin/bash

if [ -z "$DB_CONNECTION_STRING" ]; then
  echo "Error: DB_CONNECTION_STRING is not defined."
  exit 1
fi

if [ $# -ne 1 ]; then
  echo "Usage: $0 <migrations source folder>"
  exit 1
fi

SOURCE="$1"

sqlx migrate run --source "$SOURCE" --database-url "$DB_CONNECTION_STRING"
