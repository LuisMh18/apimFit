<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\DescripcionDia;
use App\MesDia;
use App\Entrenamiento;
use App\ProductoComidaDiaADia;

class Dias extends Model
{
    protected $table = "dias";

    public function descripcion_dias(){
	   return $this->hasMany(DescripcionDia::class);
	}

	public function mes_dia(){
	   return $this->hasMany(MesDia::class);
	}

	public function entrenamientos(){
     return $this->hasMany(Entrenamiento::class);
   }

   public function producto_comida_dia_a_dia(){
     return $this->hasMany(ProductoComidaDiaADia::class);
   }

}
