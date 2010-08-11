
class Gap < Broadcast
    def url()
        return " -> Gap"
    end

    def url=(s)
        return nil
    end

    def css()
        { "background-color" => "white", "color" => "#5F4A47" }
    end
end
