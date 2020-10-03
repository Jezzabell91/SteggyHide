class NotRgbError < StandardError
    def initialize(msg="Please input a value between 0 and 255")
        super(msg)
    end
end
