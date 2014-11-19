package ar.edu.peliculas_android_xtend

import android.app.Activity
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.ListView
import android.widget.TextView
import ar.edu.peliculas.domain.Pelicula

/**
 * @author jfernandes
 */
class DetallePeliculaActivity extends Activity {
	public static val PELICULA_ARG = "PELICULA_ARG"
	Pelicula pelicula
	
	override onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState)
		contentView = R.layout.activity_pelicula_detalle
		
		this.pelicula = intent.getSerializableExtra(PELICULA_ARG) as Pelicula
		
		findViewById(R.id.detalle_titulo) as TextView => [
			text = pelicula.titulo
		]
		
		findViewById(R.id.detalle_genero) as TextView => [
			text = pelicula.genero.descripcion
		]
		
		findViewById(R.id.detalle_actores) as ListView => [
			adapter = new ArrayAdapter(this, R.layout.generos_items, R.id.genero_descripcion, pelicula.actores.split(","))
		]
	}
	
}