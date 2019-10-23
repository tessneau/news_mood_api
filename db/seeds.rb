


puts 'hello seeds 👾'



# ///////////////// NY Times ////////////////////

NYT_KEY = ENV["NYTIMES_API_KEY"]
NYT_SECRET = ENV["NYTIMES_SECRET"]

MOSTPOP_URL = "https://api.nytimes.com/svc/mostpopular/v2"
EMAILED_URL = "#{MOSTPOP_URL}/emailed/"
FBSHARE_URL = "#{MOSTPOP_URL}/facebook/"
VIEWED_URL = "#{MOSTPOP_URL}/viewed/"

def get_emailed(period)
  if [1,7,30].include? period
    url = "#{MOSTPOP_URL}/emailed/#{period}.json"
    r = RestClient.get(url, params: {"api-key": NYT_KEY})
    json = Oj.load(r)
    if json["status"] == "OK"
      puts "#{json["num_results"]} number of results"
      return json["results"]
    else
      puts 'request error'
    end
  else
    puts 'enter a valid period of 1, 7, or 30 days'
  end
end

def get_fbshared(period)
  if [1,7,30].include? period
    url = "#{MOSTPOP_URL}/facebook/#{period}.json"
    r = RestClient.get(url, params: {"api-key": NYT_KEY})
    json = Oj.load(r)
    if json["status"] == "OK"
      byebug
    else
      puts 'request error'
    end
  else
    puts 'enter a valid period of 1, 7, or 30 days'
  end     
end

def parse_articles
  emailed_articles = get_emailed(1)
  # emailed_articles[0].keys
  # => ["url", "adx_keywords", "subsection", "email_count", "count_type", "column", "eta_id", "section", "id", "asset_id", "nytdsection", "byline", "type", "title", "abstract", "published_date", "source", "updated", "des_facet", "org_facet", "per_facet", "geo_facet", "media", "uri"]
  # byebug
  emailed_articles.map { |article| p article["title"] }
end

parse_articles.each do |article|
  p article + "/n"
end

# //////////////// OJ ////////////////////////////
#
# h = { 'one' => 1, 'array' => [ true, false ] }
# json = Oj.dump(h)
#
# p json
#
# h2 = Oj.load(json)
# puts "Same? #{h == h2}"


# //////////////// TONE ANALYZER ///////////////////

# api_key = ENV["TONE_ANALYZER_APIKEY"]
# iam_api_key = ENV["TONE_ANALYZER_IAM_APIKEY"]
# service_url = ENV["TONE_ANALYZER_URL"]
#
#
# puts api_key
#
# authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
#   apikey: "#{iam_api_key}"
# )
#
# p authenticator
#
# tone_analyzer = IBMWatson::ToneAnalyzerV3.new(
#   authenticator: authenticator,
#   version: "2017-09-21"
# )
#
# tone_analyzer.service_url = "#{service_url}"
#
# utterances = [
#   {
#     "text" => "I am very happy.",
#     "user" => "glenn"
#   },
#   {
#     "text" => "It is a good day.",
#     "user" => "glenn"
#   }
# ]
#
# p "\ntone_chat example 1:\n"
# puts Oj.dump(tone_analyzer.tone_chat(utterances: utterances).result)
# p "\ntone_chat example 1:\n"
# puts JSON.pretty_generate(tone_analyzer.tone_chat(utterances: utterances).result)
#
# p "\ntone example 1:\n"
# puts JSON.pretty_generate(tone_analyzer.tone(
#   tone_input: "I am very happy. It is a good day.",
#   content_type: "text/plain"
# ).result)
