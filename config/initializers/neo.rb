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

