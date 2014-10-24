package ar.edu.peliculas.service

import ar.edu.peliculas.domain.Pelicula
import java.util.List
import retrofit.Callback
import retrofit.http.GET
import retrofit.http.Path

interface PeliculasService {
	
  @GET("/peliculas/{tituloContiene}")
  def void getPeliculas(@Path("tituloContiene") String tituloContiene, Callback<List<Pelicula>> callback)
  
}