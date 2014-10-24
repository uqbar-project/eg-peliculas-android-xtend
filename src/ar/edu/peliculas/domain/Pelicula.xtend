package ar.edu.peliculas.domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Pelicula {
	
	String titulo
	Genero genero
	String actores
		
	override toString() {
		titulo
	}
	
	def getDescripcionGenero() {
		genero.descripcion
	}
	
}