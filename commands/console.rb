class ConsoleCommand < Vagrant::Command::Base
  def execute
    ARGV.shift()
    puts `vagrant ssh -c "php /var/www/app/console #{ARGV.join(" ")}"`
  end
end

Vagrant.commands.register(:console) { ConsoleCommand }
