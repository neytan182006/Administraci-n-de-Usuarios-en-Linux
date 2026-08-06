#!/bin/bash
#
# Menu de administracion de usuarios en Linux (Ubuntu/Debian).
# Requiere ejecutarse con privilegios de root (sudo).
#
# Uso: sudo ./menu.sh

set -euo pipefail

verificar_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "Este script debe ejecutarse como root (usa: sudo ./menu.sh)"
        exit 1
    fi
}

crear_usuario() {
    read -rp "Nombre de usuario a crear: " usuario
    if id "$usuario" &>/dev/null; then
        echo "El usuario '$usuario' ya existe."
        return
    fi
    useradd -m -s /bin/bash "$usuario"
    passwd "$usuario"
    read -rp "Agregar a un grupo adicional (dejar vacio para omitir): " grupo
    if [[ -n "$grupo" ]]; then
        usermod -aG "$grupo" "$usuario"
        echo "Usuario '$usuario' agregado al grupo '$grupo'."
    fi
    echo "Usuario '$usuario' creado con directorio home y shell bash."
}

eliminar_usuario() {
    read -rp "Nombre de usuario a eliminar: " usuario
    if ! id "$usuario" &>/dev/null; then
        echo "El usuario '$usuario' no existe."
        return
    fi
    read -rp "¿Eliminar tambien su directorio home? (s/n): " confirmacion
    if [[ "$confirmacion" == "s" ]]; then
        userdel -r "$usuario"
    else
        userdel "$usuario"
    fi
    echo "Usuario '$usuario' eliminado."
}

listar_usuarios() {
    echo "Usuarios con shell de login (UID >= 1000, sin cuentas de sistema):"
    awk -F: '$3 >= 1000 && $3 < 65534 { print $1 " (UID " $3 ")" }' /etc/passwd
}

modificar_grupo() {
    read -rp "Nombre de usuario: " usuario
    if ! id "$usuario" &>/dev/null; then
        echo "El usuario '$usuario' no existe."
        return
    fi
    read -rp "Grupo a agregar: " grupo
    usermod -aG "$grupo" "$usuario"
    echo "Usuario '$usuario' agregado al grupo '$grupo'."
    echo "Grupos actuales: $(groups "$usuario")"
}

bloquear_usuario() {
    read -rp "Nombre de usuario a bloquear: " usuario
    passwd -l "$usuario"
    echo "Usuario '$usuario' bloqueado (no puede iniciar sesion con contraseña)."
}

mostrar_menu() {
    echo ""
    echo "=== ADMINISTRACION DE USUARIOS EN LINUX ==="
    echo "1. Crear usuario"
    echo "2. Eliminar usuario"
    echo "3. Listar usuarios"
    echo "4. Agregar usuario a un grupo"
    echo "5. Bloquear usuario"
    echo "0. Salir"
}

verificar_root

while true; do
    mostrar_menu
    read -rp "Seleccione una opcion: " opcion
    case "$opcion" in
        1) crear_usuario ;;
        2) eliminar_usuario ;;
        3) listar_usuarios ;;
        4) modificar_grupo ;;
        5) bloquear_usuario ;;
        0) echo "Hasta luego."; break ;;
        *) echo "Opcion invalida." ;;
    esac
done
