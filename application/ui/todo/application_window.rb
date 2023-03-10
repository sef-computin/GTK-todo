module Todo
  require_relative "#{Dir.pwd}/application/models/item.rb" 
  #require_relative "#{Dir.pwd}/application/ui/item_list_box_row.rb" 
  
    class ApplicationWindow < Gtk::ApplicationWindow
      # Register the class in the GLib world
      type_register
  
      class << self
        def init
          # Set the template from the resources binary
          set_template resource: '/com/sef-computin/gtk-todo/ui/application_window.ui'

          bind_template_child 'add_new_item_btn'
          bind_template_child 'todo_items_listbox'
        end
      end
  
      def initialize(application)
        super application: application
  
        set_title 'GTK+ Simple ToDo'

        add_new_item_btn.signal_connect 'clicked' do |button|
          new_item_window = NewItemWindow.new(application, Todo::Item.new(user_data_path: application.user_data_path))
          new_item_window.present
        end

        load_todo_items
      end

      def load_todo_items
        todo_items_listbox.children.each { |child| todo_items_listbox.remove child }

        json_files = Dir[File.join(File.expand_path(application.user_data_path), '*.json')]
        items = json_files.map{ |filename| Todo::Item.new(filename: filename) }

        items.each do |item|
        todo_items_listbox.add Todo::ItemListBoxRow.new(item)
        end
      end

    end
  end
  