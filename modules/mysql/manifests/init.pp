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
            unless => "mysqladmin -uroot -proot status",
            command => "mysqladmin -uroot password root",
            require => Service["mysql"],
    }

    exec { 'create-default-db':
            unless => '/usr/bin/mysql -uroot -proot appbox',
            command => '/usr/bin/mysql -uroot -proot -e "create database appbox;"',
            require => [Service['mysql']]
    }

    exec { 'grant-default-db':
            command => '/usr/bin/mysql -uroot -proot -e "grant all on appbox.* to root@localhost;"',
            require => [Service['mysql'], Exec['create-default-db']]
    }
}
