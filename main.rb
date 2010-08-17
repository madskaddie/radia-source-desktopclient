#!/usr/bin/env ruby1.8


require 'config'

#$slots = %w"alfa beta gamma delta epsilon eta zeta qui psi".map { |x| Slot.new(x)}

def fetch()
    #$slots
    Middleware.fetch.map {|x| Broadcast.load_ar(x)}
end

module Ui
    class Main < Qt::MainWindow
        def initialize(debug=nil)
            super
            @base = MainWindow.new
            @base.setupUi self
            config
            show
        end

        def config

            fsm = Qt::FileSystemModel.new(self)
            fsm.rootPath = Qt::Dir.current_path
            @base.file_manager.model = fsm
            @base.file_manager.CurrentIndex = fsm.index Qt::Dir.current_path

            schedule =  SchedulerListModel.new(fetch, self)
            @base.scheduler_list.model = schedule
            connect(@base.scheduler_list, SIGNAL('doubleClicked(QModelIndex)'), schedule, SLOT('run_edit_form(QModelIndex)'))
            
        end
    end
end


if $0.eql? __FILE__
    a = Qt::Application.new(ARGV) 

    Ui::Main.new()
    a.exec()
end

exit 0

class  MainWindow < Qt::MainWindow
    def initialize()
        super()

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




exit 0
