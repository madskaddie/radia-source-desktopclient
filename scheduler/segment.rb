
class Single < AudioAsset
end
class Segment
    attr_accessor :asset

    def initialize(at)
        @fill = at[:fill] or true
        @items = at[:items] or 1
        @random= at[:random] or false
        @asset = at[:asset]
    end

    def self.load_ar(seg)
        Segment.new(:fill=>seg.attributes["fill"], :items=>seg.attributes["items-to-play"], 
                    :random=>seg.random, :asset =>self.asset(seg))

    end

    def self.asset(asset)
        if asset.respond_to?("single") then
            return Single.load_ar(asset.single)
        end
    end

    def retrieval_uri
        @asset.retrieval_uri
    end

    def url=(x)
        @asset.url=x
    end

end

