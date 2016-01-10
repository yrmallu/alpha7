class NewsController < ApplicationController
  require 'services/algolia'
  include HTTParty
  def index
    parameters = params.blank? ? request.query_parameters.merge("numericFilters"=>"points>=1000") : (params["type"].blank? ? request.query_parameters.merge("numericFilters"=>"points>=1000") : request.query_parameters)
    @news_list = algolia_version.news(parameters.except(:type))
    @news = Kaminari.paginate_array(@news_list["hits"], total_count: total_news(@news_list)).page(params[:page]).per(20)
  end

  private
  #Algolia version
  def algolia_version
    Services::Algolia::News.new('v1')
  end
  def total_news(news)
    news["nbPages"] <= 1 ? news["hitsPerPage"] : ((news["nbPages"]-1)*news["hitsPerPage"])
  end
end
