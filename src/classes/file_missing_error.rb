class FileMissing < StandardError
    def initialize(msg="File not found, sorry")
        super(msg)
    end
end