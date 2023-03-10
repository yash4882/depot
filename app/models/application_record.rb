class ApplicationRecord < ActiveRecord::Base
  paginates_per 2
  primary_abstract_class
end
