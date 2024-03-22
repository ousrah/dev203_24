<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Models\User;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    $user = User::find(1);
    return view('welcome',['pic'=>$user->avatar]);
})->name("welcome");

Route::post("/saveCookie", [HomeController::class, 'saveCookie'])->name("saveCookie");
Route::post("/saveSession", [HomeController::class, 'saveSession'])->name("saveSession");
Route::post("/saveAvatar", [HomeController::class, 'saveAvatar'])->name("saveAvatar");
