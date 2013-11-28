class tools
{
    package { ['curl', 'git-core', 'nano', 'mc']:
        ensure => present,
        require => Exec['apt-get update']
    }
}
