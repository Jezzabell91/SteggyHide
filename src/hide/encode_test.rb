string = "01100001"





def encode(hex, digit)
    hex = hex.delete_prefix("#")
    # return hex[-1]
    if hex[-1] == "0" || hex[-1] == "1" || hex[-1] == "2" || hex[-1] == "3" || hex[-1] == "4" || hex[-1] == "5"
        hex[-1] = digit
        return hex[-1]
    else 
        return hex[-1]
    end
end

hex_data = 
["f7f7f7", "f7f7f7", "f7f7f7", "f7f7f7", "f7fbfb", "f7fdfd", "f7f7f7", "f7f7f7", "f7f7f7", "f7fdfd", "f8fefe", "da2d31", "f7f7f7", 
"f7f7f7", "f8fefe", "f7f9f9", "d92d31", "da2d31", "f7f7f7", "f8fffe", "f6f5f5", "d9292d", "da2e32", "db3438", "f8ffff", "f5eff0", "d82529", 
"da2f33", "db3438", "db3438", "f4e9e9", "d82226", "da2f34", "db3438", "db3438", "da2f33", "e47073", "d82428", "db3337", "db3438", "d9292e", 
"e15a5d", "eda7a9", "e25d60", "d9282c", "d9292d", "e05659", "f1b8ba", "ec9d9f", "eb9496", "e15a5d", "e05356", "f1b8ba", "efa8aa", "ec9d9f", 
"e88284", "efacae", "f5cbcc", "eea2a4", "eea7a9", "ea9697", "efa6a8", "f7d5d7", "f6d0d2", "f3c0c2", "eea2a4", "f1bcbd", "f7d3d5", "f6cdcf", 
"f6cdcf", "f6d0d2", "f3c0c1"]

p hex_data.size

hex_last_array = []



hex_data.each do |hex|
    hex_last_array << encode(hex, "1")
end

p hex_last_array