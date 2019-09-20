<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Meses;
use App\Dias;

class MesDia extends Model
{
    protected $table = "mes_dia";

    public function mes(){
	   return $this->belongsTo(Meses::class);
	}

	public function dia(){
	   return $this->belongsTo(Dias::class);
	}

}
