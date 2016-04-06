# encoding: utf-8
require 'uri'
require "json"
require "colorize"
require 'date'
require 'open-uri'

colors = String.colors
boards = ["cyb", "tech", "λ", "layer", "zzz", "w", "feels", "drg", "lit", "diy", "art", "r", "q"]

if ARGV[0] == "boards"
  boards.each { |x| puts "/#{x}/".colorize(colors.sample.to_sym) }
end

if ARGV[1] == "threads"
  board = ARGV[0]
  if board == "\u03BB"
    board_u = "\u03BB"
    board_u = board_u.encode('utf-8')
    board = "%CE%BB"
  end

  open("https://lainchan.org/#{board}/threads.json") {|f|
     f.each_line { |line|
        json = JSON.parse(line)
        for i in 0...json[0]['threads'].count
          thread_num = json[0]['threads'][i]['no']
         open("https://lainchan.org/#{board}/res/#{thread_num}.json") {|e|
           e.each_line { |thread_title_line|
              thread_title_json = JSON.parse(thread_title_line)
              if thread_title_json['posts'][0]['sub'].nil? == true
                puts "No Thread Title".colorize(:red)
              else
              puts "Subject: ".colorize(:magenta) + thread_title_json['posts'][0]['sub'].colorize(:blue)
             end
            }
            open("https://lainchan.org/#{board}/res/#{thread_num}.json") {|e|
              e.each_line { |thread_author_line|
                 thread_author_json = JSON.parse(thread_author_line)
                 print "Author/Trip: ".colorize(:magenta) + thread_author_json['posts'][0]['name'].colorize(:cyan) + ""
                 if thread_author_json['posts'][0]['capcode'].nil? == true
                   print "\n"
                 else
                   print " ## " + thread_author_json['posts'][0]['capcode'].colorize(:cyan) + "\n"
                 end
               }
             }
            puts "Thread number: ".colorize(:magenta) + json[0]['threads'][i]['no'].to_s.colorize(:green)
          }
          open("https://lainchan.org/#{board}/res/#{thread_num}.json") {|e|
            e.each_line { |thread_time_line|
               thread_time_json = JSON.parse(thread_time_line)
               thread_time = thread_time_json['posts'][0]['time']
               puts Time.at(thread_time).to_s.colorize(:blue)
             }
           }
          open("https://lainchan.org/#{board}/res/#{thread_num}.json") {|e|
            e.each_line { |thread_content_line|
               thread_content_json = JSON.parse(thread_content_line)
               puts thread_content_json['posts'][0]['com'][0..100].gsub(/\s\w+\s*$/, '...').gsub(/<\/?[^>]*>/, "").colorize(:yellow)
             }
           }
           puts "-" * 100
      end
    }
  }
end

if ARGV[0] == "view"
  board = ARGV[1]
  if board == "\u03BB"
    board_u = "\u03BB"
    board_u = board_u.encode('utf-8')
    board = "%CE%BB"
  end
  thread_num = ARGV[2]
  open("https://lainchan.org/#{board}/res/#{thread_num}.json") {|e|
    e.each_line { |thread_content_line|
       thread_content_json = JSON.parse(thread_content_line)
       for i in 0...thread_content_json['posts'].count
      puts thread_content_json['posts'][i]['com'][0..100].gsub(/\s\w+\s*$/, '...').sub(/<("[^"]*"|'[^']*'|[^'">])*>/, '').colorize(:yellow)

     end
     }
   }
end
