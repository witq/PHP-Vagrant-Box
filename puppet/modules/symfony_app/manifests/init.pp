class symfony_app
{

	package { 'git-core':
    	ensure => present,
    }

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

	file { '/var/www/app/cache':
		mode => 0777
	}
}
