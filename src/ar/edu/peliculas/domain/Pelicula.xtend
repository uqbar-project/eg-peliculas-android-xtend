package ar.edu.peliculas.domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.io.Serializable

@Accessors
class Pelicula implements Serializable {
	
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