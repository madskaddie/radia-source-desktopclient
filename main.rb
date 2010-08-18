#!/usr/bin/env ruby1.8


require 'thread'
require 'config'

#$slots = %w"alfa beta gamma delta epsilon eta zeta qui psi".map { |x| Slot.new(x)}

def fetch()
    #$slots
    Middleware.fetch.map {|x| Broadcast.load_ar(x)}
end


class Main < Qt::MainWindow
    def initialize(debug=nil)
        super
        @queue = Queue.new
        @base = Ui::MainWindow.new
        @base.setupUi self
        reconfig_ui
        show

        fetch_proc = Proc.new do 
            fetch.each {|x| @schedule.append_broadcast x }
        end
        @queue << [fetch_proc, {}]

        Thread.new do
            while true
                code,args = @queue.pop
                code.call(args)
            end
        end

        ugly_hack = Qt::Timer.new do
            connect(SIGNAL :timeout) do
                sleep(0.1)
            end
        end
        ugly_hack.start(0)
    end

    def reconfig_ui
        fsm = Qt::FileSystemModel.new(self)
        fsm.rootPath = Qt::Dir.current_path
        @base.file_manager.model = fsm
        @base.file_manager.CurrentIndex = fsm.index Qt::Dir.current_path

        @schedule =  SchedulerListModel.new(parent=self)
        @base.scheduler_list.model = @schedule
        connect(@base.scheduler_list, SIGNAL('doubleClicked(QModelIndex)'), @schedule, SLOT('run_edit_form(QModelIndex)'))

    end
end


if $0.eql? __FILE__
    a = Qt::Application.new(ARGV) 

    Main.new()
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
