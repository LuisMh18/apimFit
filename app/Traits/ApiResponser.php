<?php
namespace App\Traits;

use Illuminate\Support\Collection;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Validator;
use Illuminate\Pagination\LengthAwarePaginator;

trait ApiResponser{
  //metodo para los mensajes success
  public function successResponse($data, $code){
      return response()->json(['data' => $data], $code);
  }

  protected function showAll($data, $code = 200)
  {

    $data = $this->paginate($data);//paginación

    return $this->successResponse($data, $code);

  }


   //metodo para los mensajes de error
  public function errorResponse($message, $code){
        return response()->json(['error' => $message, 'code' => $code], $code);
  }


    //metodo para la paginación 
    protected function paginate($data)
    {
  
      /*Reglas para permitirle al usuario definir el numero de la paginación, como minimo seran 2 y como maximo 50 */
      $rules = [
        'per_page' => 'integer|min:2|max:200'
      ];
  
      Validator::validate(request()->all(), $rules);//validamos
      $r = request()->all();
    /*  $validate = Validator::make($r, [
        'per_page' => 'integer|min:2|max:200'
      ]);


    if ($validate->fails()) {
        return response()->json([
         'error' => 'validate',
         'errors' => $validate->errors(),
         'code' => 422
        ]);
    }*/
  
      $page = LengthAwarePaginator::resolveCurrentPage();
  
      $perPage = 10; //valor predifinido a la cantidad de elementos por pagina
      //si rcibimos el parametro per_page sustituimos el valor de la cantidad de elementos de pagina por defecto por el recibido
      if (request()->has('per_page')) {
        $perPage = (int) request()->per_page;
      }
  
      $results = $data->slice(($page - 1) * $perPage, $perPage)->values();
  
      $paginated = new LengthAwarePaginator($results, $data->count(), $perPage, $page, [
        'path' => LengthAwarePaginator::resolveCurrentPath(),
      ]);
  
      $paginated->appends(request()->all());
  
      return $paginated;
    }



   /* public function miMetodo()
    {

      if(Auth::user()->rol_id !== 3){
            return response()->json([
                'error' => true,
                'message' => 'No tienes permisos de administrador',
                 401
       ]);
        } 

        return $this->prueba();
      
    }*/



}


 ?>
