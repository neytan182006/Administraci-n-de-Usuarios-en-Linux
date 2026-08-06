# Administración de Usuarios en Linux

Script de menú en Bash para administrar usuarios y grupos en Ubuntu/Debian, para el curso de **Sistemas Operativos**.

## Funcionalidades

- Crear usuario (con directorio home, shell bash, contraseña y grupo opcional).
- Eliminar usuario (con opción de borrar su directorio home).
- Listar usuarios reales (UID ≥ 1000, excluye cuentas de sistema).
- Agregar usuario a un grupo adicional.
- Bloquear usuario (`passwd -l`).

## Estructura

```
scripts/menu.sh   → menú interactivo, requiere privilegios de root
```

## Cómo ejecutarlo

```bash
chmod +x scripts/menu.sh
sudo ./scripts/menu.sh
```

> **Sobre la verificación**: este entorno de desarrollo es Windows (Git Bash/Cygwin), sin `useradd`/`usermod`/`passwd` reales de Linux — **verifiqué la sintaxis** del script con `bash -n scripts/menu.sh` (sin errores), pero **no pude ejecutarlo de verdad** creando/eliminando usuarios reales. Pruébalo en una VM o servidor Ubuntu antes de usarlo en producción.

## Capturas

_Pendiente: agregar capturas de la ejecución en una VM Ubuntu real en `capturas/`._

## Licencia

MIT — ver [LICENSE](LICENSE).
