# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  favorite   :boolean          default(FALSE)
#
class Artwork < ApplicationRecord
    validates_uniqueness_of :artist_id, scope: :title 

    belongs_to :artist,
        foreign_key: :artist_id,
        class_name: :User
    
    has_many :artwork_shares,
        dependent: :destroy,
        inverse_of: :artwork
        # foreign_key: :artwork_id,
        # class_name: :ArtworkShare,
        
    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer
    
    has_many :comments,
        foreign_key: :artwork_id,
        class_name: :Comment,
        dependent: :destroy,
        inverse_of: :artwork
    
    has_many :likes,
        as: :likeable

    def self.artworks_for_user_id(user_id)
        artist_works = Artwork
                        .select(:id,:title,:image_url)
                        .where('artist_id = ?', user_id)

        shared_works = Artwork
                        .select(:id,:title,:image_url)
                        .joins(:artworkshare)
                        .where('artwork_shares.viewer_id = ?', user_id)

        artist_works + shared_works
    end
end
