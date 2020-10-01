# ls = `ls`
# cd = `cd`

# puts ls


# def commands(cmd)
#     return `#{cmd}`
# end

# loop do
#     input = gets.chomp
#     puts commands(input)
# end

def list_png
    puts "PNG Files in:  " + "#{`pwd`}"
    puts `ls *.png`
end

list_png
