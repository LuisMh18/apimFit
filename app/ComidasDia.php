<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\ProductoComidaDiaADia;

class ComidasDia extends Model
{
    protected $table = "comidas_dia";

    public function producto_comida_dia_a_dia(){
     return $this->hasMany(ProductoComidaDiaADia::class);
   }

}
