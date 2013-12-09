# Vagrant/Puppet setup for PHP (Symfony 2, other) projects

## Setup

-   Install vagrant on your system [vagrantup.com](http://vagrantup.com/v1/docs/getting-started/index.html)

-   Install vagrant-hostsupdater vagrant plugin [cogitatio/vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater)

-   Install vagrant-vbguest vagrant plugin [dotless-de/vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)

-   Install vagrant-exec vagrant plugin [p0deje/vagrant-exec](https://github.com/p0deje/vagrant-exec)

-   Get a base box with puppet support [vagrantup.com docs](http://vagrantup.com/v1/docs/getting-started/boxes.html)

-   Get a copy of this repository. You can do this either by integrating it as a git submodule or by just checking it out and copying the files.
    Prefarably, the contents of this repository should be placed in a directory `vagrant` inside your project's root dir.

-   Copy `your_app_folder/vagrant/Vagrantfile.sample` to `your_app_folder/Vagrantfile` and modify `your_app_folder/Vagrantfile` according to your needs.

-   Copy `your_app_folder/vagrant/Vagrantsettings.sample` to `your_app_folder/vagrant/Vagrantsettings` and modify `your_app_folder/vagrant/Vagrantsettings` according to your needs.

-   Copy `your_app_folder/vagrant/appbox.sample` to `your_app_folder/appbox`, change chmod to +x (use `chmod +x appbox`) and modify `your_app_folder/appbox` according to your needs. Use `php appbox` for call console commands in vagrant and run app update.

    Example:
    ```ruby
    # Name of the vhost to create
    $vhost = "app.local"

    # VM IP
    $ip = "33.33.33.10"

    # Memory size
    $memory_size = "1024"

    # Use NFS?
    $use_nfs = true

    # Base box name
    $base_box = "precise32"
    $base_box_url = "http://files.vagrantup.com/precise32.box"

    # PHP version (allowed: php54, php55)
    $php_version = "php55"

    # App server variables
    $app_env = "dev"
    $app_debug = "true"

    # App framework (allowed: symfony, none)
    $app_framework = "symfony"
    $app_public_root = "web"

    # Use xDebug?
    $use_xdebug = false
    ```
    -   Execute `vagrant up` in the directory vagrant.

## Infrastructure

After performing the steps listed above, you will have the following environment set up:

- A running virtual machine with your project on it
- Your project directory will be mounted as a shared folder in this virtual machine
- Your project will be accessible via a browser (go to `http://{$vhost}/` or `http://{$ip}/` or `http://localhost:8880/`)
- Your MySQL will be accessible on port `8886`
- Mysql user and password: `root`
- Default database: `appbox`
- You can now start customizing the new virtual machine. In most cases, the machine should correspond to the infrastructure your production server(s) provide.

## Being inspired by sources:

* [bryannielsen/Laravel4-Vagrant](https://github.com/bryannielsen/Laravel4-Vagrant)
* [seiffert/default-vagrant](https://github.com/seiffert/default-vagrant)
