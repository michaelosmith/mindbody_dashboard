class User < ApplicationRecord
  has_many :members
  has_many :trials

  before_create :set_slug
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable #,
        #  :omniauthable, :omniauth_providers => [:stripe_connect]


  def active_stripe_connect_account?
    stripe_account_id && stripe_account_active
  end

  def to_param
    slug
  end

private

  def set_slug
    loop do
      self.slug = SecureRandom.uuid
      break unless User.where(slug: slug).exists?
    end
  end

end
