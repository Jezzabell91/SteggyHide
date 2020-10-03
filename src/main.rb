require_relative 'help.rb'
require_relative 'classes/start_page.rb'
require_relative 'methods/steg_methods.rb'
require_relative 'methods/font_methods.rb'


steggy_start = Start_Page.new(:title => "SteggyHide",
    :creator => "Jeremy Bell",
    :source => "github.com/steggyhide",
    :version => "0.10"
)

def process_argv
    case ARGV[0]
    when "-hex"
        argv_convert_hex_to_rgb
        exit
    end

end

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
        print_help       
    when 5
        exit_app
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


def conversion_feature
    system "clear"
    puts header_style("CONVERSION TOOLS")
    prompt = TTY::Prompt.new
    case prompt.select("What conversion would you like to do?", cycle: true) do |menu|
        # For ordered choices set enum to any delimiter String. 
        # In that way, you can use arrows keys and numbers (0-9) to select the item.
        menu.enum "."
        
        menu.choice "String to binary", 1
        menu.choice "Binary to string", 2
        menu.choice "Hexadecimal to RGB", 3
        menu.choice "RGB to hexadecimal", 4
        menu.choice "Return to main menu", 5
        end
    when 1
        system "clear"
        convert_string_to_binary
    when 2
        system "clear"
        convert_binary_to_string
    when 3
        system "clear"
        convert_hex_to_rgb
    when 4
        system "clear"
        convert_rgb_to_hex        
    when 5
        system "clear"
        return_to_menu
    end
end

process_argv
steggy_start.print_start_page
main_menu