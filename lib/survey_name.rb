class Survey_Name < ActiveRecord::Base
  belongs_to :survey
  belongs_to :history
end
