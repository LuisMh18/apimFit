<?php

namespace App\Http\Controllers\Catalogos;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use AppHttpRequests;
use AppHttpControllersController;
use JWTAuth;
use Tymon\JWTAuthExceptions\JWTException;
use App\User;
use App\UsuarioDetalle;
use App\UsuarioDetalleFit;
use App\VistaUsuarioDetalle;
use Auth;
use Validator;
use DB;
use Hash;
use App\Traits\ApiResponser;

class UsuariosController extends Controller
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

        $data = DB::table('usuario')
                ->leftJoin('usuario_detalle',  'usuario.id', '=', 'usuario_detalle.usuario_id')
                ->join('rol',  'usuario.rol_id', '=', 'rol.id');

        $orden = ($request->order != '') ? $request->order : 'desc';
       // $campo = ($request->campo != '0') ? 'almacen.'.$request->campo : 'almacen.id';
        $search = $request->search;

        if($request->has('search')){
            $data->where(function ($query) use ($search) {
                $query->where('usuario_detalle.nombre', 'like', '%'.$search.'%')
                      ->orWhere('usuario_detalle.paterno',  'like', '%'.$search.'%')
                      ->orWhere('usuario_detalle.materno',  'like', '%'.$search.'%')
                      ->orWhere('usuario',  'like', '%'.$search.'%')
                      ->orWhere('email',  'like', '%'.$search.'%')
                      ->orWhere('usuario.created_at',  'like', '%'.$search.'%');
            });
        }

        if($request->status != ""){
            $data->where('status',  $request->status);
        }

        if($request->rol != 0){
            $data->where('usuario.rol_id',  $request->rol);
        }

        $data->select('usuario.id', DB::raw('CONCAT(usuario_detalle.nombre," ",usuario_detalle.paterno," ",usuario_detalle.materno) as nombre_completo'), 'usuario', 
          'email', 'imagen', 'status', 'rol.nombre as rol', 'usuario.created_at');

        $data = $data->orderBy('usuario.id', $orden)
        ->get();

        return $this->showAll($data);
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
                //reglas de validacion
        $validate = Validator::make($request->all(), [
          'rol_id' => 'required',
          'usuario' => 'required|unique:usuario|min:5|max:20',
          'email' => 'required|email|unique:usuario',//el email debe de ser unico en la tabla usuarios
          'password' => 'required|min:6|confirmed',
          'nombre' => 'required|min:3|max:30',
          'paterno' => 'required|min:3',
        ]);


        if ($validate->fails()) {
            return response()->json([
             'error' => 'validate',
             'errors' => $validate->errors(),
             'field' => $validate->errors()->keys(),
             'code' => 422
            ]);
        }

        /* Rol de usuarios
         * 1 - Administrador
         * 2 - Usuario
        */

        $user = new User;
        $user->rol_id = $request->rol_id;
        $user->usuario = $request->usuario;
        $user->password = bcrypt($request->password);
        $user->email = $request->email;
        $user->remember_token = "";
        $user->status = $request->status;
        $user->save();

        //insertamos en la tabla detalle
        $detalle = new UsuarioDetalle;
        $detalle->usuario_id = $user->id;
        $detalle->nombre = $request->nombre;
        $detalle->paterno = $request->paterno;
        $detalle->materno = $request->materno;
        $detalle->imagen = $request->imagen;
        $detalle->save();

        //insertamos en la tabla usuario_detalle_fit
        $detalleFit = new UsuarioDetalleFit;
        $detalleFit->usuario_id = $user->id;
        $detalleFit->estatura = $request->estatura;
        $detalleFit->peso_libras = $request->peso_libras;
        $detalleFit->peso_kilos = $request->peso_kilos;
        $detalleFit->foto_actual = $request->foto_actual;
        $detalleFit->descripcion = $request->descripcion;
        $detalleFit->objetivo_id = $request->objetivo_id;
        $detalleFit->requerimineto_proteinas = $request->requerimineto_proteinas;
        $detalleFit->requerimineto_calorias = $request->requerimineto_calorias;
        $detalleFit->fecha = $request->fecha;
        $detalleFit->status = $request->statusFit;
        $detalleFit->save();


        try {

             return response()->json([
                      'error' => false,
                      'message' => 'Usuario creado exitosamente',
                      'data' => $user,
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
     * @param  \App\User  $user
     * @return \Illuminate\Http\Response
     */
    public function show($request)
    {

        //usuarios
        $data["usuario"] = DB::table('usuario')
                ->leftJoin('usuario_detalle',  'usuario.id', '=', 'usuario_detalle.usuario_id')
                ->leftJoin('usuario_detalle_fit',  'usuario.id', '=', 'usuario_detalle_fit.usuario_id')
                ->join('rol',  'usuario.rol_id', '=', 'rol.id')
                ->where('usuario.id',  $request)
                ->select('usuario.id', 'rol_id', 'usuario', 'email', 'usuario.status as statusUser', 'usuario.created_at', DB::raw('CONCAT(usuario_detalle.nombre," ",usuario_detalle.paterno," ",usuario_detalle.materno) as nombre_completo'), 'imagen',  'rol.nombre as rol', 'estatura', 'peso_libras', 'peso_kilos', 'foto_actual', 'descripcion', 'objetivo_id', 'requerimineto_proteinas', 'requerimineto_calorias', 'fecha', 'usuario_detalle_fit.status as statusFit')
                ->first();

        //rol
        $data["rol"] = DB::table('rol')
                ->select('id', 'nombre')
                ->orderBy('nombre', 'asc')
                ->get();

        //objetivos
        $data["objetivos"] = DB::table('objetivos')
                ->select('id', 'descripcion')
                ->orderBy('descripcion', 'asc')
                ->where("status", 1)
                ->get();

        return response()->json(['data' => $data], 201);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\User  $user
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $user = User::find($id);

        $validate = Validator::make($request->all(), [
          'rol_id' => 'required',
          //validamos que el usuario pueda ser el mismo del usuario actual, es decir el usuario debe de ser unico pero puede quedar con el mismo valor si es q no es modificado
          'usuario' => 'unique:usuario,usuario,' . $user->id,
          //la misma validación para el email
          'email' => 'email|unique:usuario,email,' . $user->id,
          'nombre' => 'required|min:3|max:30',
          'paterno' => 'required|min:3',
        ]);


        if ($validate->fails()) {
            return response()->json([
             'error' => 'validate',
             'errors' => $validate->errors(),
             'field' => $validate->errors()->keys(),
             'code' => 422
            ]);
        }

          $user = User::find($id);
          $detalle = DB::table("usuario_detalle")
                    ->where('usuario_id', $id)
                    ->first();

           $detallef = DB::table("usuario_detalle_fit")
                    ->where('usuario_id', $id)
                    ->first();


           $user->save();

           //actualizamos en la tabla detalle
            $detalle = UsuarioDetalle::find($detalle->id);
            $detalle->nombre = $request->nombre;
            $detalle->paterno = $request->paterno;
            $detalle->materno = $request->materno;
            $detalle->imagen = $request->imagen;
            $detalle->save();

            //actualizamos en la tabla usuario_detalle_fit
            $detalleFit = UsuarioDetalleFit::find($detallef->id);
            $detalleFit->estatura = $request->estatura;
            $detalleFit->peso_libras = $request->peso_libras;
            $detalleFit->peso_kilos = $request->peso_kilos;
            $detalleFit->foto_actual = $request->foto_actual;
            $detalleFit->descripcion = $request->descripcion;
            $detalleFit->objetivo_id = $request->objetivo_id;
            $detalleFit->requerimineto_proteinas = $request->requerimineto_proteinas;
            $detalleFit->requerimineto_calorias = $request->requerimineto_calorias;
            $detalleFit->fecha = $request->fecha;
            $detalleFit->status = $request->statusFit;
            $detalleFit->save();

           return response()->json([
            'error' => false,
            'message' => "Usuario $user->usuario actualizado exitosamente!",
            'data' => $user,
             201
          ]);
    }


    public function updatePassword(Request $request, $id){

        $user = User::find($id);

        $validate = Validator::make($request->all(), [
          'new_password' => 'min:6|confirmed',
          'password' => 'required|min:6'
        ]);


        if ($validate->fails()) {
            return response()->json([
             'error' => 'validate',
             'errors' => $validate->errors(),
             'field' => $validate->errors()->keys(),
             'code' => 422
            ]);
        }


        if($request->has('new_password')){
             //en caso de que si comparamos que la contrasea enviada sea la misma a la de la bd
            if (Hash::check($request->password, $user->password)) {

                   $user->password = bcrypt($request->new_password);

                } else {

                    return response()->json([
                        'error' => true,
                        'message' => 'Tu contraseña actual no coincide',
                         422
                    ]);

                }

          }

          $user->save();
          return response()->json([
            'error' => false,
            'message' => "Contraseña actualizada exitosamente!",
            'data' => $user,
             201
          ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\User  $user
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $user = User::find($id);
        $user->delete();
        return response()->json([
            'error' => false,
            'message' => "Usuario $user->usuario eliminado exitosamente!",
            'data' => $user,
             201
          ]);
    }
}
