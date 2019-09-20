<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Entrenamiento;

class Anio extends Model
{
    protected $table = "anio";

    public function entrenamientos(){
     return $this->hasMany(Entrenamiento::class);
   }

}
