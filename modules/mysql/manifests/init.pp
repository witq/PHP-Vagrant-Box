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
            onlyif => "mysqladmin -uroot -p status",
            command => "mysqladmin -uroot -proot password ",
            require => Service["mysql"],
    }

    exec { 'create-default-db':
            unless => '/usr/bin/mysql -uroot -p appbox',
            command => '/usr/bin/mysql -uroot -p -e "create database appbox;"',
            require => [Service['mysql']]
    }

    exec { 'grant-default-db':
            command => '/usr/bin/mysql -uroot -p -e "grant all on appbox.* to root@localhost;"',
            require => [Service['mysql'], Exec['create-default-db']]
    }
}
