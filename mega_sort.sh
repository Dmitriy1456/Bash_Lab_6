#!/bin/bash

# Проверка аргументов и настройка

if [ "$#" -ne 1 ]; then
    echo "Ошибка: Укажи директорию."
    echo "Пример: $0 \"/c/Users/Имя/МоиФайлы\""
    exit 1
fi

TARGET_DIR="$1"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Ошибка: Директория '$TARGET_DIR' не существует."
    exit 1
fi

# Имена папок категорий
DIR_1W="[7]_days"
DIR_2W="[14]_days"
DIR_1M="[30]_days"
DIR_3M="[90]_days"
DIR_1Y="[365]_days"
DIR_OLD="[365+]_days"

# Создаем массив со всеми категориями для удобства работы
CATEGORIES=("$DIR_1W" "$DIR_2W" "$DIR_1M" "$DIR_3M" "$DIR_1Y" "$DIR_OLD")

# Создаем папки (если они уже есть, ключ -p не выдаст ошибку)
for cat in "${CATEGORIES[@]}"; do
    mkdir -p "$TARGET_DIR/$cat"
done

CURRENT_TIME=$(date +%s)
SCRIPT_NAME=$(basename "$0")

# Формируем список директорий для поиска
# Ищем в корневой папке, а также заглядываем внутрь каждой созданной категории,
# чтобы проверить, не устарели ли там файлы/папки.
SEARCH_DIRS=("$TARGET_DIR")
for cat in "${CATEGORIES[@]}"; do
    SEARCH_DIRS+=("$TARGET_DIR/$cat")
done

# Перебор и/или пересортировОЧКА

echo "Запуск умной актуализации в '$TARGET_DIR'..."

for search_dir in "${SEARCH_DIRS[@]}"; do
    
    # Ищем все файлы и папки на 1-ом уровне
    find "$search_dir" -mindepth 1 -maxdepth 1 | while read -r item; do
        item_name=$(basename "$item")
        #---------------------------------------------------------------------
	#  СЛУЖЕБНЫЕ ПАПКИ И СКРИПТ НЕ СОРТИРУЕМ
        if [ "$item_name" == "$SCRIPT_NAME" ]; then continue; fi
        
        # Пропускаем сами папки категорий, чтобы не переместить их друг в другА
        is_category=0
        for cat in "${CATEGORIES[@]}"; do
            if [ "$item_name" == "$cat" ]; then
                is_category=1
                break
            fi
        done
        if [ "$is_category" -eq 1 ]; then continue; fi
        # ----------------------------------------------------------------------

        # Получаем время посл. изменения
        MOD_TIME=$(stat -c %Y "$item" 2>/dev/null)
        if [ -z "$MOD_TIME" ]; then continue; fi

        # Считаем разницу в днях
        DIFF_DAYS=$(( (CURRENT_TIME - MOD_TIME) / 86400 ))

        # Определяем, в какой папке должен лежать элемент сейчас
        if [ "$DIFF_DAYS" -le 7 ]; then TARGET_CAT="$DIR_1W"
        elif [ "$DIFF_DAYS" -le 14 ]; then TARGET_CAT="$DIR_2W"
        elif [ "$DIFF_DAYS" -le 30 ]; then TARGET_CAT="$DIR_1M"
        elif [ "$DIFF_DAYS" -le 90 ]; then TARGET_CAT="$DIR_3M"
        elif [ "$DIFF_DAYS" -le 365 ]; then TARGET_CAT="$DIR_1Y"
        else TARGET_CAT="$DIR_OLD"; fi

        TARGET_PATH="$TARGET_DIR/$TARGET_CAT"
        CURRENT_PATH=$(dirname "$item")

        # Перемещаем ТОЛЬКО если элемент лежит не там, где должен
        if [ "$CURRENT_PATH" != "$TARGET_PATH" ]; then
            echo "Перемещение: '$item_name' -> $TARGET_CAT"
            mv "$item" "$TARGET_PATH/"
        fi
    done
done

echo "Успех: Порядок наведен, все файлы и папки на своих местах!"
exit 0

