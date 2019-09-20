<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Series;
use App\Peso;

class Repeticiones extends Model
{
    protected $table = "repeticiones";

    public function serie(){
	   return $this->belongsTo(Series::class);
	}

	public function peso(){
	   return $this->hasMany(Peso::class);
	}

}
