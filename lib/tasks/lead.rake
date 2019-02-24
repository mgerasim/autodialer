namespace :lead do
  desc "TODO"
  task :incoming, [:telephone, :trunk,:rails_env] => :environment  do |t, args|

	puts "#{args.telephone}"

	

  end

end
