require 'rake'
require 'highline/import'
require 'fileutils'
require 'image_optimizer'
require 'mini_magick'
require 'erb'
require 'unidecoder'
require 'digest/md5'
require 'open-uri'

def gravatar_link( email )
  "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
end

def download_image( username, link )
  open(link) {|f|
    File.open('source/images/' + username + '.png', 'w') do |file|
      file.puts f.read
    end
  }
  true
rescue NoMethodError, ArgumentError => e
  puts e.inspect
  puts 'Failed to download file.'
  false
end

task :add_member do
  say "<%= color('3lab - Add Member', BOLD, UNDERLINE) %>"
  @username = ask 'Username: '
  @homepage = ask 'Homepage: '
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  @mail = ask 'Mail: '
  @description = ask 'About: '
  @repositories = ask('Repo links (GitHub, git.3lab.re - separated with \',\' & http:// prefixed): '){|q| q.default = "http://git.3lab.re/#{@username}, http://github.com/#{@username}"}
  template = 'lib/templates/member.yml.erb'
  generated = @username
  content = File.read(template)
  renderer = ERB.new(content)
  say 'Writing to source/members...'
  File.open("source/members/#{generated}.yml", 'w') do |f|
    f.write( renderer.result )
  end
  say 'Written source/members/' + generated + '.yml'
  choose do |menu|
    menu.prompt = 'Please select an avatar option: '
    menu.choice(:gravatar) {
      say('Sure, no problem!')
      if download_image( @username, gravatar_link( @mail ) )
        say 'Done!'
      else
        # todo: do this better
        abort 'Something went wrong!'
        exit
      end
    }
    menu.choices(:link) {
      link = ask 'Aight, just give me the link: '
      if download_image( @username, link )
        say 'Done!'
      else
        # todo: do this better
        abort 'Something went wrong!'
        exit
      end
    }
  end
end

task :add_project do
  say "<%= color('3lab - Add Project', BOLD, UNDERLINE) %>"
  @name = ask 'Name: '
  @description = ask 'Description: '
  @link = ask 'Live (demo): '
  @source = ask('Source: '){ |q| q.default "http://git.3lab.re/3lab/#{@name}"}
end

task :create_article do

  cli.say 'Creating matching folder with placeholder pictures...'
  Dir.mkdir("source/blog/#{ generated }")
  Dir.entries('lib/templates/assets').select{ |entry| !( entry == '.' or entry == '..' ) }.each do |entry|
    cli.say 'Writing source/blog/' + generated + '/' + entry + '...'
    File.open( 'lib/templates/assets/' + entry, 'rb' ) do |input|
      File.open( "source/blog/#{ generated }/#{ entry }", 'wb') do |output|
        while buff = input.read(4096)
          output.write( buff )
        end
      end
    end
    cli.say ' done.'
  end
  cli.say 'Completed. Exiting.'
end