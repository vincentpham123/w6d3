# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    validates :name, uniqueness:true, presence: true

    has_many :artworks,
        dependent: :destroy,
        inverse_of: :artist

    has_many :artworkshares,
        foreign_key: :viewer_id,
        class_name: :ArtworkShare,
        dependent: :destroy

    has_many :shared_artworks,
        through: :artworkshares,
        source: :artwork,
        dependent: :destroy

end
