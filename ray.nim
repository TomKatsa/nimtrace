import vec3, common, hittable, material


proc at* (r: ray, t: float): point =
    return (r.origin + (t * r.direction))




proc ray_color* (r: ray, world: seq[hittable], depth: int): color =

    if depth <= 0:
        return (0.0,0.0,0.0)

    var rec: hit_record

    if world.hit(r, 0.001, Inf, rec):

        var scattered: ray
        var attenuation: color
        if rec.mat.scatter(r, rec, attenuation, scattered):
            return attenuation * ray_color(scattered, world, depth-1)
        
        #return 0.5*(rec.normal.x+1, rec.normal.y+1, rec.normal.z+1)
        return (0.0, 0.0, 0.0)

    var unit_dir = r.direction.unit_vector
    var white: color = (1.0, 1.0, 1.0)
    var light_blue: color = (0.5, 0.7, 1.0)
    var t = 0.5*(unit_dir.y + 1.0)
    return ( (1.0 - t)*white + t*light_blue )



