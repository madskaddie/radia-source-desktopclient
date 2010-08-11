
class BCStructure < Qt::AbstractItemModel
#class BCStructure < Qt::AbstractListModel
    def initialize(broadcast, parent = 0)
        super()
        @broadcast = broadcast
    end

    def rowCount(parent)
        if not parent.isValid
            return @broadcast.structure.length
        else
            return parent.internalPointer.length
        end

    end

    def columnCount(parent)
        #return 1 if not parent.isValid
        return 2 if parent.kind_of? Playlist
        return 1
    end

    def index(row, col, parent)
        return Qt::ModelIndex.new if not hasIndex(row, col, parent)

        if not parent.isValid() then
            parent_item = @broadcast.structure
        else
            parent_item = parent.internalPointer
        end

        child = parent_item[row]

        if child.nil? then
            Qt::ModelIndex.new()
        else
            createIndex(row, col, child)
        end
    end

    def parent(index)
        return Qt::ModelIndex.new if not index.isValid
        
        child_item = index.internalPointer
        parent = nil
        @broadcast.structure.each do |x|
            tmp = x.asset.select { |ch| child_item.eql? ch}
            if not tmp.empty? then
                parent = tmp[0]
                break
            end
        end

        if parent.nil?
            return Qt::ModelIndex.new
        end
        return createIndex(parent.row(), 0, parent)
    end


    def data(index, role)
        return Qt::Variant.new if not index.isValid()
        #return Qt::Variant.new if index.row >= 1

        if role == Qt::DisplayRole then
            asset = @broadcast.structure[index.row].asset
            return Qt::Variant.new(asset.label)
        else
            return Qt::Variant.new
        end
        return 
    end
end

class BroadcastForm < Qt::Widget
        def initialize(broadcast)
                super()
                self.parent = nil
                
                #Buttons configuration
                bOK= Qt::PushButton.new("OK")
                bCC= Qt::PushButton.new("Cancel")
                bb = Qt::DialogButtonBox.new(Qt::Horizontal)
                bb.addButton(bOK,Qt::DialogButtonBox::ActionRole)
                bb.addButton(bCC, Qt::DialogButtonBox::RejectRole)

                lt = Qt::FormLayout.new
                #List Configuration
                @structure = BCStructure.new(broadcast)
                @structure_view = Qt::ListView.new
                @structure_view.model = @structure


                lt.addRow("Show:", Qt::Label.new(broadcast.name.to_s))
                lt.addRow("Date Start:", Qt::Label.new(broadcast.dtstart.to_s))
                lt.addRow("Date End:", Qt::Label.new(broadcast.dtend.to_s))
                lt.addRow("Structure:", @structure_view)
                lt.addRow("", bb)

                setLayout(lt)
                show()

        end

end
