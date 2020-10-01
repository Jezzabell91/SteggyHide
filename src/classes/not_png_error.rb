class NotPngError < StandardError
    def initialize(msg="File is not .png filetype")
        super(msg)
    end
end