#!/bin/bash

log_operation() {
    echo "$(date +"%Y-%m-%d %T") $1" >> operation_log.txt
}


execute_mixture() {
    case $1 in
        1)
            df -h >> operation_log.txt
            ;;
        2)
            gnome-calculator
            ;;
        3)
            tar -czvf backup_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz /home/*
            ;;
        4)
            zenity --info --text="Happy New Year !"
            ;;
        *)
            echo "Unknown MIXTURE command"
            ;;
    esac
}

main() {
    while true; do
        current_minute=$(date +"%M")
        
        case $current_minute in
            "00"|"04"|"08"|"12"|"16"|"20"|"24"|"28"|"32"|"36"|"40"|"44"|"48"|"52"|"56")
                execute_mixture 1
                log_operation "MIXTURE 1 executed"
                ;;
            "14")
                execute_mixture 2
                log_operation "MIXTURE 2 executed"
                ;;
            *)
                ;;
        esac

        if [ $(date +%u) -eq 4 ] && [ $(date +"%H%M") == "1937" ]; then
            execute_mixture 3
            log_operation "MIXTURE 3 executed"
        fi

        if [ $(date +"%m%d") == "1231" ] && [ $(date +"%H%M") == "2359" ]; then
            execute_mixture 4
            log_operation "MIXTURE 4 executed"
        fi

        sleep 60 
    done
}

echo "Enter the name of the dataset (DATA): "
read data_name
echo "DATA: $data_name" >> operation_log.txt
main 
