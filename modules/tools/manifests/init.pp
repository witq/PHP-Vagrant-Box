class tools {
    package { ['mlocate',
            'zip',
            'unzip',
            'curl',
            'git-core',
            'build-essential',
            'nano',
            'mc']:
        ensure => present,
        require => Exec['apt-get update']
    }

    exec { 'find-utils-updatedb':
        command => '/usr/bin/updatedb &',
        require => Package['mlocate'],
    }
}
