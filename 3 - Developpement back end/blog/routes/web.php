<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PostController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|/*
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('hello', function () {
  return ('hello');
});

Route::get('/posts',[PostController::class,"index"])->name('posts.index');

Route::get('/posts/create',[PostController::class,"create"])->name('posts.create');

Route::post('/posts/store',[PostController::class,"store"])->name('posts.store');

Route::get('/posts/show',[PostController::class,"show"])->name('posts.show');

Route::match(['put', 'patch'], '/posts/storeUpdate', [PostController::class,"storeUpdate"])->name('posts.update');


/*Route::resource('/posts/create', PostController::class,"index")->name('posts.create');
Route::resource('/posts/store', PostController::class,"store")->name('posts.store');
Route::resource('/posts/show', PostController::class,"show")->name('posts.show');



Route::resource('/', PostController::class)->names([
//  'index' => 'posts.index',
  'create' => 'posts.create',
  'store' => 'posts.store',
  'show' => 'posts.show',
]);
*/