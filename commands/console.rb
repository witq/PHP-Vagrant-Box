class Console < Vagrant.plugin(2, :command)
  def execute
    ARGV.shift()
    puts `vagrant ssh -c "php /var/www/app/console #{ARGV.join(" ")}"`
    0
  end
end
