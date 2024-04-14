#!/bin/bash

# Para comprobar si se han creado los argumentos necesarios
if [ $# -ne 2 ]; then
    echo "Uso: $0 <nombre_del_proceso> <comando_para_ejecutar>"
    exit 1
fi

# Para asignar los argumentos a variables
process_name=$1
command=$2

# Para comprobar el estado del proceso y relanzarlo si es necesario
monitor_process() {
    while true; do
        # Para verificar si el proceso está en ejecución
        pgrep -x "$process_name" > /dev/null
        if [ $? -ne 0 ]; then
            # Si el proceso no está en ejecución, volver a levantarlo
            echo "El proceso $process_name no está en ejecución. Volviendo a levantarlo..."
            $command &
        fi
        sleep 5  # Se espera 5 segundos antes de revisar nuevamente
    done
}

# Para llamar a la función para monitorear el proceso
monitor_process
