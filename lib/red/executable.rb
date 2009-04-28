module Red # :nodoc:
  def build_red_plugin_for_rails(display_message = true)
    @files ||= ''
    self.make_plugin_directory('vendor/plugins/red', true)
    self.create_plugin_file(:open, 'vendor/plugins/red/init.rb', "require 'rubygems'\nrequire 'red'\n\nRed.rails\n")
    self.make_plugin_directory('public/javascripts/red/lib')
    
    return unless display_message
    puts @files && exit
  end
  
  def make_plugin_directory(dir, only_this_directory = false)
    parent_dir = File.dirname(dir)
    self.make_plugin_directory(parent_dir) unless File.exists?(parent_dir) || only_this_directory
    directory_status = File.exists?(dir) ? 'exists' : Dir.mkdir(dir) && 'create'
    @files << "      %s  %s\n" % [directory_status, dir]
  rescue SystemCallError
    puts "Unable to create directory in #{parent_dir}" && exit
  end
  
  def create_plugin_file(operation, filename, contents)
    file_status = self.check_if_plugin_file_exists(filename)
    case operation
      when :open : File.open(filename, 'w') { |f| f.write(contents) } if file_status == 'create'
      when :copy : File.copy(contents, filename)
    end
    @files << "      %s  %s\n" % [file_status, filename]
  end
  
  def check_if_plugin_file_exists(filename)
    if File.exists?(filename)
      print "File #{filename} exists. Overwrite [yN]? "
      return (gets =~ /y/i ? 'create' : 'exists')
    else
      return 'create'
    end
  end
  
  def direct_translate(string)
    print_js(hush_warnings { string.translate_to_sexp_array }.red!)
    exit
  end
  
  def translate_to_string_including_ruby(string)
    js_output = hush_warnings { string.translate_to_sexp_array }.red!
    ruby_js   = compile_ruby_js_source
    return ruby_js + js_output
  end
  
  def hush_warnings
    $stderr = File.open('spew', 'w')
    output = yield
    $stderr = $>
    File.delete('spew')
    return output
  end
  
  def set_output_file(path)
    @@output_filename = path
  end
  
  def convert_red_file_to_js(filename, dry_run = false)
    unless File.exists?(file = "%s.rb" % [filename]) || File.exists?(file = "%s" % [filename])
      puts "File #{file} does not exist."
      exit
    end
    @@red_filepath = File.dirname(File.expand_path(filename))
    @@red_start_path = @@red_filepath  # change!
    js_output = hush_warnings { File.read(file).translate_to_sexp_array }.red!
    ruby_js   = compile_ruby_js_source
    pre  = Red.debug ? "try{" : ""
    post = Red.debug ? "}catch(e){if(e.__class__){m$raise(e);};$ee=e;var m=e.message.match(/([^\\$]+)\\.m\\$(\\w+)\\sis\\snot\\sa\\sfunction/);if(m){m$raise(c$NoMethodError,$q('undefined method \"'+m[2]+'\" for '+m[1]));};var c=e.message.match(/([\\s\\S]+)\\sis\\sundefined/);if(c){c=c[1].replace(/\\./g,'::').replace(/c\\$/g,'');m$raise(c$NameError,$q('uninitialized constant '+c));};}" : ""
    
    # output_filename = "%s%s.js" % [dir, filename]
    output_filename = @@output_filename
    puts "OUTPUT: #{output_filename}"
    File.open(output_filename, 'w') {|f| f.write(pre + ruby_js + js_output + post)} unless dry_run
    # print_js(js_output, filename, dry_run)
  end
  
  def compile_ruby_js_source
    cache_known_constants = @@red_constants
    @@red_constants = []
    @@red_import = true
    ruby_js = hush_warnings { File.read(File.join(File.dirname(__FILE__), "../source/ruby.rb")).translate_to_sexp_array }.red!
    @@red_constants = cache_known_constants
    @@red_methods = INTERNAL_METHODS
    @@red_import = false
    return ruby_js
  end
  
  def print_js(js_output, filename = nil, dry_run = true) # :nodoc:
    puts RED_MESSAGES[:output] % [("- #{filename}.js" unless dry_run), js_output]
  end
  
  RED_MESSAGES = {}
  RED_MESSAGES[:banner] = <<-MESSAGE

Description:
  Red converts Ruby to JavaScript.
  For more information see http://github.com/jessesielaff/red/wikis

Usage: red [filename] [options]

Options:
  MESSAGE
  
  RED_MESSAGES[:invalid] = <<-MESSAGE

You used an %s

Use red -h for help.

  MESSAGE
  
  RED_MESSAGES[:missing] = <<-MESSAGE

You had a %s <ruby-string>

Use red -h for help.

  MESSAGE
  
  RED_MESSAGES[:usage] = <<-MESSAGE

Usage: red [filename] [options]

Use red -h for help.

  MESSAGE
  
  RED_MESSAGES[:output] = <<-MESSAGE

%s
=================================

%s

=================================

  MESSAGE
end
