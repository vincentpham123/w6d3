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
        class_name: :User
    
    has_many :artworkshare,
        foreign_key: :artwork_id,
        class_name: :ArtworkShare,
        dependent: :destroy
    
    has_many :shared_viewers,
        through: :artworkshare,
        source: :viewer

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
