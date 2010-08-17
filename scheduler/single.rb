
class Single < AudioAsset

    def initialize(id=nil, uri="")
        super()
        @id = id
        @retrieval_uri = uri
    end

    def delivered
        return ! @retrieval_uri.to_s.empty?()
    end

    def url()
        return @retrieval_uri 
    end

    def url=(uri)
        @retrieval_uri = uri
    end

    def [](x)
        return self
    end

    def each
        [self].each{ |i| yield i }
    end

    def label
        url = self.url()
        return "(#{@id})| #{url}"
    end

    def self.load_ar(ar)
        single = Middleware::fetch_single ar.id
        return Single.new(id=single.id, single.attributes["retrieval-uri"])
    end

end
