require_relative 'classes/start_page.rb'

steggy_start = Start_Page.new(:title => "SteggyHide",
    :title_colour => "cyan",
    :creator => "Jeremy Bell",
    :source => "github.com/steggyhide",
    :version => "0.10"
)

steggy_start.print_start_page