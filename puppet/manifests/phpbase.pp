# Enable XDebug ("0" | "1")
$use_xdebug = "0"

# Default path
Exec
{
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

exec
{
    'apt-get update':
        command => '/usr/bin/apt-get update',
        require => Exec['add php55 apt-repo']
}

include bootstrap
include other
include php55
include php
include apache
include mysql
include phpmyadmin
include beanstalkd
include memcached

include symfony_app
