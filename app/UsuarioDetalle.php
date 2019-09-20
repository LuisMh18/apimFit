<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\User;

class UsuarioDetalle extends Model
{
     protected $table = "usuario_detalle";

     //desactivamos los campos created_at y updated_at para que no de error al insertar
     public $timestamps = false;

     /*El método belongsTo nos permite trabajar con relaciones donde un registro pertenece a otro registro. Este método acepta como primer argumento el nombre de la clase que 
     *queremos vincular. Eloquent determina el nombre de la llave foránea a partir del nombre del método (en este caso profession) y agregando el sufijo _id a este:
     *Si en tu base de datos el nombre de la llave foránea no sigue esta convención puedes pasar el nombre de la columna como segundo argumento:
     *Ejemplo: return $this->belongsTo(Profession::class, 'id_profession');
    */
	  public function usuario(){
	    return $this->belongsTo(User::class);
	  }
}
