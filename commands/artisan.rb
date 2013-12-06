class ComposerCommand < Vagrant.plugin(2, :artisan)
  def execute
    ARGV.shift()
    puts `vagrant ssh -c "php /var/www/artisan #{ARGV.join(" ")}"`
  end
end
