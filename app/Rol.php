<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\User;

class Rol extends Model
{
    protected $table = "rol";

    /*Una relación uno a muchos es utilizada cuando un modelo puede tener muchos otros modelos relacionados. 
     - un rol puede pertenecer a muchos usuarios */
    public function usuarios(){
	   return $this->hasMany(User::class);
	}

}
