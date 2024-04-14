#!/bin/bash

# para comprobar si se ha creado un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <PID>"
    exit 1
fi

# para obtener información del proceso
pid=$1
process_info=$(ps -p $pid -o comm=,pid=,ppid=,user=,pcpu=,pmem=,stat=)

# para obtener el nombre del proceso
process_name=$(echo $process_info | awk '{print $1}')

# para obtener el ID del proceso
process_pid=$(echo $process_info | awk '{print $2}')

# para obtener el parent process ID
parent_pid=$(echo $process_info | awk '{print $3}')

# para obtener el usuario propietario
owner=$(echo $process_info | awk '{print $4}')

# para  obtener el porcentaje de uso de CPU
cpu_usage=$(echo $process_info | awk '{print $5}')

# para obtener el consumo de memoria
memory_usage=$(echo $process_info | awk '{print $6}')

# para obtener el estado 
status=$(echo $process_info | awk '{print $7}')

# para obtener el path del ejecutable
executable=$(readlink /proc/$pid/exe)

# muestra la información obtenida
echo "Nombre del proceso: $process_name"
echo "ID del proceso: $process_pid"
echo "Parent process ID: $parent_pid"
echo "Usuario propietario: $owner"
echo "Porcentaje de uso de CPU: $cpu_usage"
echo "Consumo de memoria: $memory_usage"
echo "Estado: $status"
echo "Path del ejecutable: $executable"
