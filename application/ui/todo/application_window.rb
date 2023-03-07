module Todo
  require_relative "#{Dir.pwd}/application/models/item.rb" 
  
    class ApplicationWindow < Gtk::ApplicationWindow
      # Register the class in the GLib world
      type_register
  
      class << self
        def init
          # Set the template from the resources binary
          set_template resource: '/com/sef-computin/gtk-todo/ui/application_window.ui'

          bind_template_child 'add_new_item_btn'
        end
      end
  
      def initialize(application)
        super application: application
  
        set_title 'GTK+ Simple ToDo'

        add_new_item_btn.signal_connect 'clicked' do |button|
          new_item_window = NewItemWindow.new(application, Todo::Item.new(user_data_path: application.user_data_path))
          new_item_window.present
        end
      end
    end
  end
  