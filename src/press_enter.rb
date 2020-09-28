require 'tty-prompt'
prompt = TTY::Prompt.new


    # puts "\nPress any key to continue"
    # # prompt.keypress("\nPress any key to continue")
    # prompt.on(:keypress) do |event|
    #     prompt.trigger(system("clear"))
    #     puts "Thank you"
    # end
    prompt.keypress("Press any key to continue")
    system "clear"
    # Enter main loop 
