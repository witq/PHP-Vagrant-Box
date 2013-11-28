class symfony_app
{
   	exec { 'install composer':
	    command => 'curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin',
	    require => Package['php5-cli'],
	    unless => "[ -f /usr/local/bin/composer ]"
	}

	exec { 'global composer':
		command => "sudo mv /usr/local/bin/composer.phar /usr/local/bin/composer",
		require => Exec['install composer'],
		unless => "[ -f /usr/local/bin/composer ]"
	}

	exec { 'update packages':
        command => "/bin/sh -c 'cd /var/www/ && composer --verbose update'",
        require => [Package['git-core'], Package['php5'], Exec['global composer']],
        onlyif => [ "test -f /var/www/composer.json", "test -d /var/www/vendor" ],
        timeout => 900,
        logoutput => true
	}

	exec { 'install packages':
        command => "/bin/sh -c 'cd /var/www/ && composer install'",
        require => Package['git-core'],
        onlyif => [ "test -f /var/www/composer.json" ],
        creates => "/var/www/vendor/autoload.php",
        timeout => 900,
	}

    exec {"db-drop":
        require => Package["php5"],
        command => "/bin/sh -c 'cd /var/www/ && /usr/bin/php app/console doctrine:schema:drop --force'",
    }

    exec {"db-setup":
        require => [Exec["db-drop"], Package["php5"]],
        command => "/bin/sh -c 'cd /var/www/ && /usr/bin/php app/console doctrine:schema:create'",
    }

    exec {"db-default-data":
        require => [Exec["db-setup"], Package["php5"]],
        command => "/bin/sh -c 'cd /var/www/ && /usr/bin/php app/console doctrine:fixtures:load'",
        onlyif => [ "test -d /var/www/src/*/*/DataFixtures" ],
    }

    exec {"clear-symfony-cache":
        require => Package["php5-cli"],
        command => "/bin/sh -c 'cd /var/www/ && /usr/bin/php app/console cache:clear --env=dev && /usr/bin/php app/console cache:clear --env=prod'",
    }

	file { '/var/www/app/cache':
		mode => 0777
	}
}
