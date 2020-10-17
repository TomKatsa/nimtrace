import common, color, vec3, ray, times, random, camera, scene

# Image
const aspect_ratio = 3.0 / 2.0
const width = 1200
const height = int(width / aspect_ratio)
const samples_per_pixel = 100
const depth = 50

# Camera
var cam: camera
#cam.init_cam((0.0, 0.0, 0.0), (0.0, 0.0, -1.0), (0.0, 1.0, 0.0),90, 16/9)
cam.init_cam((13.0, 2.0, 3.0), (0.0, 0.0, 0.0), (0.0, 1.0, 0.0),20 , aspect_ratio)



const filename = "image.ppm"



proc write_header(fileobj: File) = 
    fileobj.write("P3\n", width, " ", height, "\n255\n")



proc generate_img(fileobj: File) =
    var world = random_scene()

    #var ground: material = lambertian(albedo: (0.0, 0.6, 0.0))
    #var blue: material = lambertian(albedo: (0.3, 0.3, 0.7))
    #var mirror: material = metal(albedo: (0.8, 0.8, 0.8), fuzz: 0.0)
    #var gold: material = metal(albedo: (0.8, 0.6, 0.2), fuzz: 0.8)

    #world.add(sphere(center: (0.0,-100.5,-1.0), radius: 100.0, mat: ground))
    #world.add(sphere(center: (-1.0, 0.0, -1.0), radius: 0.5, mat: blue))
    #world.add(sphere(center: (0.0, 0.0, -1.2), radius: 0.5, mat: mirror))
    #world.add(sphere(center: (1.0, 0.0, -1.0), radius: 0.5, mat: gold))
    


    let time_start = cpuTime()
    for j in countdown(height-1, 0):
        echo "Scanlines remaining: ", j+1
        for i in countup(0, width-1):
            var c: color = (0.0, 0.0, 0.0)
            for k in countup(1, samples_per_pixel):
                var u = (float(i) + rand(1.0)) / (width-1) 
                var v = (float(j) + rand(1.0)) / (height-1)
                var r: ray = cam.get_ray(u, v)
                c += ray_color(r, world, depth)
            fileobj.write_color(c, samples_per_pixel)
    echo "Done in ", (cpuTime() - time_start), "s"


echo "Image dimensions: ", width, "x", height
echo "----------------"


let fileobj = open(filename, fmWrite)
write_header(fileobj)
generate_img(fileobj)
