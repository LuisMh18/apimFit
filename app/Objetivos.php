<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\User;

class Objetivos extends Model
{
    protected $table = "objetivos";

    public function usuarios(){
	   return $this->hasMany(User::class);
	}

}
