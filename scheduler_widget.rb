
require 'Qt4'


class Slot
    attr_accessor :name, :dtstart, :dtend, :url
    def initialize(name, dtstart=Time.now, dtend=Time.now, url=nil)
        @name = name
        @dtstart = dtstart
        @dtend = dtend
        @url = url
    end
end

class BroadcastWidget < Qt::Widget
        def initialize(slot, parent=nil)
            super(parent)

            @slot = slot
            @label = Qt::Label.new(to_lbl, parent=self)

            @vbox = Qt::VBoxLayout.new(self)
            #@vbox.setContentsMargins(0, 0, 0, 0)

            @vbox.addWidget(@label)
            setLayout(@vbox)
            self.setStyleSheet(broadcast_css(slot.css))

            if @slot.kind_of? Emission then
                setAcceptDrops true
            else
                enabled = false
            end
        end
        
        def self.fromSlot(slot, parent=nil)
                BroadcastWidget.new(slot, parent)
        end

        protected

        def broadcast_css(css)
            s = "QLabel {margin:0px;border: 2px solid #111111; border-radius:8px;"
            s =  css.map{|x,y| " #{x}:#{y};" }.reduce(s){|all, str| all+str}
            return s + " }"
        end

        def to_lbl
                return "Program #{@slot.name}\n#{@slot.dtstart} | #{@slot.dtend}\nUrl:#{@slot.url}"
        end

        def update_label(&block)
                yield
                @label.text = to_lbl
        end

        def dragEnterEvent(ev)
                ev.acceptProposedAction()
        end

        def dropEvent(ev)
                t = ev.source
                
                # Check if we are comming from a treeview drag
                return if not t.class.to_s.eql?("Qt::TreeView")
               
                row = t.currentIndex.row()
                index = t.currentIndex.sibling(row, 0)
                update_label { @slot.url = t.model.fileName(index) }
        end

        def mouseDoubleClickEvent(ev)
            if @slot.kind_of? Emission then
                BroadcastForm.new(@slot)
            end
        end

end


# SchedulerWidget has three hierarical levels:
#  - group (top level, sub-classed)
#  - scroll
#  - The widget itself
class SchedulerWidet < Qt::GroupBox
        def initialize(title,parent=nil)
                super(parent)
                
                self.title = title

                @slots_widget = Qt::Widget.new(parent=self)
                @slots_layout = Qt::VBoxLayout.new
                @slots_layout.spacing = 0
                @slots_widget.setLayout(@slots_layout)

                @vbox = Qt::VBoxLayout.new
                @scroll = Qt::ScrollArea.new()
                @scroll.setWidget(@slots_widget)
                #@scroll.setHorizontalScrollBarPolicy(1)

                #@vbox.addWidget(@scroll)
                    @vbox.addWidget(@slots_widget)

                setLayout(@vbox)

                
        end

        def set_slots(slots)
                update_scroll do
                    puts slots
                    delete_items()
                    slots.each { |x| @slots_layout.addWidget(BroadcastWidget.new(x)) }
                    self.update
                    @slots_widget.update
                    @slots_widget.show
                end
        end

        protected

        def delete_items()
                tmp=@slots_layout.takeAt(0)
                while not tmp.nil? 

                        #must test for nil because stretches aren't widgets
                        if not tmp.widget.nil?
                                # must hide widget to prevent drawing memory
                                tmp.widget.hide
                                tmp.widget.destroy
                        end
                        tmp=@slots_layout.takeAt(0)
                end
        end

        # The update_scroll method is need whenever the widget labels are
        # added or removed
        def update_scroll(&block)
                yield
                if @scroll.widget
                    @scroll.takeWidget
                    @slots_widget.show
                    @scroll.setWidget(@slots_widget)
                end
        end
end


# EOF

