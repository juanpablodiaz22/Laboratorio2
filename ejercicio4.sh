#!/bin/bash

# Es el directorio a monitorear
directorio="/var/log"

# Este código espera por eventos en el directorio
inotifywait -m -r -e create,modify,delete --format '%T %w %f' "$directorio" |
while read fecha directorio archivo evento; do
    echo "[$fecha] $evento: $directorio/$archivo" >> /var/log/monitor_cambios.log
done
