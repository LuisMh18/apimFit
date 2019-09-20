<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use App\Rol;
use App\Entrenamiento;
use App\ProductoComidaDiaADia;

class User extends Authenticatable
{
    use Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */

    protected $table = 'usuario';


   //atributos que pueden ser asignados de manera masiva, una asignasion masiva de manera masiva en laravel cuando se realiza
    //el establecimiento de tal atributo por medio del metodo create o update
    protected $fillable = [
        'rol_id',
        'usuario',
        'email',
        'password',
    ];


    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
     //atributos ocultos
    protected $hidden = [
        'password',
        'remember_token',
        'created_at',
        'updated_at',
    ];


    /*El método belongsTo nos permite trabajar con relaciones donde un registro pertenece a otro registro. Este método acepta como primer argumento el nombre de la clase que 
     *queremos vincular. Eloquent determina el nombre de la llave foránea a partir del nombre del método (en este caso profession) y agregando el sufijo _id a este:
     *Si en tu base de datos el nombre de la llave foránea no sigue esta convención puedes pasar el nombre de la columna como segundo argumento:
     *Ejemplo: return $this->belongsTo(Profession::class, 'id_profession');
    */

    public function rol(){
      return $this->belongsTo(Rol::class);
    }

    public function entrenamientos(){
     return $this->hasMany(Entrenamiento::class);
   }


   public function producto_comida_dia_a_dia(){
     return $this->hasMany(ProductoComidaDiaADia::class);
   }

}
