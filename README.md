# Notass

Notas en el escritorio al estilo **conky**, en la esquina superior derecha de la pantalla.
Hecho en Lua para Linux Mint.

## Instalación

```bash
git clone https://github.com/Eutanasi0/Notass.git
cd Notass
./install.sh
```

Requiere `conky` y `lua` (el instalador los instala si faltan).

## Uso

```bash
notass                       # abre el widget
notass add "comprar pan"     # agrega una nota
notass delete 2              # elimina la nota número 2
notass list                  # muestra las notas en la terminal
notass stop                  # cierra el widget
```

## Archivos

| Archivo | Qué hace |
|---|---|
| `notass` | comando de terminal |
| `notass.conf` | configuración de conky (posición, fuente, colores) |
| `notass.lua` | lee las notas, las formatea y dibuja el banner infinito |

Las notas se guardan en `~/.local/share/notass/notas.txt` (una por línea).
