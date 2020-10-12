import common, vec3, ray, math, hittable


type sphere* = ref object of hittable
    center*: point
    radius*: float
    mat*: material


method hit* (this: sphere, r: ray, t_min: float, t_max: float, rec: var hit_record): bool =
    var oc: vec3 = r.origin - this.center
    var a = r.direction.len_squared
    var half_b = dot(oc, r.direction)
    var c = oc.len_squared - this.radius*this.radius
    var discreminant = half_b*half_b - a*c
    if discreminant > 0.0:
        var temp1 = (-half_b - sqrt(discreminant)) / a
        var temp2 = (-half_b + sqrt(discreminant)) / a
        var temp = -1.0
        if temp1 < t_max and temp1 > t_min:
            temp = temp1
        elif temp2 < t_max and temp2 > t_min:
            temp = temp2
        if temp > -1.0:
            rec.t = temp
            rec.p = r.at(temp)
            rec.set_face_normal(r, (rec.p - this.center) / this.radius)
            rec.mat = this.mat
            return true
    return false


