import common, utility, sphere, material, vec3, color


proc random_scene* : seq[hittable] =
    var world: seq[hittable]
    var ground_material = lambertian(albedo: (0.5, 0.5, 0.5))
    world.add(sphere(center: (0.0, -1000.0, 0.0), radius: 1000.0, mat: ground_material))
    for a in countup(-10, 10):
        for b in countup(-10, 10):
            var choose_mat = rand_float()
            var center: point = (float(a) + 0.9*rand_float(), 0.2, float(b) + 0.9*rand_float())

            if (center - (4.0, 0.2, 0.0)).magnitude > 0.9:
                var sphere_material: material
                if choose_mat < 0.6:
                    var albedo = randcolor() * randcolor()
                    sphere_material = lambertian(albedo: albedo)

                elif choose_mat < 0.8:
                    var albedo = randcolor(0.5, 1.0)
                    var fuzz = rand_range(0, 0.5)
                    sphere_material = metal(fuzz: fuzz, albedo: albedo)
        
                else:
                    sphere_material = dielectric(refraction_index: 1.5)
                world.add(sphere(center: center, radius: 0.2, mat: sphere_material))

    var material1 = dielectric(refraction_index: 1.5)
    world.add(sphere(center: (0.0, 1.0, 0.0), radius: 1.0, mat: material1))

    var material2 = lambertian(albedo: (0.4, 0.2, 0.1))
    world.add(sphere(center: (-4.0, 1.0, 0.0), radius: 1.0, mat: material2))

    var material3 = metal(albedo: (0.7, 0.6, 0.5), fuzz: 0.0)
    world.add(sphere(center: (4.0, 1.0, 0.0), radius: 1.0, mat: material3))

    return world