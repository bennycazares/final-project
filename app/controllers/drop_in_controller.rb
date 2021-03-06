class DropInController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def index
    search_params =  {
      term: '"crossfit"',
      limit: 16,
      sort: 1,
      radius_filter: 20000
    }

    if params[:post_code]
      search_term = params[:post_code]
      @yelp_response =  Yelp.client.search(search_term, search_params)
    elsif params[:lat] && params[:lng]
      @user_coordinates = {
        latitude: params[:lat],
        longitude: params[:lng]
      }

      @yelp_response =  Yelp.client.search_by_coordinates(@user_coordinates, search_params)

    end

    @array = @yelp_response.businesses
    @location_results = Gmaps4rails.build_markers(@array) do |business, marker|
        marker.lat business.location.coordinate.latitude
        marker.lng business.location.coordinate.longitude
        marker.infowindow render_to_string(:partial => "infowindow",
                                           :locals => {
                                           :business => business})

    end



    render( json: {gmaps_data: @location_results.as_json})


  end
end
