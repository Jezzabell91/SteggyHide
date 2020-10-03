class StringTooBig < StandardError

    def initialize(msg="The size of the string is too large for SteggyHide to handle.")
        super(msg)
    end
end