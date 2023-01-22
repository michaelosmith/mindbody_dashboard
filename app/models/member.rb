class Member < ApplicationRecord
  belongs_to :user
  has_many :trials

  attr_accessor :trial_id, :stripe_connect_account_id

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }


private

end
