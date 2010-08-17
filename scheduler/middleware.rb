
module Middleware
    require 'rubygems'
    require 'active_resource'

    def self.fetch
        bcs = Schedule::find(:one, :from => '/schedule.xml').broadcasts
        return bcs
    end

    def self.fetch_single id
        begin
            Single::find(:one, :from => "/audio/singles/#{id}.xml")
        rescue
            nil
        end
    end

    class Schedule < ActiveResource::Base
        self.site = $config[:scheduler_uri]
        self.element_name = "schedule"
    end

    class Broadcast < ActiveResource::Base
        self.site = $config[:scheduler_uri]
        self.prefix="/programs/:program_id/"
        
        # def self.element_path(id, prefix_options = {}, query_options = nil)
        #     prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        #     "#{prefix(prefix_options)}#{collection_name}/#{id}.#{format.extension}#{query_string(query_options)}"
        # end

        def element_path(options = nil)
            d = dtstart.localtime.strftime("%Y/%m/%d/#{id}")
            self.class.element_path(d, options || prefix_options)
        end

        def custom_method_element_url(method_name, options = {})
            "#{self.class.prefix(prefix_options)}#{self.class.collection_name}/"<<
            dtstart.localtime.strftime("%Y/%m/%d/") << "#{id}/#{method_name}.xml#{self.class.send(:query_string, options)}"
        end


    end

    class Bloc < ActiveResource::Base
        self.site = ''
    end

    class Structure < ActiveResource::Base
        self.site = ''
    end

    class Segment < ActiveResource::Base
        self.site = ''
    end

    class Single < ActiveResource::Base
        self.site = $config[:scheduler_uri] << "/audio/"
        self.element_name = "single"
    end
end
