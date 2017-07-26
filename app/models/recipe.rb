class Recipe < ApplicationRecord
  has_many :ingrediants
  has_many :directions

  accepts_nested_attributes_for :ingrediants,
                                reject_if: proc { |attributes| attributes['name'].blank? },
                                allow_destroy: true

  accepts_nested_attributes_for :directions,
                                reject_if: proc { |attributes| attributes['name'].blank? },
                                allow_destroy: true

  validates :title, :description, :image, presence: true
  
  has_attached_file :image, styles: {
      medium: "400x400#",
      thumb: '200x200#'
    }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
