<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Dias;

class DescripcionDia extends Model
{
    protected $table = "descripcion_dia";

    public function dia(){
	   return $this->belongsTo(Dias::class);
	}
}
