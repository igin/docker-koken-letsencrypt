<?php
        return array(
                'hostname' => $_ENV['KOKEN_DB_HOST'],
                'database' => $_ENV['KOKEN_DB_DATABASE'],
                'username' => $_ENV['KOKEN_DB_USER'],
                'password' => $_ENV['KOKEN_DB_PASSWORD'],
                'prefix' => 'koken_',
                'socket' => ''
        );
