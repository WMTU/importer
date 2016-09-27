module Users
  class Authenticate
    include Service

    def initialize(username, password)
      @username = username
      @password = password
    end

    def call
      return nil unless LDAP.authenticate @username, @password
      return nil unless ldap_info = LDAP.user_info(@username)

      User.find_or_create_by username: @username do |u|
        u.email = ldap_info.mail.first
        u.name = ldap_info.givenName.first
      end
    end
  end
end
