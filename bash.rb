# ßencoding: UTF-8
class ExampleApp

	@@commands  = {'ls' => 'Displays files in the directory', 'cd directory' => 'Changes the current directory to directory', 'mkdir foldername' => 'Makes a new directory from the name provided', 'quit || exit' => 'Exits the program', 'info' => 'Gives info on the program creator'}
	@@directory = Dir.pwd

	def setup
	  get_response
	  puts ''
    end

	def user_input
		print @@directory + ': '
		gets.chomp
	end

	def get_response
	 @response = user_input
	 parse_response(@response)
	end

	def parse_response response=''
	  action = case response
	    when 'ls'      then input_ls
	    when /^(cd)/    then input_cd(response)
	    when 'quit'    then input_quit
	    when 'exit'    then input_quit
	    when 'help'    then input_help
	    when 'info'	   then input_info
	    when /^(mkdir)/ then input_mkdir(response)
	    else input_ls
	  end
	end

	private

	def input_ls
	  Dir.entries(Dir.pwd).each do |file_name|
	    puts file_name
	  end
	  get_response
	end

	def input_cd response=''
		response = response.sub('cd', '').sub(' ', '')
	  begin 
	  	Dir.chdir(response) 
        @@directory = Dir.pwd
      rescue 
      	puts 'Directory not found.'
      end
      get_response
	end

	def input_quit
	  puts 'Exiting the program...'
	  exit
    end

    def input_help
      @@commands.each do |k,v|
        puts "#{k}: #{v}"
      end
      get_response
    end

    def input_info
      puts 'This program was written by Verdi Ergün (verdiergun.com) copyright 2013.'
      get_response
    end

    def input_mkdir response=nil
      begin  
    	response = response.sub('mkdir', '').sub(' ', '')
    	Dir.mkdir(response)
      rescue
    	puts 'Please provide a directory name.'
      end
      get_response
    end

class FileStuff

	def self.open_file response=''
	  File.readlines(response)
	end

	def self.process_file
	 begin 
	 	@lines = open_file(@response)
	    parse_response(get_response)
	 rescue 
	 	puts 'File not found. Try again.'
	 	ExampleApp.new.setup
	 end
	end

end

class GenericStuff

	def self.header
	 puts 'Type "help" to see a list of commands'
	end

end

   public

end

ExampleApp::GenericStuff.header
ExampleApp.new.setup

