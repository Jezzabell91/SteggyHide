class ArgumentMissing < StandardError
    def initialize(msg="There was an argument missing. Command line arguments cannot begin with #")
        super(msg)
    end
end