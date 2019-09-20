<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Productos;
use App\Dias;
use App\ComidasDia;
use App\User;

class ProductoComidaDiaADia extends Model
{
    protected $table = "producto_comida_dia_a_dia";

    public function producto(){
	   return $this->belongsTo(Productos::class);
	}

	public function dia(){
	   return $this->belongsTo(Dias::class);
	}

	public function comidas_dia(){
	   return $this->belongsTo(ComidasDia::class);
	}

	public function usuario(){
	   return $this->belongsTo(User::class);
	}

}
