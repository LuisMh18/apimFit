<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Ejercicios;
use App\Repeticiones;

class Series extends Model
{
    protected $table = "series";

    public function ejercicio(){
	   return $this->belongsTo(Ejercicios::class);
	}

	public function repeticiones(){
	   return $this->hasMany(Repeticiones::class);
	}

}
