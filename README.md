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

### Apache .htaccess example for FCGI/CGI

# General Apache options
AddHandler fastcgi-script .fcgi
AddHandler cgi-script .cgi
Options +FollowSymLinks +ExecCGI

# If you don't want Rails to look in certain directories,
# use the following rewrite rules so that Apache won't rewrite certain requests
# 
# Example:
#   RewriteCond %{REQUEST_URI} ^/notrails.*
#   RewriteRule .* - [L]

# Redirect all requests not available on the filesystem to Rails
# By default the cgi dispatcher is used which is very slow
# 
# For better performance replace the dispatcher with the fastcgi one
#
# Example:
#   RewriteRule ^(.*)$ dispatch.fcgi [QSA,L]
RewriteEngine On

# If your Rails application is accessed via an Alias directive,
# then you MUST also set the RewriteBase in this htaccess file.
#
# Example:
#   Alias /myrailsapp /path/to/myrailsapp/public
#   RewriteBase /myrailsapp

RewriteRule ^$ index.html [QSA]
RewriteRule ^([^.]+)$ $1.html [QSA]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ dispatch.cgi [QSA,L]

# In case Rails experiences terminal errors
# Instead of displaying this message you can supply a file here which will be rendered instead
# 
# Example:
#   ErrorDocument 500 /500.html

ErrorDocument 500 "<h2>Application error</h2>Rails application failed to start properly"
