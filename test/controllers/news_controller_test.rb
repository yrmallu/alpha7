require 'test_helper'
class NewsControllerTest < ActionController::TestCase
  test "#index: successful news search" do
    test_json = File.read(Rails.root + 'test/lib/services/test_data/algolia_news.json')
    stub_request(:get, "http://hn.algolia.com/api/v1/search?page=0").
          to_return(:status => 200, :body => test_json, :headers => {'Content-Type' => 'application/json'})

    api = Services::Algolia::News.new('v1')
    news = api.news({page: 0})
    assert_equal 1, news['hits'].length
  end

end
