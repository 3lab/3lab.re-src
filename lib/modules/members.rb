require 'yaml'
require 'fileutils'

module Members
  class << self
    attr_accessor :list
  end

  class Member
    attr_accessor :username, :description, :homepage, :repositories, :mail
    def initialize(params = {})
      @username = params.fetch(:username, 'unknown')
      @description = params.fetch(:description, nil)
      @homepage = params.fetch(:homepage, 'http://3lab.re/')
      @repositories = params.fetch(:repositories, ['http://git.3lab.re/' + @username])
      @mail = params.fetch(:mail, nil)
    end
  end

  def Members.hash_to_member(memberhash)
    Member.new(
      username: memberhash['username'],
      description: memberhash['description'],
      homepage: memberhash['homepage'],
      repositories: memberhash['repositories'].split(','),
      mail: memberhash['mail']
    )
  end

  def Members.load_members
    members_arr = []
    path = File.dirname(__FILE__).split('/')[0..-3].join('/') + '/source/members/*.yml'
    Dir[path].each do |member_path|
      members_arr << Members.hash_to_member((YAML.load_file(member_path)))
    end
    self.list = members_arr
  end
end

Members.load_members