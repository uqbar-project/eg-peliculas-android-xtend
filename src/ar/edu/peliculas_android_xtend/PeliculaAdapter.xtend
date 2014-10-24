package ar.edu.peliculas_android_xtend

import android.content.Context
import android.view.View
import android.view.ViewGroup
import ar.edu.peliculas.domain.Pelicula
import java.util.List

class PeliculaAdapter extends AbstractListAdapter<Pelicula> {

	new() {
		
	}
	
	new(Context pContext, List<Pelicula> peliculas) {
		context = pContext
		objects = peliculas
	}

	
	override getView(int position, View convertView, ViewGroup parent) {
		val pelicula = getItem(position) as Pelicula
		val row = generateRow(R.layout.pelicula_row, parent)
		generateColumnTextView(row, R.id.txtTitulo, pelicula.titulo)
		generateColumnTextView(row, R.id.txtGenero, pelicula.descripcionGenero) 
		row
	}
	
}
