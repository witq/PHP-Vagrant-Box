class ComposerCommand < Vagrant.plugin(2, :composer)
  def execute
    ARGV.shift()
    puts `vagrant ssh -c "cd /var/www; composer #{ARGV.join(" ")}"`
  end
end
