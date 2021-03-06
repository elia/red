= Red converts Ruby to Javascript

This is my personal fork of the Ruby Red Project. http://github.com/jessesielaff/red

== Getting started

simple.rb:
  require 'red_query'
  
  Document.ready? do
    Document.query('#someDiv').html('hello ruby!!')
  end
  
You need Red and red_query (http://github.com/julius/red_query) for this to work.
Compile it with:
  ruby -I$RED_DIR/lib/ $RED_DIR/bin/red -I$RED_QUERY_DIR/ -o simple.js simple

== Whats different in my fork?

There are a lot of fixes to make more advanced Ruby code run. One Example is calling 'super' over more than two levels of inheritance.
Many additions and changes are made to make Red fit better into real world scenarios

=== Include folders, set output file

Here is an example for compilation
  ruby -I$RED_DIR/lib/ $RED_DIR/bin/red -I../red_query/ -Ilib -I. -Iapp -o public/js/mycode.js red/mycode

This will compile the file "red/mycode.rb" and will write the output to "public/js/mycode.js"
"require"-Statements in Red code will search in all directories marked by -I<dir> (after ../bin/red)

=== Super private Code

Its nice to reuse code in the frontend and in the backend. E.g.
  class User
    def valid_email?(email)
      ...
    end
  end

You can also save classes by mixing in some backend only code.
  class User
    def valid_email?(email)
      ...
    end

    def login(email, password)
      top_secret_stuff(email)
      screwed_up_backend_code(email, password)
    end
  end

You might not want to let Red reveal the login method to hackers. Lets invent some Syntax.
  class User
    def valid_email?(email)
      ...
    end

	server_side
	
    def login(email, password)
      top_secret_stuff(email)
      screwed_up_backend_code(email, password)
    end
  end

The method login and everything after server_side will be ignored by my Red customization.


=== Redshift != Red

I excluded Redshift from my Red version. I believe Red should only have Compilation functionality and it should be open
for any kind of Framework, which does DOM-Access etc. I personally started one based on jQuery: http://github.com/julius/red_query

== The original Red

You can learn more about the great original, gem installable Red on http://github.com/jessesielaff/red/wikis

=== MIT License

Copyright (c) 2008 Jesse Sielaff

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  'Software'), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:
  
  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
