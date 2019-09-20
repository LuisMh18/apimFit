<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Peso;

class Equipo extends Model
{
    protected $table = "equipo";

    public function peso(){
	   return $this->belongsTo(Peso::class);
	}

}
