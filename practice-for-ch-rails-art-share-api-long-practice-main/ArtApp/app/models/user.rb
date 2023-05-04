# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    validates :name, uniqueness:true, presence: true

    has_many :artworks,
        foreign_key: :artist_id,
        dependent: :destroy,
        inverse_of: :artist

    has_many :artworkshares,
        foreign_key: :viewer_id,
        class_name: :ArtworkShare,
        dependent: :destroy,
        inverse_of: :viewer

    has_many :shared_artworks,
        through: :artworkshares,
        source: :artwork,
        dependent: :destroy

    has_many :comments,
        foreign_key: :author_id,
        class_name: :Comment,
        inverse_of: :author,
        dependent: :destroy 

    has_many :likes,
        foreign_key: :liker_id,
        dependent: :destroy,
        inverse_of: :liker
    
    has_many :liked_artworks,
        through: :likes,
        source: :likeable,
        source_type: :Artwork
    
    has_many :liked_comments,
        through: :likes,
        source: :likeable,
        source_type: :Comment
end
