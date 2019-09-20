<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\MesDia;
use App\Entrenamiento;

class Meses extends Model
{
    protected $table = "meses";

    public function mes_dia(){
	   return $this->hasMany(MesDia::class);
	}

	public function entrenamientos(){
     return $this->hasMany(Entrenamiento::class);
   }

}
