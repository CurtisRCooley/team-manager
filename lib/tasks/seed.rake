namespace :db do
  desc "Seed the database with once/ and always/ fixtures."
  task :seed => :environment do
    Right.destroy_all
    Role.destroy_all
    User.destroy_all
    admin_role = Role.create(:name => 'admin')
    user_right = Right.create(:name => 'Manage Users', :controller => 'users', :action => 'all')
    admin_right = Right.create(:name => 'Admin', :controller => 'admin', :action => 'all')
    admin_role.rights << admin_right
    admin_role.rights << user_right
    user = User.new(:email => 'curtis@thecooleys.org')
    user.password='Perturbed'
    user.roles << admin_role
    user.save
  end

  desc "Seed the database with develop/ fixtures."
  task :develop => :environment do 
    load_fixtures 'seed/develop', :always
  end
		 
		 
private
		   
    def load_fixtures(dir, always = false)
	Dir.glob(File.join(RAILS_ROOT, 'db', dir, '*.yml')).each do |fixture_file|
            table_name = File.basename(fixture_file, '.yml')
	    if table_empty?(table_name) || always
	        truncate_table(table_name)
	        Fixtures.create_fixtures(File.join('db/', dir), table_name)
	    end
	end
    end  
		     
    def table_empty?(table_name)
        quoted = connection.quote_table_name(table_name)
        connection.select_value("SELECT COUNT(*) FROM #{quoted}").to_i.zero?
    end
	       
    def truncate_table(table_name)
	quoted = connection.quote_table_name(table_name)
	connection.execute("DELETE FROM #{quoted}")
    end
		 
    def connection
        ActiveRecord::Base.connection
    end
end
