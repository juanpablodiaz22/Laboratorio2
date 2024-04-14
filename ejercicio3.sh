#!/bin/bash

# Para comprobar si se ha creado un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ejecutable>"
    exit 1
fi

# Para asignar el argumento a una variable
EXECUTABLE=$1

# Para monitorear el consumo de CPU y memoria
monitor_resource_usage() {
    local log_file="resource_usage.log"
    local interval=1  # Es un monitoreo en segundos
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    echo "Tiempo CPU Memoria" > $log_file

    # Aca ejecuta el binario recibido en segundo plano
    ./$EXECUTABLE &

    local pid=$!  # Para obtener el PID del proceso recién iniciado

    while ps -p $pid > /dev/null; do
        local cpu_usage=$(ps -p $pid -o %cpu --no-headers)
        local memory_usage=$(ps -p $pid -o %mem --no-headers)
        timestamp=$(date +"%Y-%m-%d %H:%M:%S")
        echo "$timestamp $cpu_usage $memory_usage" >> $log_file
        sleep $interval
    done

    # Para graficar los valores sobre el tiempo
    gnuplot <<-EOF
        set xlabel "Tiempo"
        set ylabel "Porcentaje"
        set title "Consumo de CPU y Memoria de $EXECUTABLE"
        set terminal png
        set output "resource_usage_plot.png"
        plot "$log_file" using 1:2 with lines title "CPU", \
             "$log_file" using 1:3 with lines title "Memoria"
EOF

    echo "Grafico generado: resource_usage_plot.png"
}

# Para llamar a la función para monitorear el consumo de recursos
monitor_resource_usage
