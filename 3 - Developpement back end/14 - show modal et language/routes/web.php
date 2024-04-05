<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\ProductController;

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
    return view('welcome');
});

Route::resource('products', ProductController::class);

Route::get('/test',[ProductController::class,'test'])->name('test');

Route::post('/products/search',[ProductController::class,'search'])->name('products.search');

Route::post('/products/delete',[ProductController::class,'delete'])->name('products.delete');

Route::post('/products/showModal',[ProductController::class,'showModal'])->name('products.showModal');
//Route::get('/changeLocale/{locale}',[ProductController::class,'changeLocale'])->name('products.changeLocale');
Route::get('/changeLocale/{locale}',function($locale){
    session()->put('locale',$locale);
    return redirect()->back();
})->name('products.changeLocale');