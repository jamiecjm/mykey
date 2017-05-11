class User < ApplicationRecord
  include Clearance::User
  has_many :units
  has_many :projects, through: :units
  validates_confirmation_of :password

  attr_accessor :original_password

  before_save :titleize_name

  enum title: ["Mr","Mrs","Ms","Dato","Datuk","Datin","Dato Sri","Tan Sri","Tun"]

  private

  def titleize_name
    self.name = self.name.titleize.strip if self.name.present?
  end

end
