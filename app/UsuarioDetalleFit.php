<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\User;
use App\Objetivos;

class UsuarioDetalleFit extends Model
{
    protected $table = "usuario_detalle_fit";

    public function usuario(){
	   return $this->belongsTo(User::class);
	}

	public function objetivo(){
	   return $this->belongsTo(Objetivos::class);
	}
}
