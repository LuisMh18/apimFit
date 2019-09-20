<?php

namespace App\Http\Controllers\Catalogos;

use App\Rol;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;


use JWTAuth;
use Tymon\JWTAuthExceptions\JWTException;

use Auth;
use Validator;
use DB;
use App\Traits\ApiResponser;

class RolController extends Controller
{
    use ApiResponser;

    public function __construct(){
      $this->middleware('jwt.auth');
   }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {

        $data = DB::table('rol');

        $orden = ($request->order != '') ? $request->order : 'desc';
        $search = $request->search;

        if($request->has('search')){
            $data->where(function ($query) use ($search) {
                $query->where('nombre', 'like', '%'.$search.'%')
                      ->orWhere('created_at',  'like', '%'.$search.'%');
            });
        }


        $data = $data->orderBy('id', $orden)
        ->select('id', 'nombre', 'created_at')
        ->get();


        return $this->showAll($data);
    }


    public function data()
    {

        $data = DB::table('rol')
                    ->select('id', 'nombre', 'created_at')
                    ->orderBy('id', 'desc')
                    ->get();

        return response()->json([
            'error' => false,
            'data' => $data,
             201
       ]);

    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validate = Validator::make($request->all(), [
            'nombre' => 'required|min:3',
          ]);


        if ($validate->fails()) {
            return response()->json([
             'error' => 'validate',
             'errors' => $validate->errors(),
             'code' => 422
            ]);
        }

        $r = new Rol;
        $r->nombre = $request->nombre;
        $r->save();


        try {

             return response()->json([
                    'error' => false,
                    'message' => "Rol $r->nombre creado exitosamente!",
                    'data' => $r,
                     201
               ]);


         } catch (JWTException $e) {
             return response()->json([
                      'error' => true,
                      'message' => 'Error al crear el registro, intente de nuevo.',
                       'data' => "",
                       500
             ]);
         }



    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Rol  $rol
     * @return \Illuminate\Http\Response
     */
    public function show(Rol $rol)
    {
        return response()->json(['data' => $rol], 201);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Rol  $rol
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Rol $rol)
    {

          if($request->has('nombre')){
            $rol->nombre = $request->nombre;
          }

           //el metodo isDirty valida si algunos e los valores originales ah cambiado su valor
           if(!$rol->isDirty()){
             return response()->json([
                'error' => true,
                'message' => 'Se debe de especificar un valor diferente para actualizar',
                 422
            ]);
           }

           $rol->save();

           return response()->json([
            'error' => false,
            'message' => "Rol $rol->nombre actualizado exitosamente!",
            'data' => $rol,
             201
          ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Rol  $rol
     * @return \Illuminate\Http\Response
     */
    public function destroy(Rol $rol)
    {
        $rol->delete();
        return response()->json([
            'error' => false,
            'message' => "Rol $rol->nombre eliminado exitosamente!",
            'data' => $rol,
             201
          ]);
    }
}
