<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

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

class AuthenticateController extends Controller{

    public function __construct(){
      // Aplicar el middleware jwt.auth a todos los métodos de este controlador
      // excepto el método login.
      $this->middleware('jwt.auth', ['except' => ['login']]);

   }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

   public function register(Request $request)
   {

    /*return response()->json([
                      'error' => false,
                      'message' => 'Usuario creado exitosamente',
                      'data' => VistaUsuarioDetalle::all(),
                       201
             ]);*/

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
        $detalleFit->status = 1;
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

    public function login(Request $request)
    { 
        $validate = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required',
        ]);
 
 
        if ($validate->fails()) {
            return response()->json([
             'error' => 'validate',
             'errors' => $validate->errors(),
             'code' => 422
            ]);
        }
 
        $credentials = $request->only('email', 'password');
 
        try {
            // verifique las credenciales y cree un token para el usuario
              if (!$token = JWTAuth::attempt($credentials)) {
                  /*-- Nota:
                   * Error 401 - no autorizado: -> indica que se denegó el acceso a causa de las credenciales no válidas.*/
                  return response()->json([
                           'error' => true,
                           'message' => 'El email o la contraseña son incorrectos',
                            401
                  ]);
              }
        } catch (JWTException $e) {
            // something went wrong whilst attempting to encode the token
            return response()->json([
                           'error' => true,
                           'message' => 'No se pudo crear token, intentelo otravez.',
                            500
                  ]);
        }
 
       
 
        $user = DB::table('usuario')
             ->join('usuario_detalle', 'usuario.id', '=', 'usuario_detalle.usuario_id')
             ->select('usuario.id', 'email', 'usuario', 'status', 'rol_id', 'nombre', 'paterno', 'materno' , 'imagen')
             ->where('usuario.id', Auth::user()->id)
             ->first();
 
 
        return response()->json([ 'token' => $token, 'data' => $user ], 200);
    }
 
 
    public function logout(Request $request) {
 
         $validate = Validator::make($request->all(), [
            'token' => 'required',
         ]);
 
 
        if ($validate->fails()) {
            return response()->json([
             'error' => 'validate',
             'errors' => $validate->errors(),
             'code' => 422
            ]);
        }
 
 
         try {
             JWTAuth::invalidate($request->input('token'));
             return response()->json([
                            'error' => false,
                            'message' => 'Tu sesión ha sido serrada correctamente.',
                             200
                   ]);
         } catch (JWTException $e) {
             // something went wrong whilst attempting to encode the token
             return response()->json([
                            'error' => true,
                            'message' => 'Error al cerrar la sesión, intente de nuevo.',
                             500
                   ]);
         }
     }

    //recuperar contraseña
    public function recover(Request $request)
    {
        $user = User::where('email', $request->email)->first();
        if (!$user) {
            return response()->json([
                           'error' => true,
                           'message' => 'Tu dirección de correo electrónico no fue encontrada.',
                            401
                  ]);
        }
        try {
            Password::sendResetLink($request->only('email'), function (Message $message) {
                $message->subject('Su enlace de restablecimiento de contraseña');
            });
        } catch (\Exception $e) {
            //Return with error
            $error_message = $e->getMessage();
            return response()->json([
                           'error' => true,
                           'message' => $error_message,
                            401
                  ]);
        }
        return response()->json([
                           'error' => false,
                           'message' => '¡Se ha enviado un correo electrónico de reinicio! Por favor revise su correo electrónico.',
                            401
                  ]);
    }

}


