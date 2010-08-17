
class  SchedulerListModel < Qt::AbstractListModel

    slots 'run_edit_form(QModelIndex)'

    def initialize(schedule=[], parent=nil)
        super(parent)
        @schedule = schedule
        supported_drag_actions = Qt::ActionMask
    end

    def rowCount(parent=Qt::ModelIndex.new)
        return @schedule.length
    end

    def data(index,role)
        return Qt::Variant.new if not index.isValid()

        if role == Qt::DisplayRole then
            bc = @schedule[index.row]
            s = "Program #{bc.name}\n#{bc.dtstart} | #{bc.dtend}\nUrl:#{bc.url}"
            return Qt::Variant.new(s)
        else
            return Qt::Variant.new
        end

    end

    def flags(idx)
        return  Qt::NoItemFlags if not idx.isValid()

        return Qt::ItemIsSelectable | Qt::ItemIsEnabled |Qt::ItemIsDropEnabled 
    end

    def mimeTypes()
        return ["text/uri-list"]
    end

    def dropMimeData(data, action, row,col, parent)
        
        return false if not data.has_format "text/uri-list"

        decoded_data = data.data("text/uri-list").to_s.strip
        broadcast = @schedule[parent.row]

        broadcast.url = decoded_data.split("/")[-1]

        return true
    end

    def supportedDragActions()
        return Qt::CopyAction | Qt::MoveAction;
    end

    def run_edit_form(parent)
        return if not parent.is_valid
        broadcast = @schedule[parent.row]
        BroadcastForm.new(broadcast) if broadcast.kind_of? Emission
    end
end
