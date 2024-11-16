require 'date'
Dir.glob("_articles/timelapse/*.md") do |file|
    puts file
    name = File.basename(file, '.*')
    pngs = []
    Dir.glob("_articles/timelapse/#{name}/*.png") do |png|
        pngs << png
    end
    pngs.sort!
    data = []
    pngs.each do |png|
        any, date, time = png.split(" ")
        d = DateTime.parse(date + " " + time)
        data << [png, d]
    end
    outlines = []
    i = 0
    data.each do |png, date|
        minutes = ((date - data[[i-1,0].max].last).to_f * 24 * 60)
        str = if minutes < 1
            (minutes * 60).to_i.to_s + " minutes later"
        else
            minutes.to_i.to_s + " minutes later"
        end
        str2 = "at " + ((date - data.first.last).to_f * 24 * 60).round.to_s + " minutes"
        outlines << [File.basename(png), str2]
        i+=1
    end


    out = "_articles/timelapse/#{name}-timelapse.md"

    str = <<EOF
---
layout: product
name:   "Golden Fox"
date: 2020-01-22 12:00:00
categories: product game
group:  blender
---

# #{name} - Timelapse

<div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="3000" data-pause="false">
  <!-- Indicators -->
  <ol class="carousel-indicators">
EOF

outlines.each_with_index do |tab,index|
str += str2 = <<EOF
    <li data-target="#myCarousel" data-slide-to="#{index}" class="#{index == 0 ? 'active' : ''}" ></li>
EOF
end
str += str2 = <<EOF
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner">
EOF

outlines.each do |png, date|
str += str2 = <<EOF
    <div class="item #{png == outlines.first.first ? 'active' : ''}">
      <img src="#{name}/#{png}" alt="screen">
      <div class="carousel-caption">
        <h3>#{name}</h3>
        <p>#{date}</p>
      </div>
    </div>
EOF
end

str += str3 = <<EOF
  <!-- Left and right controls -->
  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
    <div style="font-size: 40px; margin-top: 200px; height: 100%">&lt;</div>
  </a>
  <a class="right carousel-control" href="#myCarousel" data-slide="next">
    <div style="font-size: 40px; margin-top: 200px; height: 100%">&gt;</div>
  </a>
</div>


EOF

    outlines.each do |png, date|
        # str += "### #{date}\n\n"
        # str += "![#{name}](#{name}/#{png})]\n\n"
    end

    puts str

    File.write(out, str)

end
