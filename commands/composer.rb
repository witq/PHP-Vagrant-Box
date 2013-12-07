class Composer < Vagrant.plugin(2, :command)
  def execute
    ARGV.shift()
    puts `vagrant ssh -c "cd /var/www; composer #{ARGV.join(" ")}"`
    0
  end
end
