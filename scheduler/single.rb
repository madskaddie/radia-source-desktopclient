
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
        begin
            single = Middleware::fetch_single @id
            single.retrieval_uri = uri
            single.authored = true
            single.save
            @retrieval_uri = uri
        end
        return @retrieval_uri
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
