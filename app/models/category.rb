class Category < ApplicationRecord

  strip_attributes

  def to_param # overrides default "to_param" to use :slug instead of :id and match routes
    slug
  end

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  has_many :products, dependent: :restrict_with_exception

end
