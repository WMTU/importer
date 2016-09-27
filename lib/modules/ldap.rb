require 'net/ldap'

module LDAP
  # Check for group memebership
  def self.user_in_group?(username, group_name)
    # Create connection to server for searching
    connection = setup_connection

    # Setup filter so only groups with the username we are looking for get returned
    filter = Net::LDAP::Filter.eq CONFIG[:ldap][:group_attribute], username

    # Setup base dn to search in
    base = "cn=#{group_name},#{CONFIG[:ldap][:group_base_dn]}"

    # Execute search
    !connection.search(base: base, filter: filter).empty?
  end

  # Auth a username and password against an ldap server. Checks for sucessful bind to server only
  def self.authenticate(username, password)
    # Create connection to server for binding
    connection = setup_connection

    # Setup connection with base dn
    connection.authenticate "#{CONFIG[:ldap][:attribute]}=#{username},#{CONFIG[:ldap][:base_dn]}", password

    # Attempt to bind
    connection.bind
  end

  def self.user_info(username)
    search_for_user_by_property CONFIG[:ldap][:attribute], username
  end

  def self.user_info_from_email(email)
    search_for_user_by_property 'mail', email
  end

  def self.user_info_from_dsid(dsid)
    search_for_user_by_property 'internationaliSDNNumber', dsid
  end

  def self.search_for_user_by_property(property, value)
    # Create connection to server for binding
    connection = setup_connection

    # Setup search params to be specific to user
    filter = Net::LDAP::Filter.eq property, value

    # Setup base dn to search in
    base = CONFIG[:ldap][:base_dn].to_s

    # Execute search
    connection.search(base: base, filter: filter).first
  end

  def self.setup_connection
    if CONFIG[:ldap][:ssl]
      connection = Net::LDAP.new host: CONFIG[:ldap][:host], port: CONFIG[:ldap][:port], encryption: {method: :simple_tls}
    else
      connection = Net::LDAP.new host: CONFIG[:ldap][:host], port: CONFIG[:ldap][:port]
    end
    connection
  end
end
