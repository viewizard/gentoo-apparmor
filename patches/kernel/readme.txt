Патчи расчитаны на модуль ядра Apparmor из апстрима ядра Ubuntu.

http://kernel.ubuntu.com/git/ - ищем нужный, смотрим через web
например,
http://kernel.ubuntu.com/git/ubuntu/ubuntu-artful.git/

1) Клонируем во временное место полностью ядро
git clone git://kernel.ubuntu.com/ubuntu/ubuntu-artful.git
2) Переносим нужную версию модуля ./security/apparmor как есть (нет смысла делать патч, просто копируем).
3) Патчим.
