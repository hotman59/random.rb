class Group < ActiveRecord::Base
  has_many :person
  delegate :group_id, :sensei, :to => :person
end
