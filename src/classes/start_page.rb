require 'tty-prompt'
require 'pastel'
require 'tty-font'

class Start_Page
    attr_reader :title, :information, :pastel, :font, :prompt

    def initialize(args)
        @title = args[:title]
        @information = "Creator: #{args[:creator]}  Source: #{args[:source]}  Version: #{args[:version]}"
        @pastel = Pastel.new
        @font = TTY::Font.new(:standard)
        @prompt = TTY::Prompt.new
    end 

    def print_start_page
        system "clear"
        puts information
        puts pastel.cyan(font.write("#{title}"))
        ascii_art
        press_any_key
    end

    def ascii_art
        puts pastel.green("                          .       .")
        puts pastel.green("                         / `.   .' \\\"")
        puts pastel.green("                 .---.  <    > <    >  .---.")
        puts pastel.green("      / \\        |    \\  \\ - ~ ~ - /  /    |")
        puts pastel.green("     /   \\        \\ ..-~             ~-..-~")
        puts pastel.green("    /     \\   \\~~~\\.'                    `./~~~/")
        puts pastel.green("  -----------  \\__/                        \\__/")
        puts pastel.green("   /(O - O)-\\     /                       \\  \"")
        puts pastel.green("  /   ..      \\   \\                        \\ ")
        puts pastel.green("  |  \\__/      `._.'                         }\\/~~~/")
        puts pastel.green("   `----.                 }     |        /    \\__/")
        puts pastel.green("        `-.      |       /      |       /      `. ,~~|")
        puts pastel.green("            ~-.__|      /_ - ~ ^|      /- _      `..-'")
        puts pastel.green("                 |     /        |     /     ~-.     `-. _  _  _")
        puts pastel.green("                 |_____|        |_____|         ~ - . _ _ _ _ _ >")
    end

    def press_any_key
        prompt.keypress("\nPress any key to continue")
        system "clear"
        # Enter main loop from here
    end

end

# example = Start_Page.new(:title => "SteggyHide",
#     :title_colour => "cyan",
#     :creator => "Jeremy Bell",
#     :source => "github.com/steggyhide",
#     :version => "0.10"
# )

# example.print_start_page