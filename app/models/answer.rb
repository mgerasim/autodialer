require 'csv'
require 'net/http'
require 'addressable/uri'

class Answer < ApplicationRecord
    
    belongs_to :trank

    default_scope { order(created_at: :desc) }

    after_create :google_sheet_save 
#    after_create :skorozvon_save
   
    def self.to_csv
	attributes = %w{shown_date_created_at shown_time_created_at contact status trank_name}
	
	CSV.generate({:headers => false, :col_sep => ';'}) do |csv|
	    
	    all.each do |answer|
	        csv << attributes.map{ |attr| answer.send(attr) }
	    end
	    
	end
    end

    def shown_date_created_at
        (created_at.localtime).strftime("%Y-%m-%d")
    end

    def shown_time_created_at
        (created_at.localtime).strftime("%H:%M:%S")
    end

    def trank_name
        if (trank != nil)
            trank.name
        else
            ""
        end
    end

    private

    def skorozvon_save

       begin
		cmd = "curl http://localhost:5000/api/lead/#{self.contact}"
		puts cmd
  		msg = `#{cmd}`
		puts msg
	
 		uri = "http://localhost:5000/api/lead/#{self.contact}"
		url = URI.parse(uri)
		req = Net::HTTP::Get.new(url.to_s)
		puts url.to_s
#	res = Net::HTTP.start(url.host, url.port) {|http|
 # 			http.request(req)
#		}
#		puts res.body

		return		

		url = "https://app.skorozvon.ru/oauth/token"
                uri = URI.parse(url)
		https = Net::HTTP.new(uri.host, uri.port)
		https.use_ssl = true

		request = Net::HTTP::Post.new(uri)

		response = https.start do |http|
			post_data = URI.encode_www_form( { :grant_type => "password", :username => "ekc_partner@mail.ru", :api_key => "5b8f9556340391cff458ee71e511b3f093655fabaf51447b2a1c75ec504226fc", :client_id => "29055bf486467ffb99159edf3c21881d8ec4349ee1eb61c0b172364bbcc623b7", :client_secret => "172f48c27f7eb1c2322526b8f92d5b25dcc9cbc8785f137a428795b3f4a4cb2a" } )
			
			http.request(request, post_data)
		end

#		answer = https.post(uri.request_uri, { :grant_type => "12345zzzzZ!", :username => "ekc_partner@mail.ru", :api_key => "5b8f9556340391cff458ee71e511b3f093655fabaf51447b2a1c75ec504226fc", :client_id => "29055bf486467ffb99159edf3c21881d8ec4349ee1eb61c0b172364bbcc623b7", :client_secret => "172f48c27f7eb1c2322526b8f92d5b25dcc9cbc8785f137a428795b3f4a4cb2a" } ).body
 
		answer = JSON.parse(response.body)

		token = answer["access_token"]

#c = Answer.create(:contact => "123", :trank => Trank.first )

		
		url = "https://app.skorozvon.ru/api/v2/leads"
		uri = URI.parse(url)
		https = Net::HTTP.new(uri.host, uri.port)
                https.use_ssl = true

		headers = {
 		   'Authorization'=>"Bearer #{token}",
		    'Content-Type' =>'application/json',
		    'Accept'=>'application/json'
		}
		
		request = Net::HTTP::Post.new(uri, headers)

		request.body = '{"firm_name": "","name":"' + self.contact + '","post": "","city": "","business": "","homepage": "","address": "","comment": "","phones": ["' + self.contact + '"],"emails":[""],"external_id":"1"}'

		response = https.start do |http|
		
			http.request(request)

		end

		puts response.body









#		url = "https://app.skorozvon.ru/api/v2/leads"
#                uri = URI.parse(url)
#                https = Net::HTTP.new(uri.host, uri.port)
#                https.use_ssl = true

#                headers = {
#                   'Authorization'=>"Bearer #{token}",
#                    'Content-Type' =>'application/json',
#                    'Accept'=>'application/json'
#                }


 #               params = [{ :access_token => "#{token}", :data => {:id => 123 } }]
#
#                request = Net::HTTP::Post.new(uri)

 #               response = https.start do |http|
 #                       post_data = URI.encode_www_form( params)
 #                       http.request(request, post_data)
 #               end

 #               puts response.body
















#		http = Net::HTTP.new(uri.host, uri.port)
#		response = https.get( uri.path, params.to_json, headers )

		

#                request = Net::HTTP::Post.new(uri)
#
 #               response = https.start do |http|
  #                      post_data = URI.encode_www_form( { :grant_type => "password", :username => "ekc_partner@mail.ru", :api_key => "5b8f9556340391cff458ee71e511b3f093655fabaf51447b2a1c75ec504226fc", :client_id => "29055bf486467ffb99159edf3c21881d8ec4349ee1eb61c0b172364bbcc623b7", :client_secret => "172f48c27f7eb1c2322526b8f92d5b25dcc9cbc8785f137a428795b3f4a4cb2a" } )

   #                     http.request(request, post_data)
    #            end


#               answer = JSON.parse(response.body)

		
		
       
       rescue => error

 		puts error.message
		error.backtrace.each { |line| logger.error line }

	end


    end

    def google_sheet_save
      # AnswerCreateJob.perform_later self
      begin
   
       skorozvon_save
   
        puts "google_sheet_save"

        config = Config.first

        return if !config.is_google_integrated  
       
        puts "config.is_google_integrated"

         setting = Setting.first

      session = GoogleDrive::Session.from_service_account_key("/home/rails/projects/autodialer/public/system/settings/google_private_keys/000/000/004/original/avtoobzvon-220208-7622b8c4a673.json") #setting.google_private_key.path)

      spreadsheet = session.spreadsheet_by_title(setting.google_title)

      worksheet = spreadsheet.worksheets[ id %  spreadsheet.worksheets.count]

      row = [shown_date_created_at, shown_time_created_at, contact]

      worksheet.insert_rows(worksheet.num_rows + 1, [row])
    
      worksheet.save 
    
    rescue => error
      
      puts error.message

      error.backtrace.each { |line| logger.error line }

    end
    end
end
