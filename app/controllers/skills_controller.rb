class SkillsController < ApplicationController



	def new
	end

	def create

		@neo = Neography::Rest.new({ :protocol       => 'http://',
                             :server         => 'edacb06fc.hosted.neo4j.org',
                             :port           => 7858,
                             :directory      => '',
                             :authentication => 'basic',
                             :username       => 'e35a2ae60',
                             :password       => 'b1128b6be',
                             :log_file       => 'neography.log',
                             :log_enabled    => false,
                             :max_threads    => 20,
                             :cypher_path    => '/cypher',
                             :gremlin_path   => '/ext/GremlinPlugin/graphdb/execute_script' })



		@user = current_user

		skill1 = params[:skill1]
		skill2 = params[:skill2]
		skill3 = params[:skill3]
		@skills = [skill1, skill2, skill3]
		desire1 = params[:desire1]
		desire2 = params[:desire2]
		desire3 = params[:desire3]
		@desires = [desire1, desire2, desire3]



		@skill_nodes = []
		@desire_nodes = []
		@skills.each do |skill|
			@skill_nodes << @neo.create_unique_node("skill_name", "name", skill, {"name"=>skill})

		end

		@desires.each do |desire|
			@desire_nodes << @neo.create_unique_node("skill_name", "name", desire, {"name"=>desire})
		end






  		user_node = @neo.create_node("id" => @user['id'], "location" => @user['zip'], "age" => @user['age'])



		@skill_nodes.each do |skill|
			@neo.create_relationship("skill_own", user_node , skill)
		end

		@desire_nodes.each do |desire|
			@neo.create_relationship("skill_learn", user_node , desire)
		end



  # Some more logic for validating the parameters passed in
	end


end
