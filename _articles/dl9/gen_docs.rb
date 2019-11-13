# ["img/first_tests.png", "First game preview (Game)"], 



items = [
["img/head.png", "Flesh and Blood (Blender)"], 
["img/witch.png", "There's always a witch (Blender)"],
["img/kit.png", "Created some pieces of lego (Blender)"], 

["img/cube1.png", "Ancient pavement (Blender)"], 
["img/pumpkin.png", "Halloween theme (Blender)"], 
["img/cube2.png", "Wet Wet Wet (Blender)"], 

["img/street.png", "Build like a lego (Game)"], 
["img/menu.png", "Let there be light (Game)"], 
["img/piemenu.png", "Some slices of cake (Game)"], 

["img/blender3.png", "Wiring (Blender)"],  
["img/blender2.png", "Mesh Up (Blender)"], 
["img/blender1.png", "Atmosphere (Blender)"], 

["img/blender4.png", "Haunted House (Blender)"],  
["img/church.png", "Freaky scene (Blender)"], 
["img/blender5.png", "Point of view (Blender)"],  

["img/blender6.png", "Bullet (Blender)"],

["img/1.png", "Shot 1 (Game)"],  
["img/2.png", "Shot 2 (Game)"],
["img/3.png", "Shot 3 (Game)"],
["img/4.png", "Shot 4 (Game)"],
["img/5.png", "Shot 5 (Game)"],
["img/6.png", "Shot 6 (Game)"],
["img/7.png", "Shot 7 (Game)"],
["img/8.png", "Shot 8 (Game)"],
["img/menu.png", "Shot 9(Game)"],
["img/piemenu.png", "GUI (Game)"],
["img/menu-bright.png", "Shot (Game)"],

]

content = ""

sub = <<EOF
<html>
    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <style>
            .card {
                text-align: center;
                background-color: #222;
                color: #eee;
               
            }
            .col-4{
                 margin-top: 20px;
            }
            .card-header {
                font-size: 24px;
                font-weight: 500;
                background-color: rgba(67, 67, 67, 0.9);
            }
            body{
                background-color: #111;
                color: #eee;
            }

        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
EOF
content += sub

items.each do |img, name|
sub = <<EOF

                <div class="col-4">
                    <div class="card h-100">
                        <div class="card-header">
                            <div class="">
                                #{name}
                            </div>
                        
                        </div>
                        <div class="card-body">
                            <div class="">
                                <a href="#{img}" target="_blank"><img src="#{img}" class="img-fluid"></a>
                            </div>
                        
                        </div>

                    </div>
                </div>
EOF
content += sub
end

sub = <<EOF
            </div>
        </div>
    </body>
</html>
EOF
content += sub

File.write("makingoff.html", content)