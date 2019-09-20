<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\TipoProducto;
use App\ProductoComidaDiaADia;

class Productos extends Model
{
    protected $table = "productos";

    public function tipo_producto(){
	   return $this->belongsTo(TipoProducto::class);
	}

	public function producto_comida_dia_a_dia(){
     return $this->hasMany(ProductoComidaDiaADia::class);
   }
   
}
