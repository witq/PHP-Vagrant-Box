class mysql {
    package { 'mysql-server':
            ensure  => present,
            require => Exec['apt-get update']
    }

    service { 'mysql':
            enable => true,
            ensure => running,
            require => Package['mysql-server'],
    }

    exec { 'set-mysql-password':
            onlyif => "mysqladmin -uroot -proot status",
            command => "mysqladmin -uroot -proot password root",
            require => Service["mysql"],
    }

    exec { 'create-default-db':
            unless => '/usr/bin/mysql -uroot -proot $app_database_name',
            command => '/usr/bin/mysql -uroot -proot -e "create database `$app_database_name`;"',
            require => [Service['mysql']]
    }

    exec { 'grant-default-db':
            command => '/usr/bin/mysql -uroot -proot -e "grant all on `$app_database_name`.* to `root@localhost`;"',
            require => [Service['mysql'], Exec['create-default-db']]
    }
}
