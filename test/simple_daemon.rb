require File.dirname(__FILE__) + '/test_helper.rb'
require File.dirname(__FILE__) + '/../lib/i_can_daemonize'

class SimpleDaemon
  include ICanDaemonize

  arg '--test=VALUE', 'Test Arg' do |value|
    @test = value
  end

  arg '-s', '--short-test=VALUE', 'Test arg with shortname' do |value|
    @short_test = value
  end

  sig(:int, :term) do
  end

  counter = 0
  daemonize do
    if @options[:loop_every]
      counter += 1
      File.open(TEST_FILE, 'w'){|f| f << counter}
    elsif @test
      File.open(TEST_FILE, 'w'){|f| f << "#{@test}|#{@short_test}"}
    else
      File.open(TEST_FILE, 'w'){|f| f << "#{log_file}|#{pid_file}"}
    end
  end
end
