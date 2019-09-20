<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Series;
use App\Tiempo;
use App\EntrenamientoEjercicio;

class Ejercicios extends Model
{
    protected $table = "ejercicios";

    public function series(){
	   return $this->hasMany(Series::class);
	}

	public function tiempo(){
	   return $this->hasMany(Tiempo::class);
	}

	public function entrenamiento_ejercicios(){
     return $this->hasMany(EntrenamientoEjercicio::class);
    }

}
