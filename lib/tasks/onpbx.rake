require "uri"

require "net/http"

namespace :onpbx do
  desc "TODO"
  task diag: :environment do

    puts "diag"

    params = {'login' => '79051408000@yandex.ru', 'pass' => '43fe72a472f3cfc398fed4fc0ec46176975a8b50011ff3d131685b800961bfa5244505d7de4532bbfa22fff1164ca2b252e0af72b592a7ebb40d00bc28f961d0'}
x = Net::HTTP.post_form(URI.parse('https://panel2.onlinepbx.ru/?auth=1'), params)
puts x.body

  end

end
