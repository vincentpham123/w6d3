# == Schema Information
#
# Table name: artworks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
    validates_uniqueness_of :artist_id, scope: :title 

    belongs_to :artist,
        foreign_key: :artist_id,
        class_name: :User 
    
    
end
