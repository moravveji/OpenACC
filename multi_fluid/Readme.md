# Multi Component Charged Fluid Plasma

## Purpose
This project is aimed at testing data transfer between host and device in OpenACC with complex/nested derived-type variables. E.g. The multi-component fluid consists of different species (say `Ne` electrons), and each electron has its own position, velocity, acceleration, momentum, force and electric field excerted to it. Therefore, the y-component of the linear momentum of the `k`-th electron is accessed as `fluid% plasma(electrons% id)% mom% py(k)`. This is already pretty complicated, but allows expeimenting with derived-types inside derived-types.

# Contains


