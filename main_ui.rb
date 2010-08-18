=begin
** Form generated from reading ui file 'main.ui'
**
** Created: Wed Aug 18 01:56:02 2010
**      by: Qt User Interface Compiler version 4.6.2
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_MainWindow
    attr_reader :centralwidget
    attr_reader :horizontalLayout_2
    attr_reader :groupBox
    attr_reader :verticalLayout_4
    attr_reader :scheduler_list
    attr_reader :statusbar
    attr_reader :dockWidget
    attr_reader :dockWidgetContents
    attr_reader :verticalLayout
    attr_reader :toolBox
    attr_reader :page
    attr_reader :verticalLayout_2
    attr_reader :file_manager
    attr_reader :page_2
    attr_reader :verticalLayout_3
    attr_reader :calendarWidget
    attr_reader :buttonBox

    def setupUi(mainWindow)
    if mainWindow.objectName.nil?
        mainWindow.objectName = "mainWindow"
    end
    mainWindow.resize(617, 350)
    mainWindow.autoFillBackground = false
    mainWindow.styleSheet = "border-top-color: rgb(0, 0, 0);"
    @centralwidget = Qt::Widget.new(mainWindow)
    @centralwidget.objectName = "centralwidget"
    @horizontalLayout_2 = Qt::HBoxLayout.new(@centralwidget)
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @groupBox = Qt::GroupBox.new(@centralwidget)
    @groupBox.objectName = "groupBox"
    @sizePolicy = Qt::SizePolicy.new(Qt::SizePolicy::Preferred, Qt::SizePolicy::Preferred)
    @sizePolicy.setHorizontalStretch(0)
    @sizePolicy.setVerticalStretch(0)
    @sizePolicy.heightForWidth = @groupBox.sizePolicy.hasHeightForWidth
    @groupBox.sizePolicy = @sizePolicy
    @groupBox.alignment = Qt::AlignLeading|Qt::AlignLeft|Qt::AlignTop
    @groupBox.flat = true
    @groupBox.checkable = false
    @verticalLayout_4 = Qt::VBoxLayout.new(@groupBox)
    @verticalLayout_4.objectName = "verticalLayout_4"
    @verticalLayout_4.setContentsMargins(4, 4, -1, -1)
    @scheduler_list = Qt::ListView.new(@groupBox)
    @scheduler_list.objectName = "scheduler_list"
    @sizePolicy1 = Qt::SizePolicy.new(Qt::SizePolicy::Expanding, Qt::SizePolicy::Expanding)
    @sizePolicy1.setHorizontalStretch(0)
    @sizePolicy1.setVerticalStretch(0)
    @sizePolicy1.heightForWidth = @scheduler_list.sizePolicy.hasHeightForWidth
    @scheduler_list.sizePolicy = @sizePolicy1
    @scheduler_list.acceptDrops = true
    @scheduler_list.styleSheet = "QListView::item {\n" \
"  border-style: solid;\n" \
"  border-width: 1px;\n" \
"  border-radius: 4px;\n" \
"  border-color: #111;\n" \
"}"
    @scheduler_list.dragEnabled = true
    @scheduler_list.dragDropMode = Qt::AbstractItemView::DropOnly
    @scheduler_list.defaultDropAction = Qt::LinkAction

    @verticalLayout_4.addWidget(@scheduler_list)


    @horizontalLayout_2.addWidget(@groupBox)

    mainWindow.centralWidget = @centralwidget
    @statusbar = Qt::StatusBar.new(mainWindow)
    @statusbar.objectName = "statusbar"
    @statusbar.sizeGripEnabled = true
    mainWindow.statusBar = @statusbar
    @dockWidget = Qt::DockWidget.new(mainWindow)
    @dockWidget.objectName = "dockWidget"
    @dockWidget.features = Qt::DockWidget::DockWidgetFloatable|Qt::DockWidget::DockWidgetMovable
    @dockWidget.allowedAreas = Qt::LeftDockWidgetArea|Qt::RightDockWidgetArea
    @dockWidgetContents = Qt::Widget.new(@dockWidget)
    @dockWidgetContents.objectName = "dockWidgetContents"
    @verticalLayout = Qt::VBoxLayout.new(@dockWidgetContents)
    @verticalLayout.objectName = "verticalLayout"
    @verticalLayout.setContentsMargins(0, 0, 0, 0)
    @toolBox = Qt::ToolBox.new(@dockWidgetContents)
    @toolBox.objectName = "toolBox"
    @page = Qt::Widget.new()
    @page.objectName = "page"
    @page.geometry = Qt::Rect.new(0, 0, 274, 223)
    @verticalLayout_2 = Qt::VBoxLayout.new(@page)
    @verticalLayout_2.objectName = "verticalLayout_2"
    @file_manager = Qt::TreeView.new(@page)
    @file_manager.objectName = "file_manager"
    @file_manager.dragEnabled = true

    @verticalLayout_2.addWidget(@file_manager)

    @toolBox.addItem(@page, Qt::Application.translate("MainWindow", "Local Audio Assets", nil, Qt::Application::UnicodeUTF8))
    @page_2 = Qt::Widget.new()
    @page_2.objectName = "page_2"
    @page_2.geometry = Qt::Rect.new(0, 0, 298, 223)
    @verticalLayout_3 = Qt::VBoxLayout.new(@page_2)
    @verticalLayout_3.objectName = "verticalLayout_3"
    @calendarWidget = Qt::CalendarWidget.new(@page_2)
    @calendarWidget.objectName = "calendarWidget"

    @verticalLayout_3.addWidget(@calendarWidget)

    @buttonBox = Qt::DialogButtonBox.new(@page_2)
    @buttonBox.objectName = "buttonBox"
    @buttonBox.standardButtons = Qt::DialogButtonBox::Reset
    @buttonBox.centerButtons = true

    @verticalLayout_3.addWidget(@buttonBox)

    @toolBox.addItem(@page_2, Qt::Application.translate("MainWindow", "Calendar", nil, Qt::Application::UnicodeUTF8))

    @verticalLayout.addWidget(@toolBox)

    @dockWidget.setWidget(@dockWidgetContents)
    mainWindow.addDockWidget((2), @dockWidget)
    Qt::Widget.setTabOrder(@scheduler_list, @file_manager)
    Qt::Widget.setTabOrder(@file_manager, @calendarWidget)
    Qt::Widget.setTabOrder(@calendarWidget, @buttonBox)

    retranslateUi(mainWindow)

    @toolBox.setCurrentIndex(0)


    Qt::MetaObject.connectSlotsByName(mainWindow)
    end # setupUi

    def setup_ui(mainWindow)
        setupUi(mainWindow)
    end

    def retranslateUi(mainWindow)
    mainWindow.windowTitle = Qt::Application.translate("MainWindow", "Radia Source", nil, Qt::Application::UnicodeUTF8)
    @groupBox.title = Qt::Application.translate("MainWindow", "Schedule", nil, Qt::Application::UnicodeUTF8)
    @dockWidget.windowTitle = ''
    @toolBox.setItemText(@toolBox.indexOf(@page), Qt::Application.translate("MainWindow", "Local Audio Assets", nil, Qt::Application::UnicodeUTF8))
    @toolBox.setItemText(@toolBox.indexOf(@page_2), Qt::Application.translate("MainWindow", "Calendar", nil, Qt::Application::UnicodeUTF8))
    end # retranslateUi

    def retranslate_ui(mainWindow)
        retranslateUi(mainWindow)
    end

end

module Ui
    class MainWindow < Ui_MainWindow
    end
end  # module Ui

