<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//Authenticate
Route::post('register', 'AuthenticateController@register');
Route::post('login', 'AuthenticateController@login');
Route::get('logout', 'AuthenticateController@logout');
Route::post('recover', 'AuthenticateController@recover');



//rutas unicamente para administradores
Route::group(['middleware' => ['admin']], function(){
	
	//catalogos padre------ 
    //Rol
	Route::get('rol/data', 'Catalogos\RolController@data');//todos los resultados
	Route::resource('rol', 'Catalogos\RolController', ['except' => ['create', 'edit']]);
	Route::post('rol/index', 'Catalogos\RolController@index');
	//Objetivos
	Route::get('objetivos/data', 'Catalogos\ObjetivosController@data');//todos los resultados
	Route::resource('objetivos', 'Catalogos\ObjetivosController', ['except' => ['create', 'edit']]);
	Route::post('objetivos/index', 'Catalogos\ObjetivosController@index');
	//Usuario
	Route::put('usuarios/updatePassword/{id}', 'Catalogos\UsuariosController@updatePassword');
	Route::get('usuarios/data', 'Catalogos\UsuariosController@data');//todos los resultados
	Route::resource('usuarios', 'Catalogos\UsuariosController', ['except' => ['create', 'edit']]);
	Route::post('usuarios/index', 'Catalogos\UsuariosController@index');

});