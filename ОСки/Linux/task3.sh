#!/bin/bash

LOG_FILE="operations.log"  

USER_REGEX="^(usr|www)04[0-9]+$"
GROUP_REGEX="^(grp|ddd)04[0-9]+$"


create_user() {
    read -p "Введите имя нового пользователя: " username
    if [[ ! $username =~ $USER_REGEX ]]; then
        echo "Неправильное имя пользователя. Имя должно соответствовать формату usrNN* или wwwNN*."
        return
    fi
    read -p "Введите пароль для нового пользователя: " password
    read -p "Введите основную группу для нового пользователя: " primary_group
    if [[ ! $primary_group =~ $GROUP_REGEX ]]; then
        echo "Неправильное имя группы. Имя должно соответствовать формату grpNN* или dddNN*."
        return
    fi
    sudo useradd -m -s /bin/bash -g $primary_group $username
    echo "$username:$password" | sudo chpasswd
    echo "$(date): Создан новый пользователь $username." >> "$LOG_FILE"
    echo "Пользователь $username успешно создан."
}


create_group() {
    read -p "Введите имя новой группы: " groupname
    if [[ ! $groupname =~ $GROUP_REGEX ]]; then
        echo "Неправильное имя группы. Имя должно соответствовать формату grpNN* или dddNN*."
        return
    fi
    sudo groupadd $groupname
    echo "$(date): Создана новая группа $groupname." >> "$LOG_FILE"
    echo "Группа $groupname успешно создана."
}


modify_user_parameters() {
    read -p "Введите имя пользователя для изменения параметров: " username
    if [[ ! $username =~ $USER_REGEX ]]; then
        echo "Неправильное имя пользователя. Имя должно соответствовать формату usrNN* или wwwNN*."
        return
    fi
    echo "Выберите параметр для изменения:"
    echo "1. Вторичная группа"
    echo "2. Комментарий"
    echo "3. Устаревание пароля"
    echo "4. Наличие периода неактивности"
    echo "5. Блокировка / Разблокировка"

    read -p "Введите номер параметра: " param_choice

    case $param_choice in
        1) read -p "Введите новое имя вторичной группы: " secondary_group
           sudo usermod -a -G $secondary_group $username ;;
        2) read -p "Введите новый комментарий: " comment
           sudo usermod -c "$comment" $username ;;
        3) read -p "Введите количество дней до устаревания пароля (0 для отключения): " password_expire_days
           sudo chage -M $password_expire_days $username ;;
        4) read -p "Введите количество дней неактивности (0 для отключения): " inactive_days
           sudo usermod -f $inactive_days $username ;;
        5) read -p "Блокировать пользователя? (yes/no): " block_choice
           case $block_choice in
               yes) sudo usermod -L $username ;;
               no) sudo usermod -U $username ;;
               *) echo "Неправильный ввод." ;;
           esac ;;
        *) echo "Неправильный ввод." ;;
    esac

    echo "$(date): Изменены параметры пользователя $username." >> "$LOG_FILE"
    echo "Параметры пользователя $username успешно изменены."
}


output_configuration() {
    echo "Конфигурация учетных записей:" > configuration.txt
    echo "" >> configuration.txt
    echo "Пользователи:" >> configuration.txt
    cat /etc/passwd >> configuration.txt
    echo "" >> configuration.txt
    echo "Группы:" >> configuration.txt
    cat /etc/group >> configuration.txt
    echo "$(date): Конфигурация учетных записей была успешно записана в файл configuration.txt." >> "$LOG_FILE"
    echo "Конфигурация учетных записей была успешно записана в файл configuration.txt."
}


main() {
    while true; do
        echo "Выберите действие:"
        echo "1. Создать пользователя"
        echo "2. Создать группу"
        echo "3. Изменить конфигурацию пользователя"
        echo "4. Вывести конфигурацию всех учетных записей"
        echo "5. Выйти"

        read -p "Введите номер действия: " choice

        case $choice in
            1) create_user ;;
            2) create_group ;;
            3) modify_user_parameters ;;
            4) output_configuration ;;
            5) exit ;;
            *) echo "Неправильный ввод. Пожалуйста, введите число от 1 до 5." ;;
        esac
    done
}


if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi


main
