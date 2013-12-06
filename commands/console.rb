class ComposerCommand < Vagrant.plugin(2, :console)
  def execute
    ARGV.shift()
    puts `vagrant ssh -c "php /var/www/app/console #{ARGV.join(" ")}"`
  end
end
