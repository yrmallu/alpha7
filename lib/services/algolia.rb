module Services

  module Algolia
    class News
      include HTTParty
      # base_uri Rails.application.secrets[:services]['algolia']['host']

      def initialize(api_version)
        @api_version = api_version
      end

      # search news
      def news(params)
        res = self.class.get("http://hn.algolia.com/api/v1/search_by_date?query=github&restrictSearchableAttributes=url", {query: params})
        res.parsed_response
      end
    end
  end
end
