<?php

namespace App\Http\Controllers\Catalogos;

use App\Objetivos;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;


use JWTAuth;
use Tymon\JWTAuthExceptions\JWTException;

use Auth;
use Validator;
use DB;
use App\Traits\ApiResponser;

class ObjetivosController extends Controller
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

        $data = DB::table('objetivos');

        $orden = ($request->order != '') ? $request->order : 'desc';
        $search = $request->search;

        if($request->has('search')){
            $data->where(function ($query) use ($search) {
                $query->where('descripcion', 'like', '%'.$search.'%')
                      ->orWhere('notas',  'like', '%'.$search.'%')
                      ->orWhere('created_at',  'like', '%'.$search.'%');
            });
        }


        if($request->status != ""){
            $data->where('status',  $request->status);
        } 

        $data = $data->orderBy('id', $orden)
        ->select('id', 'descripcion', 'notas', 'status', 'created_at')
        ->get();


        return $this->showAll($data);
    }


    public function data()
    {

        $data = DB::table('objetivos')
                    ->select('id', 'descripcion', 'notas', 'status', 'created_at')
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
            'descripcion' => 'required|min:3',
          ]);


        if ($validate->fails()) {
            return response()->json([
             'error' => 'validate',
             'errors' => $validate->errors(),
             'field' => $validate->errors()->keys(),
             'code' => 422
            ]);
        }

        $r = new Objetivos;
        $r->descripcion = $request->descripcion;
        $r->notas = $request->notas;
        $r->status = $request->status;
        $r->save();


        try {

             return response()->json([
                    'error' => false,
                    'message' => "Objetivo $r->descripcion creado exitosamente!",
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
    public function show($request)
    {
        return response()->json(['data' => Objetivos::find($request)], 201);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Rol  $rol
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {

        $validate = Validator::make($request->all(), [
            'descripcion' => 'required|min:3',
          ]);


        if ($validate->fails()) {
            return response()->json([
             'error' => 'validate',
             'errors' => $validate->errors(),
             'field' => $validate->errors()->keys(),
             'code' => 422
            ]);
        }

         $objetivos = Objetivos::find($id);

          if($request->has('descripcion')){
            $objetivos->descripcion = $request->descripcion;
          }

          if($request->has('notas')){
            $objetivos->notas = $request->notas;
          }

          if($request->has('status')){
            $objetivos->status = $request->status;
          }

           //el metodo isDirty valida si algunos e los valores originales ah cambiado su valor
           if(!$objetivos->isDirty()){
             return response()->json([
                'error' => true,
                'message' => 'Se debe de especificar un valor diferente para actualizar',
                 422
            ]);
           }

           $objetivos->save();

           return response()->json([
            'error' => false,
            'message' => "Objetivo $objetivos->nombre actualizado exitosamente!",
            'data' => $objetivos,
             201
          ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Rol  $rol
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $objetivos = Objetivos::find($id);
        $objetivos->delete();
        return response()->json([
            'error' => false,
            'message' => "Objetivo $objetivos->nombre eliminado exitosamente!",
            'data' => $objetivos,
             201
          ]);
    }
}
