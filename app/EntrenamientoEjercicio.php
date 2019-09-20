<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Entrenamiento;
use App\Ejercicios;

class EntrenamientoEjercicio extends Model
{
    protected $table = "entrenamiento_ejercicio";

    public function entrenamiento(){
	   return $this->belongsTo(Entrenamiento::class);
	}

	public function ejercicio(){
	   return $this->belongsTo(Ejercicios::class);
	}

}
