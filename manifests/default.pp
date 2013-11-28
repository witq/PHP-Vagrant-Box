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
include tools
include php55
include php
include apache
include mysql
include phpmyadmin
include beanstalkd
include memcached

if $app_framework == 'symfony' {
    include symfony_app
}
