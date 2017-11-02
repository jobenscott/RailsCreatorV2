class CreationCenterController < ApplicationController
  def home
  
    # github = Github.new client_id: '', client_secret: '', org: 'RailsCreator'

    # authorize = github.authorize_url({'scope' => ['repo']})
    # puts authorize.to_yaml
    # token = github.get_token('')
    # puts token.to_yaml

  end

  def new_app
  	app_name = params[:app_name]

    oauth_token = ENV.fetch('OAUTH_TOKEN')
    github = Github.new oauth_token: oauth_token

    # get rails create app route
    rails_creator_route = Dir.pwd

	  # change to storage directory
    Dir.chdir('../rails-creator-apps')
    rails_creator_apps_route = Dir.pwd

  	# start new thread for rails app creation
  	rails_app_creation = Thread.new do
  		system 'rails new '+app_name+' --database=postgresql'
  	end

  	# wait for rails app creation thread to finish
  	rails_app_creation.join

  	# change to new rails app directory
  	Dir.chdir(app_name)

    # generate home controller with dashboard action
    generate_home = Thread.new do
      system "rails generate controller Home dashboard"
    end

    # wait for home controller generate
    generate_home.join

    # route text
    route_text = 'echo "Rails.application.routes.draw do\nroot \"home#dashboard\"\nend"'

    # re-write routes
    routes_rewrite = Thread.new do
      system route_text+' > '+rails_creator_apps_route+'/'+app_name+'/config/routes.rb'
    end

    # wait for route re-write
    routes_rewrite.join

    # setup database
    db_setup = Thread.new do
      system "rake db:setup"
    end

    # wait for db setup
    db_setup.join

    # db migration
    db_migration = Thread.new do
      system "rails db:migrate"
    end

    # wait for db migration
    db_migration.join

    # create repo
    github.repos.create "name": app_name, "org": "RailsCreator"

  	# start new thread for git repository initialization
  	git_initialize = Thread.new do
  		system 'git init;git add .;git add -A; git commit -m "initial commit for '+app_name+'";git remote add origin https://jobenscott:'+oauth_token+'@github.com/RailsCreator/'+app_name+'.git'
  	end

    # wait for git repo init to finish
    git_initialize.join

    # initial git push
    git_push = Thread.new do
      system "git push origin master"
    end

    # wait for initial git push
    git_push.join

    # get time in milliseconds to append to production_branch
    branch_timestamp = Time.now.strftime('%Y%m%d%H%M%S%L')

    # concat for branch name
    branch_name = "production_branch_"+branch_timestamp

    # create new branch
    new_branch = Thread.new do
      system "git checkout -b "+branch_name
    end

    # wait for new branch to create
    new_branch.join

    # push to branch branch
    branch_push = Thread.new do
      system "git push origin "+branch_name
    end

    # wait for branch push
    branch_push.join


    # HEROKU STUFF
  	# start new thread for heroku app creation
  	heroku_creation = Thread.new do
  		system "heroku create "+app_name
  	end
  	# wait for heroku app creation to finish
  	heroku_creation.join

    # push to heroku app
    heroku_push = Thread.new do
      system "git push heroku master"
    end

    # wait for heroku push
    heroku_push.join

    # heroku bundle
  	heroku_bundle = Thread.new do
      system "heroku run bundle install"
    end

    # wait for heroku bundle install
    heroku_bundle.join

    # heroku db migration
    heroku_db_migration = Thread.new do
      system "heroku rake db:migrate"
    end

    # wait for heroku db migration
    heroku_db_migration.join

    # return to rails creator directory
    Dir.chdir(rails_creator_route)

    # remove generated app from temp storage
    remove_generated_app = Thread.new do
      system 'rm -rf '+rails_creator_apps_route+'/'+app_name
    end

    # print where we are for safe-keeping
    Dir.pwd


    respond_to do |format|
        format.json {
          render :js => "https://"+app_name+".herokuapp.com"
        }
    end
  end
end
