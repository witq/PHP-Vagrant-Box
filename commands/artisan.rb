class Artisan < Vagrant.plugin(2, :command)
  def execute
    ARGV.shift()
    puts `vagrant ssh -c "php /var/www/artisan #{ARGV.join(" ")}"`
    0
  end
end