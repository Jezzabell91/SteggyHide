require 'tty-prompt'
require 'pastel'
require 'tty-font'



font = TTY::Font.new(:standard)
pastel = Pastel.new
prompt = TTY::Prompt.new

def title(pastel, font)
    puts pastel.cyan(font.write("SteggyHide"))
end

def steggy(pastel)
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

def information
    puts "\n Creator: Jeremy Bell  Source: github.com/steggyhide  Version: 0.10"
end

def press_any_key(prompt)
    puts "\nPress any key to continue"
    # prompt.keypress("\nPress any key to continue")
    prompt.on(:keypress) do |event|
        prompt.trigger(system("clear"))
        puts "Thank you"
    end
end

title(pastel, font)
steggy(pastel)
press_any_key(prompt)
information