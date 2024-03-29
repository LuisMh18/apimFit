<?php

namespace App\Http\Middleware;

use Closure;

use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Symfony\Component\HttpKernel\Exception\UnauthorizedHttpException;

class Administrador
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
public function handle($request, Closure $next)
    {

        try{
            $user = JWTAuth::toUser($request->input('token'));
            if($user->rol_id !== 1){
              return response()->json([
                    'error' => true,
                    'message' => 'No tienes permisos de administrador',
                     401
              ]);
            }
        }catch (JWTException $e) {
            if($e instanceof \Tymon\JWTAuth\Exceptions\TokenExpiredException) {
                return response()->json(['token_expired'], $e->getStatusCode());
            }else if ($e instanceof \Tymon\JWTAuth\Exceptions\TokenInvalidException) {
                return response()->json(['token_invalid'], $e->getStatusCode());
            }else{
                return response()->json(['error'=>'Token is required']);
            }
        }        

        return $next($request);
    }




}
