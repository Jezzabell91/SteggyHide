class NotBinaryError < StandardError
    def initialize(msg="Please binary only. That means '1's and '0' only")
        super(msg)
    end
end