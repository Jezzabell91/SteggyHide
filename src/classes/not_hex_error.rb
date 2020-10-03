class NotHexError < StandardError
    def initialize(msg="Please input a valid hexadecimal value. Value should be between 3-6 digits.")
        super(msg)
    end
end
