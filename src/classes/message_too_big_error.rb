class MessageTooBig < StandardError
    def initialize(msg="The size of the message exceeds the number of pixels")
        super(msg)
    end
end