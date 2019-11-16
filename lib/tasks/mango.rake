require 'net/http'
require 'json'
namespace :mango do
  desc "TODO"
  task employee: :environment do
    puts "mango.employess"

    base_url = "https://app.mango-office.ru/vpbx";
    command_url = "/config/users/request";
    vpbx_api_key = "bx87j76eaoet53vhyd06qae4ksbhf89g";
    vpbx_api_salt = "v8e56aa6peql8btxejtvkxpugq2lo1sa";
    json = "{}";

    hash = Digest::SHA256.digest((vpbx_api_key + json + vpbx_api_salt).encode('utf-8'))

    sign = "8fb2c3e8734a5d335643e01bc369559e4a77800ae734bda187713c7f6ba99563"
    
    puts sign

    uri = URI.parse(base_url + command_url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(uri.path)
    form_data = URI.encode_www_form({:vpbx_api_key => vpbx_api_key, :sign => sign, :json => json })

    puts form_data

    request.body = form_data
    
    res = https.request(request)
    content = JSON.parse(res.body)
    users = content["users"]

    users.each do |user|
      name = user["general"]["name"]

      emp = Employee.where(:name => name).first

      numbers = user["telephony"]["numbers"]

      if (emp == nil)   
        emp = Employee.create(:name => name)
      end

      if (numbers.length > 0)
        emp.update_attributes(:status => numbers[0]["status"]=="on" ? 1 : 0)
      end

    end

  end

end
