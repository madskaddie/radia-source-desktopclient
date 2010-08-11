

class Broadcast
    attr_accessor :dtstart, :dtend, :name
    attr_accessor :structure

    def initialize(arg)
        @id = arg[:id] or -1
        @name = arg[:name] or "undefined"
        @dtstart = arg[:dtstart]
        @dtend = arg[:dtend]
        @structure = arg[:structure] or []
    end

    def css()
        { "color" =>"#E4D8C2", "background-color"=>"#961915" }
    end

    def self.load_ar(bc)

        begin
            dtstart = bc.dtstart
            dtend = bc.dtend
            type = bc.attributes["type"]

            if bc.attributes.has_key?("program_id") 
                name =bc.attributes["program_id"]
            elsif bc.prefix_options.has_key?(:program_id)
                name =bc.prefix_options[:program_id]
            else
                name = "GAP"
            end

            case type
            when "gap" then
                return Gap.new(:name => "GAP", :dtstart=>dtstart, :dtend=>dtend)
            when "emission" then
                id = bc.attributes["id"]
                if bc.structure.respond_to?("segments") then
                    st = bc.structure.segments.map {|x| Segment.load_ar(x)}
                end
                return Emission.new(:id => id, :name=>name, :dtstart=>dtstart, :dtend=>dtend, :structure=>st)
            when "repetition" then
                id = bc.attributes["id"]
                if bc.structure.respond_to?("segments") then
                    st = bc.structure.segments.map {|x| Segment.load_ar(x)}
                else
                    st = []
                end
                return Repetition.new(:id => id, :name=>name, :dtstart=>dtstart, :dtend=>dtend, :structure=>st)
            end
        rescue => e
            puts "ups"
            p e.message
            p e.backtrace
            #TODO
        end
    end

    def deliver(segment_id)
        partial_uri = structure[segment_id].asset.retrieval_uri
        
        bc = get_remote_broadcast

        remote_segment_id = bc.structure.segments[segment_id].id
        
        bc.put(:delivery, "single[asset_service_id]"=> 1,
               "single[partial_retrieval_uri]"=> partial_uri, 
               :segment => remote_segment_id)
    end

    def get_remote_broadcast()
        url = element_path << ".xml"
        bc = Middleware::Broadcast.find(:one, :from=>url)
        if not bc.prefix_options.has_key? :program_id
            bc.prefix_options[:program_id] = @name
        end
        return bc
    end

    def element_path
        "/programs/#{@name}/broadcasts/" << 
        @dtstart.strftime("%Y/%m/%d") <<
        "/#{@id}"
    end
        
        
end
