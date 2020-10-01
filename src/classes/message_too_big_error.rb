class MessageTooBig < StandardError
    # attr_reader :msg

    def initialize(msg="The size of the message exceeds the number of pixels")
        super(msg)
    end
end