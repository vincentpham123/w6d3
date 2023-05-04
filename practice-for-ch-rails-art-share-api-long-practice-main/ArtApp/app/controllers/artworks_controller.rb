class ArtworksController < ApplicationController
    def index  
        if params.has_key?(:user_id)
            @artworks = Artwork.artworks_for_user_id(params[:user_id])
        else 
            @artworks = Artwork.all
        end
        render json: @artworks 
    end        

    def create
        artwork = Artwork.new(artwork_params)
        # replace the `artwork_attributes_here` with the actual attribute keys
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show 
        @artwork = Artwork.find(params[:id])
        render json: @artwork
    end

    def destroy
        @artwork = Artwork.find(params[:id])
        @artwork.destroy
        redirect_to artworks_url
    end

    def update
        #right now the artwork_params require that the info is nested in a artwork:
        @artwork = Artwork.find(params[:id])
        if @artwork.update(artwork_params)
            redirect_to artwork_url(@artwork)
        else
            render json: @artwork.errors.full_messages, status: 422
        end
    end

    private
    def artwork_params
        params.require(:artwork).permit(:title, :image_url,:artist_id)
    end
end
