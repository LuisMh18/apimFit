<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Productos;

class TipoProducto extends Model
{
    protected $table = "tipo_producto";

    public function productos(){
	   return $this->hasMany(Productos::class);
	}

}
