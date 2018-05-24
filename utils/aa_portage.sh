#!/bin/bash
# --------------------------------------------------------------------
#
#    Copyright (C) 2017 Mikhail Kurinnoi
#
#    This program is free software; you can redistribute it and/or
#    modify it under the terms of version 2 of the GNU General Public
#    License published by the Free Software Foundation.
#
# --------------------------------------------------------------------

# Параметры по умолчанию.
# Расположение профилей.
AA_PROFILES="/etc/apparmor.d"
# количество потоков (оптимально: кол-во ядер + 1)
THREADS=$(( $(grep -c ^processor /proc/cpuinfo) + 1 ))

NEED_RM_BINARY_CACHE="no"
NEED_CHECK_INSTALLED="no"
NEED_GENERATE_BIN_CACHE="no"

function print_help () {
	echo "Использование: aa_portage.sh [КЛЮЧ]…"
	echo "Скрипт проверяет соответствие рабочих и выключенных профилей AppArmor и"
	echo "генерирует новый набор бинарных кэшей с использованием многопоточности."
	echo ""
	echo "  --path=КАТАЛОГ     расположение профилей"
	echo "                     по умолчанию, /etc/apparmor.d"
	echo "  --threads=КОЛ-ВО   количество одновременно используемых потоков"
	echo "                     по умолчанию, равно кол-вам ядер + 1"
	echo "  -a, --all,         удалить кэши, проверить установленные пакеты"
	echo "                     и сгенерировать новые кэши"
	echo "  -d, --delete,      удалить кэши"
	echo "  -c, --check,       проверить установленные пакеты"
	echo "  -g, --generate,    сгенерировать новые кэши"
	echo "  -h, --help,        показать эту справку и выйти"
}

function rm_binary_cache () {
	for p in /etc/apparmor.d/cache/*; do

		if [ ! -f $p ]; then
			continue
		fi

		BMANE=$(basename ${p})
		case "${BMANE}" in
			.*)
				continue
			;;
			*)
				rm ${p}
			;;
		esac

	done
}

function check_installed () {
	EQUERY_LIST=$(equery list --format=@'$name'@ '*')

	for p in ${AA_PROFILES}/*; do

		if [ ! -f $p ]; then
			continue
		fi

		case "${p}" in
			# Базовые профили, не имеющие пакетов.
			${AA_PROFILES}/0_default|${AA_PROFILES}/1_shell|${AA_PROFILES}/2_local|${AA_PROFILES}/3_kernel)
				continue
			;;
			# Проверяем все профили.
			*)
				BMANE=$(basename ${p})
				RES=$(echo -e "${EQUERY_LIST}" | grep @$BMANE@)
				if [ "$RES" == "" ]; then
					# "Пакет не установлен."
					if [ ! -L "${AA_PROFILES}/disable/$BMANE" ]; then
						echo "$BMANE - пакет не установлен, не обнаружен симлинк в ./disable/"
						ln -sr "${AA_PROFILES}/$BMANE" "${AA_PROFILES}/disable/$BMANE" || \
							echo "... ошибка создания симлинка."
					fi
				else
					# "Пакет установлен."
					if [ -L "${AA_PROFILES}/disable/$BMANE" ]; then
						echo "$BMANE - пакет установлен, обнаружен симлинк в ./disable/"
						rm "${AA_PROFILES}/disable/$BMANE" || \
							echo "... ошибка удаления симлинка."
					fi
				fi
			;;
		esac

	done
}

function generate_binary_cache () {

	for p in ${AA_PROFILES}/*; do

		if [ ! -f $p ]; then
			continue
		fi

		apparmor_parser -rWQ $p 1>/dev/null &

		if [ "$?" != "0" ]; then
			break
		fi

		# элемент реализации многопоточности, нельзя превышать THREADS
		while (( $(jobs 2>&1 | grep -c Running) >= ${THREADS} )); do
			jobs > /dev/null
		done

	done

	# ожидаем завершение всех дочерних потоков
	wait
}

# Обход всех переданных параметров.
for x in $@; do
	case "${x}" in
		--path=*)
			AA_PROFILES=${x#*=}
		;;
		--threads=*)
			THREADS=${x#*=}
		;;
		--all|-a)
			NEED_RM_BINARY_CACHE="yes"
			NEED_CHECK_INSTALLED="yes"
			NEED_GENERATE_BIN_CACHE="yes"
		;;
		--delete|-d)
			NEED_RM_BINARY_CACHE="yes"
		;;
		--check|-c)
			NEED_CHECK_INSTALLED="yes"
		;;
		--generate|-g)
			NEED_GENERATE_BIN_CACHE="yes"
		;;
		--help|-h)
			print_help
			exit
		;;
	esac
done
if [[ $@ == "" ]]; then print_help; exit; fi

if [ ! -d "$AA_PROFILES" ]; then
	echo "Каталог с профилями не найден."
	exit 1
fi
re='^[0-9]+$'
if ! [[ $THREADS =~ $re ]] ; then
	echo "Кол-во потоков должно быть задано положительным числом."
	exit 1
fi

echo "Каталог с профилями: $AA_PROFILES"
echo "Потоков: $THREADS"

if [[ $NEED_RM_BINARY_CACHE == "yes" ]]; then rm_binary_cache; fi
if [[ $NEED_CHECK_INSTALLED == "yes" ]]; then check_installed; fi
if [[ $NEED_GENERATE_BIN_CACHE == "yes" ]]; then generate_binary_cache; fi
