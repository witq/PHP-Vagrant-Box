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

    exec { 'create-default-db':
            unless => '/usr/bin/mysql -uroot -proot database',
            command => '/usr/bin/mysql -uroot -proot -e "create database `database`;"',
            require => [Service['mysql']]
    }

    exec { 'grant-default-db':
            command => '/usr/bin/mysql -uroot -p$mysqlPassword -e "grant all on `database`.* to `root@localhost`;"',
            require => [Service['mysql'], Exec['create-default-db']]
    }
}
