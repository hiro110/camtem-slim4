<?php


require_once( __DIR__ . '/../../vendor/autoload.php');

use Illuminate\Database\Capsule\Manager as Capsule;
use App\Models\User;

$capsule = new Capsule;

$capsule->addConnection([
    'driver'    => 'mysql',
    'host'      => 'localhost',
    'database'  => 'app3',
    'username'  => 'app3',
    'password'  => 'kQpGeMS,aRD5',
    'charset'   => 'utf8',
    'collation' => 'utf8_unicode_ci',
    'prefix'    => '',
]);

$capsule->setAsGlobal();
$capsule->bootEloquent();

$user = User::where('username', 'test')
            ->where('is_active', 1)
            ->first();

echo $user;
