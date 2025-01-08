<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;

Route::get('/', [HomeController::class, 'index']);
Route::get('/login', function () {
    return view('auth.login');
});
Route::get('/dashboard', function () {
    return view('auth.dashboard');
});
