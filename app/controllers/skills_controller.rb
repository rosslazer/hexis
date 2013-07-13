class SkillsController < ApplicationController



	def list


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



		arr = []
		user_id = ''
		user_id = current_user.id
		first = @neo.execute_query("START user=node:user_id(id='#{user_id}') MATCH user-[:skill_learn]-wanted RETURN wanted; ")
		first["data"].each do |entry|
			arr << entry[0]["data"]["name"]
		end

		second_query = ""
		second_rel = ""

		count = 0

		arr.each do |skill|

			second_query +=  "name:#{skill} OR "
			count += 1
		end

		second_query.chomp!("OR ")
		second_query.chomp!(",")

		second_rel += " "

		other_count = 0

			arr.each do |skill|

			second_rel +=  " s#{other_count}<-[:skill_own]-person#{other_count},"
			other_count += 1
		end

		second_rel.chomp!(", ")
		second_rel.chomp!(",")
		second_rel.chomp!(", ")
		second_rel.chomp!(",")
		second_rel += " "

		second = @neo.execute_query("START s0 = node:skill_name('#{second_query}') MATCH s0<-[:skill_own]-person return distinct person;")

		other_user = []
			second["data"].each do |entry|
				if entry[0]['data']['id'] != user_id
					other_user << entry[0]["data"]["id"]
				end


		end


	matched_user = []

				matched_arr = []

		
		other_user.each do |user|
			returned_user = @neo.execute_query("START user=node:user_id(id='#{user}') MATCH user-[:skill_learn]-wanted RETURN wanted; ")
			


			returned_user["data"].each do |entry|
			matched_arr << entry[0]["data"]["name"]
		end

		back_query = ""
		matched_arr.each do |skill|

			back_query +=  "name:#{skill} OR "
			count += 1
		end

		back_query.chomp!("OR ")
		back_query.chomp!(",")

		final = @neo.execute_query("START s0 = node:skill_name('#{back_query}') MATCH s0<-[:skill_own]-person return distinct person;")
 

			final["data"].each do |entry|
				if entry[0]['data']['id'] == user_id
					matched_user << user
				end


		end


		end 




		@final_user_data = []

		matched_user.each do |user|
			skills = []
			their_skills = @neo.execute_query("START user=node:user_id(id='#{user}') MATCH user-[:skill_learn]-wanted RETURN wanted; ")

			their_skills["data"].each do |entry|
			skills << entry[0]["data"]["name"]
		end

			@final_user_data << {:first_name => User.find(user).first_name, :last_name => User.find(user).last_name, :id => user, :skills => skills}

		end


		end


	def create

		@neon = Neography::Rest.new({ :protocol       => 'http://',
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






  		user_node = @neo.create_unique_node("user_id", "id", @user['id'],  {"id" => @user['id'], "location" => @user['zip'], "age" => @user['age']})



		@skill_nodes.each do |skill|
			@neo.create_relationship("skill_own", user_node , skill)
		end

		@desire_nodes.each do |desire|
			@neo.create_relationship("skill_learn", user_node , desire)
		end

		redirect_to action: "list"





  # Some more logic for validating the parameters passed in
	end

		end



