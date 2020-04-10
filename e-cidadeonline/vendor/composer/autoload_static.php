<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInitad73ee646bd5cb10dc071463a04d7890
{
    public static $files = array (
        '0e6d7bf4a5811bfa5cf40c5ccd6fae6a' => __DIR__ . '/..' . '/symfony/polyfill-mbstring/bootstrap.php',
        'e40631d46120a9c38ea139981f8dab26' => __DIR__ . '/..' . '/ircmaxell/password-compat/lib/password.php',
        '5255c38a0faeba867671b61dfda6d864' => __DIR__ . '/..' . '/paragonie/random_compat/lib/random.php',
        '667aeda72477189d0494fecd327c3641' => __DIR__ . '/..' . '/symfony/var-dumper/Resources/functions/dump.php',
        'ef0d9c01ea9e4e9b9ae11dae60912ecd' => __DIR__ . '/..' . '/dbseller/legacy/bootstrap/PHP_53.php',
        '837eea227d8264a0b760039cb3e07c9e' => __DIR__ . '/..' . '/dbseller/legacy/bootstrap/PHP_54.php',
        'ece51acf19807b491c5f9ac28976156d' => __DIR__ . '/..' . '/dbseller/legacy/bootstrap/PHP_55.php',
        '56feb1ad7b6206856d39a5a294b041d6' => __DIR__ . '/..' . '/dbseller/legacy/bootstrap/PHP_56.php',
        '3e2471375464aac821502deb0ac64275' => __DIR__ . '/..' . '/symfony/polyfill-php54/bootstrap.php',
        'edc6464955a37aa4d5fbf39d40fb6ee7' => __DIR__ . '/..' . '/symfony/polyfill-php55/bootstrap.php',
        'bd9634f2d41831496de0d3dfe4c94881' => __DIR__ . '/..' . '/symfony/polyfill-php56/bootstrap.php',
        '023d27dca8066ef29e6739335ea73bad' => __DIR__ . '/..' . '/symfony/polyfill-php70/bootstrap.php',
        '1f60d56c465c7131982bcd3aa7140afc' => __DIR__ . '/..' . '/rafaelnery/phputils/src/functions/debug.php',
    );

    public static $prefixLengthsPsr4 = array (
        'S' => 
        array (
            'Symfony\\Polyfill\\Util\\' => 22,
            'Symfony\\Polyfill\\Php70\\' => 23,
            'Symfony\\Polyfill\\Php56\\' => 23,
            'Symfony\\Polyfill\\Php55\\' => 23,
            'Symfony\\Polyfill\\Php54\\' => 23,
            'Symfony\\Polyfill\\Mbstring\\' => 26,
            'Symfony\\Component\\VarDumper\\' => 28,
        ),
        'P' => 
        array (
            'PHP\\' => 4,
        ),
        'M' => 
        array (
            'Monolog\\' => 8,
        ),
        'E' => 
        array (
            'ECidade\\' => 8,
        ),
        'D' => 
        array (
            'DBSeller\\Legacy\\Tests\\' => 22,
            'DBSeller\\Legacy\\' => 16,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Symfony\\Polyfill\\Util\\' => 
        array (
            0 => __DIR__ . '/..' . '/symfony/polyfill-util',
        ),
        'Symfony\\Polyfill\\Php70\\' => 
        array (
            0 => __DIR__ . '/..' . '/symfony/polyfill-php70',
        ),
        'Symfony\\Polyfill\\Php56\\' => 
        array (
            0 => __DIR__ . '/..' . '/symfony/polyfill-php56',
        ),
        'Symfony\\Polyfill\\Php55\\' => 
        array (
            0 => __DIR__ . '/..' . '/symfony/polyfill-php55',
        ),
        'Symfony\\Polyfill\\Php54\\' => 
        array (
            0 => __DIR__ . '/..' . '/symfony/polyfill-php54',
        ),
        'Symfony\\Polyfill\\Mbstring\\' => 
        array (
            0 => __DIR__ . '/..' . '/symfony/polyfill-mbstring',
        ),
        'Symfony\\Component\\VarDumper\\' => 
        array (
            0 => __DIR__ . '/..' . '/symfony/var-dumper',
        ),
        'PHP\\' => 
        array (
            0 => __DIR__ . '/..' . '/rafaelnery/phputils/src',
        ),
        'Monolog\\' => 
        array (
            0 => __DIR__ . '/..' . '/monolog/monolog/src/Monolog',
        ),
        'ECidade\\' => 
        array (
            0 => __DIR__ . '/../..' . '/src',
        ),
        'DBSeller\\Legacy\\Tests\\' => 
        array (
            0 => __DIR__ . '/..' . '/dbseller/legacy/tests',
        ),
        'DBSeller\\Legacy\\' => 
        array (
            0 => __DIR__ . '/..' . '/dbseller/legacy/src',
        ),
    );

    public static $prefixesPsr0 = array (
        'P' => 
        array (
            'Psr\\Log\\' => 
            array (
                0 => __DIR__ . '/..' . '/psr/log',
            ),
        ),
    );

    public static $classMap = array (
        'ArithmeticError' => __DIR__ . '/..' . '/symfony/polyfill-php70/Resources/stubs/ArithmeticError.php',
        'AssertionError' => __DIR__ . '/..' . '/symfony/polyfill-php70/Resources/stubs/AssertionError.php',
        'CallbackFilterIterator' => __DIR__ . '/..' . '/symfony/polyfill-php54/Resources/stubs/CallbackFilterIterator.php',
        'DivisionByZeroError' => __DIR__ . '/..' . '/symfony/polyfill-php70/Resources/stubs/DivisionByZeroError.php',
        'Error' => __DIR__ . '/..' . '/symfony/polyfill-php70/Resources/stubs/Error.php',
        'ParseError' => __DIR__ . '/..' . '/symfony/polyfill-php70/Resources/stubs/ParseError.php',
        'RecursiveCallbackFilterIterator' => __DIR__ . '/..' . '/symfony/polyfill-php54/Resources/stubs/RecursiveCallbackFilterIterator.php',
        'SessionHandlerInterface' => __DIR__ . '/..' . '/symfony/polyfill-php54/Resources/stubs/SessionHandlerInterface.php',
        'SqlFormatter' => __DIR__ . '/..' . '/jdorn/sql-formatter/lib/SqlFormatter.php',
        'TypeError' => __DIR__ . '/..' . '/symfony/polyfill-php70/Resources/stubs/TypeError.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInitad73ee646bd5cb10dc071463a04d7890::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInitad73ee646bd5cb10dc071463a04d7890::$prefixDirsPsr4;
            $loader->prefixesPsr0 = ComposerStaticInitad73ee646bd5cb10dc071463a04d7890::$prefixesPsr0;
            $loader->classMap = ComposerStaticInitad73ee646bd5cb10dc071463a04d7890::$classMap;

        }, null, ClassLoader::class);
    }
}
