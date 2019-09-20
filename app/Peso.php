<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Repeticiones;
use App\Equipo;

class Peso extends Model
{
    protected $table = "peso";

    public function repeticion(){
	   return $this->belongsTo(Repeticiones::class);
	}

	public function equipo(){
	   return $this->hasMany(Equipo::class);
	}

}
