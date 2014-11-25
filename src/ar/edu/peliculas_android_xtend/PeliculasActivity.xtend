package ar.edu.peliculas_android_xtend

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.ActionBarActivity
import android.text.Editable
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.view.View.OnClickListener
import android.widget.AdapterView
import android.widget.AdapterView.OnItemClickListener
import android.widget.CheckBox
import android.widget.EditText
import android.widget.ImageButton
import android.widget.ListView
import android.widget.Toast
import ar.edu.peliculas.domain.Pelicula
import ar.edu.peliculas.service.PeliculasService
import java.util.List
import retrofit.Callback
import retrofit.RestAdapter
import retrofit.RetrofitError
import retrofit.client.Response

/**
 * 
 * @author fdodino
 * @author jfernandes
 */
class PeliculasActivity extends ActionBarActivity implements OnClickListener, OnItemClickListener {
	static int MIN_BUSQUEDA_PELICULAS = 2

	override onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState)
		contentView = R.layout.activity_peliculas
		
		// Comportamiento del checkbox que indica si se busca a medida que se escribe
		val chkBuscar = findViewById(R.id.chkBuscarOnline) as CheckBox
		chkBuscar.onClickListener = [ View v | 
			val btnBuscar = findViewById(R.id.btnBuscar) as ImageButton
			btnBuscar.visibility = if (chkBuscar.checked) View.INVISIBLE else  View.VISIBLE
		]
			
		// Comportamiento del título de búsqueda
		val tituloContiene = findViewById(R.id.tituloContiene) as EditText
		tituloContiene.addTextChangedListener(
			[ Editable editable | 
				if (chkBuscar.checked && editable.length >= MIN_BUSQUEDA_PELICULAS) {
					buscarPeliculas
				}
			] as BaseTextWatcher)
		
		findViewById(R.id.btnBuscar) as ImageButton => [
			onClickListener = this
		]
		
		findViewById(R.id.lvPeliculas) as ListView => [
			onItemClickListener = this
		]
	}

	override onCreateOptionsMenu(Menu menu) {
		// Inflate the menu this adds items to the action bar if it is present.
		menuInflater.inflate(R.menu.peliculas, menu)
		true
	}

	override onOptionsItemSelected(MenuItem item) {
		val id = item.itemId
		if (id == R.id.action_settings)
			return true
		return super.onOptionsItemSelected(item)
	}

	def void buscarPeliculas() {
		val peliculasService = createPeliculasService()

		peliculasService.getPeliculas(tituloContiene, 
			new Callback<List<Pelicula>>() {

				override failure(RetrofitError e) {
					Log.e("", e.message)
					e.printStackTrace
				}

				override success(List<Pelicula> peliculas, Response response) {
					mostrarPeliculas(peliculas)
				}

			})
		
	}
	
	protected def createPeliculasService() {
		// Esta URL apunta al proyecto con ORM de Grails 
		// 		val API_URL = "http://10.0.2.2:8080/videoclub-ui-orm-grails"
		// Esta URL apunta a la solución en Grails con Homes hechos en Xtend
		//		val SERVER_IP = "10.0.2.2"
		
		//val SERVER_IP = "169.254.196.145"
		val SERVER_IP = "10.0.2.2"
		val API_URL = '''http://«SERVER_IP»:8080/videoclub-ui-grails-homes-xtend'''
		
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val PeliculasService peliculasService = restAdapter.create(PeliculasService)
		peliculasService
	}
	
	override onClick(View v) {
		buscarPeliculas
	}

	def tituloContiene() {
		val campoBusqueda = findViewById(R.id.tituloContiene) as EditText
		campoBusqueda.text.toString
	}

	def void mostrarPeliculas(List<Pelicula> peliculas) {
		findViewById(R.id.lvPeliculas) as ListView => [
			adapter = new PeliculaAdapter(this as Context, peliculas)
			choiceMode = ListView.CHOICE_MODE_SINGLE
		]
	}

	// ListView: seleccion de pelicula
	
	override onItemClick(AdapterView<?> parent, View view, int position, long id) {
		val pelicula = parent.adapter.getItem(position) as Pelicula
		
		Toast.makeText(applicationContext, pelicula.titulo, Toast.LENGTH_LONG).show
		
		val detailIntent = new Intent(this, DetallePeliculaActivity) => [
			putExtra(DetallePeliculaActivity.PELICULA_ARG, pelicula)
		]
		startActivity(detailIntent)
	}
	
}
