class User <ApplicationRecord 
  validates_presence_of :email, :name 
  validates_uniqueness_of :email
  validates_presence_of :password_digest, require: true

  has_many :viewing_parties

  has_secure_password

  enum role: %w(default user)
end 