# Búsqueda de Series y Películas en Android - Xtend

Ejemplo que permite buscar películas en base al título. La aplicación se divide en

## Instalación
* parte cliente en Android, presente en este repositorio
* **servicio REST**: en [Grails](https://github.com/uqbar-project/eg-videoclub-ui-grails) o [XTrest](https://github.com/uqbar-project/eg-videoclub-xtrest) 

## Conceptos que se ven en la app

* Uso de Activities vs. Fragment para manejar diferentes dispositivos
* Navegación entre vistas mediante el uso de Intent
* Redefinición del layout de una ListView y del detalle de una película
* Binding manual de propiedades entre objetos de dominio (Película / Genero) y objetos visuales
