class FeaturedMovies::Movie
    attr_accessor :titles, :creators, :descriptions, :genres, :urls, :description_collection

    def self.current
      self.scrape_ng
    end

    def self.scrape_ng
      doc = Nokogiri::HTML(open("https://newgrounds.com"))
      movie = self.new
      movie.titles = []
      movie.creators = []
      movie.genres = []
      movie.descriptions = []
      movie.urls = []
      collection = doc.search("#featured_fp_content_1 .item-details").text.gsub("\t", "").split("\n") #acquire creators and titles
      description_collection = doc.search("#featured_fp_content_1 .item-icon-hover").text.gsub("\t", "").split("\n") #acquire descriptions and genres
      movie.urls = doc.xpath('//div[@class="span-1 align-center"]/a/@href').map(&:value) #acquire urls
      
      x = 0 #parse through collection to get rid of unwanted elements
      while x != collection.size
        if collection[x] == ""
          collection.delete_at(x)
        end
        x = x + 1
      end
      y = 0 #add appropriate elements to corresponding arrays
      while y != collection.size
        if y % 2 == 0
          movie.titles << collection[y]
        else
          movie.creators << collection[y]
        end
        y = y + 1
      end

      movie.genres << description_collection[4] #hard coding fix for the incorrect allocation of elements in movie.genres
      a = 0 #parse through description_collection to get rid of unwanted elements
      while a != description_collection.size
        if a % 2 == 0
          z = 0
          while z != description_collection.size #add appropriate elements to corresponding arrays (in loop as it helped eliminate unwanted elements (somehow?))
            if description_collection[z] == ""
              description_collection.delete_at(z)
            end
            z = z + 1
          end  
          movie.descriptions << description_collection[a]
        else
          movie.genres << description_collection[a]
        end
        a = a + 1
      end
      movie.genres.delete_at(1)
  
      return movie
    end

end