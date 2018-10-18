class Outgoing < ApplicationRecord
  include ActiveModel::Validations

  attr_accessor :csv_upload

end
