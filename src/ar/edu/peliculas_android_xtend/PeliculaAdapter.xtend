package ar.edu.peliculas_android_xtend

import android.view.View
import android.view.ViewGroup
import ar.edu.peliculas.domain.Pelicula
import android.content.Context
import java.util.List

class PeliculaAdapter extends AbstractListAdapter<Pelicula> {

	new(Context context, List<Pelicula> peliculas) {
		super(context, peliculas)
	}
	
	override getView(int position, View convertView, ViewGroup parent) {
		val pelicula = getItem(position) as Pelicula
		val row = generateRow(R.layout.pelicula_row, parent)
		setColumnTextView(row, R.id.txtTitulo, pelicula.titulo)
		setColumnTextView(row, R.id.txtGenero, pelicula.descripcionGenero) 
		row
	}
	
}
