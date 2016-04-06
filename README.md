# lnchn

lnchn is a small command line reader for the imageboard [lainchan](https://lainchan.org/).

--- Rundown
  - No ncurses/curses.
  - Text output
  - Written in ruby


### dependencies

* ```(sudo) gem install colorize``` [[colorize](https://github.com/fazibear/colorize)]

### guide
```
$ ruby lnchn.rb boards # lists boards
$ ruby lnchn.rb BOARD_NAME threads # list threads on the first page. [FINISHED]
$ ruby view BOARD_NAME THREAD_NAME # read a thread [UNFINISHED/WIP]
```
### examples
```
$ ruby lnchn.rb λ threads # list the threads on /λ/
$ ruby lnchn.rb λ 21246 # read a threads on /λ/
```
### license
![](http://i.imgur.com/HdsLqoL.png)

copyfarleft
