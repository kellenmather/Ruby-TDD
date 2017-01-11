class User < ActiveRecord::Base
  has_secure_password

  has_many :ideas
  has_many :likes

  # Validations
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
  validates :fn, :ln, :alias, :email, :password, :presence => true

end
