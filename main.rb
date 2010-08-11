#!/usr/bin/env ruby1.8


require 'config'

#$slots = %w"alfa beta gamma delta epsilon eta zeta qui psi".map { |x| Slot.new(x)}

def fetch()
    #$slots
    Middleware.fetch.map {|x| Broadcast.load_ar(x)}
end

class  MainWindow < Qt::MainWindow
    def initialize(debug=nil)
        super()
        window_title = "RS Local client"

        Qt.debug_level = Qt::DebugLevel::High if debug

        fsm = Qt::FileSystemModel.new
        fsm.rootPath = Qt::Dir.current_path
        fsv = Qt::TreeView.new
        fsv.model = fsm
        fsv.CurrentIndex = fsm.index Qt::Dir.current_path
        fsv.DragEnabled = true

        sched_wdg =  SchedulerWidet.new("Schedule", parent=self)

        ugly_hack = Qt::Timer.new do
            connect(SIGNAL :timeout) do
                sleep(0.1)
            end
        end

         Thread.new do
                 begin
                     $slots = fetch()
                     sched_wdg.set_slots($slots)
                     window.statusBar().showMessage("Ready")
                 rescue => e
                     p e.message
                     puts e.backtrace
                     window.statusBar().showMessage("Could not download the schedule.")
                 end
         end


        #ugly_hack.SingleShot = true


        splitter = Qt::Splitter.new
        splitter.addWidget sched_wdg
        splitter.addWidget fsv


        setCentralWidget(splitter)
        ugly_hack.start(0)
        show()
    end



end



if $0.eql?__FILE__
    Qt::Application.new(ARGV) do
        window = MainWindow.new()
        exec()
    end
end

exit 0
