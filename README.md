# 🚀 Bash Automation Scripts

<div align="center">

Набор Bash-скриптов для автоматизации работы с файлами.

![Bash](https://img.shields.io/badge/Bash-Scripting-green?style=for-the-badge&logo=gnu-bash)
![Linux](https://img.shields.io/badge/Linux-Supported-blue?style=for-the-badge&logo=linux)
![macOS](https://img.shields.io/badge/macOS-Supported-lightgrey?style=for-the-badge&logo=apple)
![Windows](https://img.shields.io/badge/Windows-Git%20Bash%20%7C%20WSL-blue?style=for-the-badge&logo=windows)

</div>

---

# 📋 Содержание

- [О проекте](#-о-проекте)
- [📝 laba_6.sh](#-laba_6sh)
- [📂 mega_sort.sh](#-mega_sortsh)
- [⚙ Установка](#-установка)
- [🖥 Запуск в Windows](#-запуск-в-windows)
- [🐧 Запуск в Linux](#-запуск-в-linux)
- [🍏 Запуск в macOS](#-запуск-в-macos)

---

# 📖 О проекте

Проект содержит два Bash-скрипта для автоматизации работы с текстовыми файлами и каталогами.

| Скрипт | Назначение |
|---------|---------|
| **laba_6.sh** | Массовая замена текста во всех `.txt` файлах |
| **mega_sort.sh** | Автоматическая сортировка файлов и папок по возрасту |

---

# 📝 laba_6.sh

## Возможности

Скрипт выполняет поиск и замену текста во всех `.txt` файлах внутри указанной директории и её подкаталогов.

### Алгоритм работы

```text
1. Проверка аргументов
2. Проверка существования каталога
3. Поиск всех .txt файлов
4. Замена текста через sed
5. Проверка результата
6. Сообщение об успехе или ошибке
```

---

## Блок-схема

<div align="center">

<img src="laba_6.png" width="700">

</div>

---

## Использование

```bash
./laba_6.sh "путь_к_директории" "старая_строка" "новая_строка"
```

### Пример

```bash
./laba_6.sh "./documents" "Hello" "Hi"
```

---

# 📂 mega_sort.sh

## Возможности

Скрипт автоматически сортирует файлы и папки по времени последнего изменения.

Создаёт категории:

| Папка | Возраст |
|---------|---------|
| [7]_days | до 7 дней |
| [14]_days | до 14 дней |
| [30]_days | до 30 дней |
| [90]_days | до 90 дней |
| [365]_days | до 1 года |
| [365+]_days | более 1 года |

---

## Алгоритм работы

```text
1. Проверка аргументов
2. Проверка директории
3. Создание папок категорий
4. Получение времени изменения файлов
5. Вычисление возраста объекта
6. Выбор категории
7. Перемещение файла
8. Защита от перемещения самого скрипта и служебных папок
```

---

## Блок-схема

<div align="center">

<img src="mega_sort.png" width="700">

</div>

---

## Использование

```bash
./mega_sort.sh "путь_к_директории"
```

### Пример

```bash
./mega_sort.sh "/home/user/Downloads"
```

---

# ⚙ Установка

Клонировать репозиторий:

```bash
git clone https://github.com/USERNAME/REPOSITORY.git
```

Перейти в каталог проекта:

```bash
cd REPOSITORY
```

Выдать права на выполнение:

```bash
chmod +x laba_6.sh
chmod +x mega_sort.sh
```

---

# 🖥 Запуск в Windows

### Git Bash

Скачать:

https://git-scm.com/download/win

Запуск:

```bash
./laba_6.sh "/c/Users/User/Documents" "old" "new"
```

```bash
./mega_sort.sh "/c/Users/User/Documents"
```

---

### WSL

Установка:

```powershell
wsl --install
```

После установки:

```bash
chmod +x *.sh
```

```bash
./laba_6.sh ...
```

```bash
./mega_sort.sh ...
```

---

# 🐧 Запуск в Linux

Проверка Bash:

```bash
bash --version
```

Запуск:

```bash
./laba_6.sh "директория" "старое" "новое"
```

```bash
./mega_sort.sh "директория"
```

---

# 🍏 Запуск в macOS

Проверка Bash:

```bash
bash --version
```

Выдача прав:

```bash
chmod +x *.sh
```

Запуск:

```bash
./laba_6.sh "директория" "старое" "новое"
```

```bash
./mega_sort.sh "директория"
```

---

# 🛠 Используемые технологии

- Bash
- GNU sed
- GNU find
- stat
- mv
- chmod

---

# 👨‍💻 Автор

Лабораторная работа по Bash-программированию и автоматизации обработки файловой системы.
