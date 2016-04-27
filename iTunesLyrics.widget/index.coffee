# Code originally created by the awesome members of Ubersicht community.
# I stole from so many I can't remember who you are, thank you so much everyone!
# Haphazardly adjusted and mangled by Pe8er (https://github.com/Pe8er)

options =
  # Easily enable or disable the widget.
  widgetEnable: false

command: "osascript iTunesLyrics.widget/GetLyrics.applescript"

refreshFrequency: '1s'

style: """

  white05 = rgba(white,0.5)
  white02 = rgba(white,0.2)

  width auto
  height auto
  bottom 0
  left @bottom
  position absolute
  -webkit-backdrop-filter blur(20px) brightness(60%) contrast(130%) saturate(140%)
  font-family system, -apple-system
  opacity 0
  padding 16px
  -webkit-transition height 250ms ease-in-out
  overflow-y scroll

  .wrapper
    font-size 8pt
    line-height 11pt
    color white

  .song
    font-weight 700
    padding-bottom 8px
    margin-bottom 8px
    border-bottom 1px white02 solid

"""

options : options

render: (output) ->

  # Initialize our HTML.
  lyricsHTML = ''

  # Create the DIVs for each piece of data.
  lyricsHTML = "
    <div class='wrapper'>
      <div class='artist'></div>
      <div class='song'></div>
      <div class='lyrics'></div>
    </div>"

  return lyricsHTML

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  if @options.widgetEnable
    # Initialize our HTML.
    lyricsHTML = ''

    if output.length == 0
      div.animate({ opacity: 0 }, 250)
    else
      metadata = output.split("~")
      artistName = metadata[0]
      songName = metadata[1]
      lyrics = metadata[2]

      div.animate({ opacity: 1 }, 250)
      div.find('.artist').html(artistName)
      div.find('.song').html(songName)
      div.find('.lyrics').html(lyrics)

    wrapHeight = div.find('.wrapper').height()
    totalHeight = screen.height
    div.css('height', wrapHeight)
    div.css('max-height', totalHeight - 48)
  else
    div.hide()
