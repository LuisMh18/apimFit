<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Ejercicios;

class Tiempo extends Model
{
    protected $table = "tiempo";

    public function ejercicio(){
	   return $this->belongsTo(Ejercicios::class);
	}

}
