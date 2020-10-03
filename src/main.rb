require_relative 'classes/start_page.rb'
require_relative 'methods/steg_methods.rb'
require_relative 'methods/font_methods.rb'

steggy_start = Start_Page.new(:title => "SteggyHide",
    :creator => "Jeremy Bell",
    :source => "github.com/steggyhide",
    :version => "0.10"
)


def main_menu
    system "clear"
    prompt = TTY::Prompt.new
    case prompt.select("What would you like to do?", cycle: true) do |menu|
        # For ordered choices set enum to any delimiter String. 
        # In that way, you can use arrows keys and numbers (0-9) to select the item.
        menu.enum "."
        
        menu.choice "Hide a message in an image", 1
        menu.choice "Find a message in an image", 2
        menu.choice "Conversion Utility Tools", 3
        menu.choice "Open help documentations", 4
        menu.choice "Exit!", 5
        end
    when 1
        system "clear"
        hide_feature
    when 2
        system "clear"
        find_feature
    when 3
        system "clear"
        conversion_feature
    when 4
        system "clear"
        puts "Opening documentations"        
    when 5
        system "clear"
        puts "Exiting"
        exit
    end
end

def hide_feature
    system "clear"
    puts header_style("HIDE")
    list_prompt
    path = get_filepath
    message = get_message
    hide(message, path)
end

def find_feature
    system "clear"
    puts header_style("FIND")
    list_prompt
    path = get_filepath
    find(path)
end

def conversion_tools
    system "clear"
    header_style("CONVERSION TOOLS")

end

steggy_start.print_start_page
main_menu