# Team Manager
Simple program to help recreational sports managers manage games and rosters.

## Rails Help

### Getting Started

1. At the command prompt, start a new Rails application using the <tt>rails</tt> command
   and your application name. Ex: rails myapp
2. Change directory into myapp and start the web server: <tt>script/server</tt> (run with --help for options)
3. Go to http://localhost:3000/ and get "Welcome aboard: You're riding the Rails!"
4. Follow the guidelines to start developing your application


### Web Servers

By default, Rails will try to use Mongrel if it's are installed when started with script/server, otherwise Rails will use WEBrick, the webserver that ships with Ruby. But you can also use Rails
with a variety of other web servers.

Mongrel is a Ruby-based webserver with a C component (which requires compilation) that is
suitable for development and deployment of Rails applications. If you have Ruby Gems installed,
getting up and running with mongrel is as easy as: <tt>gem install mongrel</tt>.
More info at: http://mongrel.rubyforge.org

Say other Ruby web servers like Thin and Ebb or regular web servers like Apache or LiteSpeed or
Lighttpd or IIS. The Ruby web servers are run through Rack and the latter can either be setup to use
FCGI or proxy to a pack of Mongrels/Thin/Ebb servers.
