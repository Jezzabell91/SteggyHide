require_relative 'classes/start_page.rb'

steggy_start = Start_Page.new(:title => "SteggyHide",
    :creator => "Jeremy Bell",
    :source => "github.com/steggyhide",
    :version => "0.10"
)

def main_menu
    prompt = TTY::Prompt.new
    case prompt.select("What would you like to do?", cycle: true) do |menu|
        # For ordered choices set enum to any delimiter String. 
        # In that way, you can use arrows keys and numbers (0-9) to select the item.
        menu.enum "."
        
        menu.choice "Hide a message in an image", 1
        menu.choice "Find a message in an image", 2
        menu.choice "Batch check images for hidden messages", 3
        menu.choice "Open help documentations", 4
        menu.choice "Exit!", 5
        end
    when 1
        system "clear"
        puts "What is the image filepath?" 
    when 2
        system "clear"
        puts "What is the image filepath?" 
    when 3
        system "clear"
        puts "What is the directory filepath?" 
    when 4
        system "clear"
        puts "Opening documentations"        
    when 5
        system "clear"
        puts "Exiting"
        exit
    end
end

steggy_start.print_start_page
main_menu