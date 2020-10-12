type vec3* = tuple
    x, y, z: float


type
    color* = vec3
    point* = vec3


type material* = ref object of RootObj



type
    hit_record* = object
        p*: point
        normal*: vec3
        t*: float
        front_face*: bool
        mat*: material


type
    hittable* = ref object of RootObj

type ray* = object
    origin*: point
    direction*: vec3
