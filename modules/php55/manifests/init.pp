class php55 {
	package { 'python-software-properties':
		ensure => present,
		require => Exec['php55 apt update']
	}

	exec { 'add php55 apt-repo':
		command => '/usr/bin/add-apt-repository ppa:ondrej/php5 -y',
		require => [Package['python-software-properties']],
	}

	exec { 'php55 apt update':
		command => 'apt-get update',
	}
}
