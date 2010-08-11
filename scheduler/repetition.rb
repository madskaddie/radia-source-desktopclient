class Repetition < Broadcast
    def url()
        return "ERROR" if @structure.empty?
        return @structure[0].asset.retrieval_uri.to_s + " (r)"
    end

    def url=(x)
        return nil
    end

    def css()
        return { "background-color" =>"#CC5C5B", "color"=>"#5F4A47" } if @structure.empty?
        return { "background-color" =>"#5F4A47", "color"=>"#CC5C5B" } if not delivered 
        return { "background-color" =>"#5F4A47", "color" =>"#E4D8C2", }
    end

    def delivered
        false
    end
end
