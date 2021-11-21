cache 'feed_cache_key', expires_in: 30.minutes do
  xml.instruct! :xml, :version => "1.0"
  xml.rss :version => "2.0" do
    xml.channel do
      xml.title "Rails Tutorial sample app"
      xml.description "Rails Tutorial sample app rss feed "
      xml.link root_url
      xml.language 'ja'

      @feeds.each do |f|
        xml.item do
          xml.title f.user.name
          xml.description f.content
          xml.image image_url(url_for(f.picture)) if f.picture?
          xml.pubDate f.updated_at.to_s(:rfc822)
          xml.link user_url(f.user)
          xml.guid user_url(f.user)
        end
      end
    end
  end
end