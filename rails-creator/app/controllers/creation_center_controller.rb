class CreationCenterController < ApplicationController
  def home
    # Github.configure do |c|
    #   c.basic_auth = 'jobenscott:Sunshine22'
    # end
   
    # github = Github.new client_id: '63c9b6b446bc369aee44', client_secret: '040d95c0d074763eca501b4553fe4383fa3f0430', org: 'RailsCreator'
    # oauth_token = '4a392d81518aa677768bd9a26d99c932a50426e5'
    # github = Github.new oauth_token: oauth_token
     # oauth_token: oauth_token

    # oauth_token: 'ca9fd10b60474d36bf30d4d47534173ed5217766'
    # puts github.auth_code.to_yaml
    # authorize = github.authorize_url({'scope' => ['repo']})
    # puts authorize.to_yaml
    # token = github.get_token('f2faad242d82079526b1')
    # puts token.to_yaml
    # scopes = github.oauth.create 'note' => 'something', 'scopes' => ['repo'], 'client_secret' => '040d95c0d074763eca501b4553fe4383fa3f0430'
    # # puts scopes.to_yaml 
    # repos = github.repos.list
    # p 'repos buddy'
    # repos.each do |repo|
    #   p repo.full_name
    # end

    # branches = github.repos(:repo => "testing_it_out_13", :org => "RailsCreator").branches
    # .create "name": "test_branch_1"
    # , 'org': 'RailsCreator'
    # puts branches.to_yaml

    # repo = Github::Client::Repos.create :user => 'jobenscott', :repo => 'testing_it_out'
    # puts repo.to_yaml
    # repo.save
    # Dir.chdir('')
    # p Dir["*"]

  end

  def new_app
  	app_name = params[:app_name]

    oauth_token = '536c7a5c9746d279bd8ac17ac02f81d863953519'
    github = Github.new oauth_token: oauth_token

    # get rails create app route
    rails_creator_route = Dir.pwd

	  # change to storage directory
    Dir.chdir('generated_apps')

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
      system route_text+' > '+local_app_path+'/config/routes.rb'
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


    respond_to do |format|
        format.json {
          render :js => "https://"+app_name+".herokuapp.com"
        }
    end
  end
end
