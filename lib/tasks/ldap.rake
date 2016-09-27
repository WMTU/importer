namespace :ldap do
  desc 'Starts a development LDAP server'
  task start: :environment do
    begin
      server = Ladle::Server.new(
        port: 3897,
        tmpdir: '/tmp'
      )
      server.start
      loop { sleep 3600 }
    rescue SignalException
      server.stop
    end
  end
end
