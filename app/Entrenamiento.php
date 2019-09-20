<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Anio;
use App\Meses;
use App\Dias;
use App\User;
use App\EntrenamientoEjercicio;

class Entrenamiento extends Model
{
    protected $table = "entrenamiento";

    public function anio(){
	   return $this->belongsTo(Anio::class);
	}

	public function mes(){
	   return $this->belongsTo(Meses::class);
	}

	public function dia(){
	   return $this->belongsTo(Dias::class);
	}

	public function usuario(){
	   return $this->belongsTo(User::class);
	}

	public function entrenamiento_ejercicios(){
     return $this->hasMany(EntrenamientoEjercicio::class);
    }

}
