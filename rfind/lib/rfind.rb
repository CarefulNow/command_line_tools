#!/usr/bin/env ruby

require 'rubygems'
require 'optparse'
require 'find'
require 'paint'

class RFind 

	params = {}
	options = OptionParser.new do |x|
    	x.banner = 'rfind <options> <file> <startPath>'      
    	x.separator ''

      	x.on("-v", "--verbose", "Gives verbose output from program") { params[:verbose] = :true }
      	
      	x.on("-h", "--help", "Lists all options") { puts options; exit }   
    end

    options.parse!(ARGV)

    puts params


    fileName = ARGV[0].to_s()
    if ARGV[1] == nil
	    startPath = '/'
	else
		startPath = ARGV[1].to_s()
	end

    puts fileName 
    puts startPath


	filePaths = []
	Find.find(startPath) do |path|
		#
		if path.start_with?('/dev')
      		Find.prune       # Don't look any further into this directory.
    	end
		if path =~ /#{fileName}/
			filePaths << path 
			puts Paint[path, :green, :bright]
		elsif params[:verbose] == :true
			puts Paint[path, :red, :bright]
		end
	end

	#Ruby adds ["array stuff"] around arrays with to_s() which is annoying to look at
	#join("\n") puts a newline inbetween each element of the array and converts to a string
	puts Paint[filePaths.join("\n"), :green, :bright] if params[:verbose] == :true

end
