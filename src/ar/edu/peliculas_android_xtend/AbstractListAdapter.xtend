package ar.edu.peliculas_android_xtend

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

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
	def generateRow(int rowId, ViewGroup parent) {
		val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
		inflater.inflate(rowId, parent, false) as View
	}

	def generateColumnTextView(View row, int widgetId, String value) {
		val widget = row.findViewById(widgetId) as TextView
		widget.text = value
	}

}
