package ar.edu.peliculas_android_xtend

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * 
 */
@Accessors
abstract class AbstractListAdapter<T> extends BaseAdapter {
	Context context
	List<T> objects

	new() {
	}

	override getCount() {
		objects.size
	}

	override getItem(int position) {
		objects.get(position)
	}

	override getItemId(int position) {
		position
	}

	/* Helper methods para crear el adapter */
	def generateRow(int rowLayoutId, ViewGroup parent) {
		val inflater = LayoutInflater.from(context)
		inflater.inflate(rowLayoutId, parent, false) as View
	}

	def setColumnTextView(View row, int widgetId, String value) {
		val widget = row.findViewById(widgetId) as TextView
		widget.text = value
	}

}
