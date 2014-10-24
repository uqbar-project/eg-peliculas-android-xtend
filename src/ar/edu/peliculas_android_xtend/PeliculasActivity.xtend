package ar.edu.peliculas_android_xtend

import android.content.Context
import android.os.Bundle
import android.support.v7.app.ActionBarActivity
import android.text.Editable
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.view.View.OnClickListener
import android.widget.CheckBox
import android.widget.EditText
import android.widget.ImageButton
import android.widget.ListView
import ar.edu.peliculas.domain.Pelicula
import ar.edu.peliculas.service.PeliculasService
import java.util.List
import retrofit.Callback
import retrofit.RestAdapter
import retrofit.RetrofitError
import retrofit.client.Response

import static ar.edu.peliculas_android_xtend.PeliculasActivity.*

class PeliculasActivity extends ActionBarActivity implements OnClickListener {
	static int MIN_BUSQUEDA_PELICULAS = 2

	override onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_peliculas)
		
		// Comportamiento del checkbox que indica si se busca a medida que se escribe
		val chkBuscar = findViewById(R.id.chkBuscarOnline) as CheckBox
		chkBuscar.onClickListener = [ View v | 
			val btnBuscar = findViewById(R.id.btnBuscar) as ImageButton
			if (chkBuscar.checked) {
				btnBuscar.visibility = View.INVISIBLE
			} else {
				btnBuscar.visibility = View.VISIBLE
			}
		]
			
		// Comportamiento del título de búsqueda
		val tituloContiene = findViewById(R.id.tituloContiene) as EditText
		tituloContiene.addTextChangedListener(new BaseTextWatcher() {
			
			override afterTextChanged(Editable editable) {
				if (chkBuscar.checked && editable.length >= MIN_BUSQUEDA_PELICULAS) {
					buscarPeliculas
				}
			}
			
			})
		val botonConvertir = findViewById(R.id.btnBuscar) as ImageButton
		botonConvertir.onClickListener = this		
	}

	override onCreateOptionsMenu(Menu menu) {

		// Inflate the menu this adds items to the action bar if it is present.
		menuInflater.inflate(R.menu.peliculas, menu)
		true
	}

	override onOptionsItemSelected(MenuItem item) {

		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		val id = item.getItemId()
		if (id == R.id.action_settings) {
			return true
		}
		return super.onOptionsItemSelected(item)
	}

	def void buscarPeliculas() {
		// Construimos el servicio REST al que tenemos que llamar
		//val API_URL = "http://localhost:8080/videoclub-ui-orm-grails"
		// No funciona localhost , hay que usa 10.0.2.2
		// Esta URL apunta al proyecto con ORM de Grails 
		// val API_URL = "http://10.0.2.2:8080/videoclub-ui-orm-grails"
		// Esta URL apunta a la solución en Grails con Homes hechos en Xtend
		val API_URL = "http://10.0.2.2:8080/videoclub-ui-grails-homes-xtend"
		
		val restAdapter = new RestAdapter.Builder().setEndpoint(API_URL).build
		val PeliculasService peliculasService = restAdapter.create(typeof(PeliculasService))

		// Invocamos al servicio acá
		peliculasService.getPeliculas(tituloContiene, 
			new Callback<List<Pelicula>>() {

				override failure(RetrofitError e) {
					Log.e("", e.message)
					e.printStackTrace
				}

				override success(List<Pelicula> peliculas, Response response) {
					mostrarPeliculas(peliculas)
					//peliculas.forEach [ pelicula |
					//	Log.w("getPeliculas", pelicula.titulo + ' ' + pelicula.genero.descripcion)
					//]
				}

			})
		
	}
	
	override onClick(View v) {
		buscarPeliculas
	}

	def tituloContiene() {
		val campoBusqueda = findViewById(R.id.tituloContiene) as EditText
		campoBusqueda.text.toString
	}

	def void mostrarPeliculas(List<Pelicula> peliculas) {
		val lv = findViewById(R.id.lvPeliculas) as ListView
		val prestamoAdapter = new PeliculaAdapter(this as Context, peliculas)
		lv.adapter = prestamoAdapter
		lv.choiceMode = ListView.CHOICE_MODE_SINGLE
		registerForContextMenu(lv)
	}	
}
