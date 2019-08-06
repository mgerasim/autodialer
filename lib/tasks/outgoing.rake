namespace :outgoing do
  desc "TODO"
  task :status, [:outgoing, :status] => :environment do |t, args|
    puts "#{args.outgoing}"
    puts "#{args.status}"

    status = args.status

    status = 'Failed' if status == "0"
    status = 'Hung up' if status == "1"
    status = 'Ring timeout' if status == "3"
    status = 'Busy' if status == "5"
    status = 'Congestion' if status == "8"


    telephone = "7" + args.outgoing

    Outgoing.where(:telephone => telephone).each do |outgoing| 
      outgoing.update_attributes(:status => status)
    end
    

#    outgoing = Outgoing.find(args.outgoing)
#    outgoing.update_attributes(:status => status)    
  end

end
