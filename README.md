## ![GitHub](https://img.shields.io/github/license/kristiandz/ebc-pm)

Este repositorio contiene código en vivo del servidor de promoción.
El mod es estable y tiene todos los problemas conocidos resueltos, puedes usarlo según tus necesidades libremente, solo deja créditos. Siéntete libre de contribuir al proyecto.

Visítenos en [Discord KFC](https://discord.gg/Pss9ff2MH5) o únase al [servidor](https://www.gametracker.com/search/cod4/?query=KFC)

## Características

- Este es un mod creado a partir de una versión limpia de [Promod V2.20](https://promod.github.io/), solo están disponibles los modos custom_public y strat, la mayoría de las funciones de promoción se han eliminado, todo lo que no es necesario para los servidores de pub.
- Se han solucionado errores antiguos de los archivos promod y cod4 y hay actualizaciones del código que optimizan el mod y el servidor. eBc Promod es un mod bastante pesado, pero funcionará bastante bien con más de 100 MB de RAM que un servidor promocional típico o similar. El uso promedio para un servidor de 24 ranuras lleno y activo es de alrededor de 300-350 MB de RAM, o menos si reinicia el servidor diariamente, el mod ha estado funcionando durante semanas en ocasiones sin fallas ni reinicios.
- El mod presenta rangos que se eliminaron en la promoción y también incluye prestigios que no estaban disponibles en la versión para PC del juego. Hay 55 niveles y 30 niveles de prestigio. Con la configuración actual, los jugadores necesitan entre 4 y 5 meses de juego activo para alcanzar el nivel/límite de prestigio.
- El mod presenta temporadas que cambian cada 6 meses, incluido el reinicio de prestigio y rango. Después de cada temporada, los jugadores reciben premios en función del prestigio alcanzado. El servidor ejecuta una verificación de prestigio de los jugadores para evitar la explotación, también se registran muchos elementos para verificar fácilmente qué está sucediendo con la base de jugadores y el servidor.
- Puedes encontrar modelos de vista personalizados, sprays y Killcards que han sido portados desde diferentes mods/juegos; cada prestigio desbloquea un conjunto de recompensas.
- Hay 4 menús clave que están disponibles para diferentes rangos en el servidor. Un menú de configuración de gráficos/jugador, un menú de premios de prestigio, un menú VIP y un menú de administración.
- Mod ejecuta soporte SQL para ampliar las posibilidades de modificación y acceso a datos adminmod y otras bases de datos SQL para proporcionar una fácil integración con cualquier aplicación que ejecute.
- Mod está diseñado principalmente para los tipos de juego S&D y S&R, pero también puedes acceder a otros tipos de juego personalizados; ten en cuenta que no todos los tipos de juego de mixmod están disponibles aquí.
- Mod contiene muchas características, pero mantiene la simplicidad y una interfaz de usuario limpia, puedes encontrar cosas personalizadas como votación de mapas con movimiento de cámara personalizado, killcards, comandos personalizados para jugadores y administradores.
- El daño aumenta en 2 puntos en la devolución de llamada player_killed para evitar etiquetas con armas de francotirador, la desaceleración está desactivada y el límite de FPS se ha aumentado a 333. Se han eliminado las comprobaciones de promoción para algunos DVARS y las restricciones para adaptarse a la configuración del servidor de pub.
- Y muchos más para que explores y uses...

## Cómo trabajar en el mod

Siga estas instrucciones para ejecutar, editar y recompilar con éxito el trabajo que realizó

```
- Extrae el código de git al directorio de tu juego "/cod4/Mods/"
- Obtenga las herramientas CoD4 Mod y extráigalas en su directorio "/cod4/"
- Haga que el servidor CoD4X ejecute funciones posteriores a 1.7a que no están disponibles en Vanilla; de lo contrario, simplemente ejecute "devmap"
   desde la consola después de cargar el mod en el juego
- Después de haber editado el código a tu gusto, simplemente abre makeMod.bat y ejecuta build fastfile/iwd en caso de que
   actualizó activos o archivos de menú, si solo cambió los archivos gsc/gsx, simplemente cambie el mapa para cargar código nuevo
- Mientras trabajas en el mod en el juego, usa "/developer 1" y "/devmap map_name" para facilitar la depuración.
   junto con la salida en qconsole.log
```
Continúe leyendo la siguiente sección para conocer los requisitos, especialmente si desea trabajar en .gsx/1.7a y versiones posteriores.

## Cómo ejecutar el mod (solo para 1.7a+)

Si desea ejecutar la versión actual y más reciente del mod, necesitará algunas dependencias.

- Compatibilidad con MySQL desde [GSCLIB](https://github.com/Iswenzz/gsclib) en forma de un archivo complemento .dll/.so
- Compilación personalizada de CoD4X que incluye GSCLIB, como un binario personalizado que ejecuta para su servidor
- Base de datos MySQL en funcionamiento y acceso a ella.

Nota: El binario CoD4X y el complemento GSCLIB tendrán sus propias dependencias, puedes encontrarlas en sus páginas de github.
Deberá agregar parámetros personalizados al inicio para aumentar la cantidad de xassets disponibles y evitar errores en algunos mapas grandes. Además, no olvide cargar gsclib desde la configuración o el inicio, como cualquier otro complemento.

Si desea ejecutar la versión básica del mod, no tendrá todas las funciones y cargará la versión .gsc de los mismos archivos.
Para Vanilla no necesitas ninguna dependencia, simplemente carga el mod y ejecuta el servidor.
Todos los archivos que ejecutan .gsx deben tener su contraparte .gsc para el servidor Vanilla; en caso de que falten algunos, abra un problema o realice una solicitud de extracción.

En caso de que no quieras ejecutar MySQL, siempre puedes optar por el almacenamiento de archivos localmente, aunque no lo recomiendo, MySQL es aproximadamente 2 veces más rápido que antes.

## Archivos y carpetas necesarios para ejecutar el mod/servidor

- /maps/
- /promod/
- /kfc/
- /scripts/
- /camuflage Animado
- /config.cfg
- /mod.ff
- / archivos .iwd, dependiendo de cómo divida los activos

Los archivos IWD contienen /imágenes, /sonidos y /armas.

## Divertirse

Gracias a todos los que contribuyeron a este proyecto. Espero que lo aproveches bien, siéntete libre de contribuir y realizar una solicitud de extracción si decides realizar algunas actualizaciones.
El mod está en buen estado, pero siempre hay lugar para mejorar, el desarrollo activo de este mod se ha detenido y la fuente se está publicando, el mod aún recibirá correcciones y actualizaciones de las funciones existentes, en caso de que alguien decida contribuir con algo bueno. mejoras, te ayudaré con el trabajo. ¡Feliz codificación!
