class ComposerCommand < Vagrant.plugin(2, :command)
  def execute
    ARGV.shift()
    puts `vagrant ssh -c "cd /var/www; composer #{ARGV.join(" ")}"`
  end
end
