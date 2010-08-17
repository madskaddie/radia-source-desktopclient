
class Emission < Broadcast

    def initialize(arg)
        super(arg)
          
        if arg[:structure].nil? then
            @live = true
        else
            @live = false
        end
    end

    def url()
        return " (Live)" if @live
        return " (e)" if @structure.empty?
        return @structure[0].asset.retrieval_uri.to_s + " (e)"
    end

    def url=(x, idx=0, deliver=true)
        return nil if @live
        @structure[idx].asset.url = x
        
        deliver(idx) if deliver
        return 1
    end

    def css()
        return {"background-color"=>"#E4D8C2","color"=>"#5F4A47"} if @live
        return {"background-color"=>"#961915","color"=>"#E4D8C2",} if not delivered
    end

    def delivered
        return if @live
        return @structure.select {|x| x.asset.delivered}.length.eql?(@structure.length)
    end
end
