<style TYPE="text/css">
code.has-jax {font: inherit; font-size: 100%; background: inherit; border: inherit;}
</style>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
    tex2jax: {
        inlineMath: [['$','$'], ['\\(','\\)']],
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre'] // removed 'code' entry
    }
});
MathJax.Hub.Queue(function() {
    var all = MathJax.Hub.getAllJax(), i;
    for(i = 0; i < all.length; i += 1) {
        all[i].SourceElement().parentNode.className += ' has-jax';
    }
});
</script>
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# Allocatable Arrays

## Purpose
This simple example computes a rotated two-dimensional (2D) Gaussian curve following the formula (https://en.wikipedia.org/wiki/Gaussian_function), as an example of moving data between host and device. This example can be basically extended to any other application where some basic arrays need to be copied to the device for a data-exhaustive computations and the results be copied back to the host. 

## Contents
- `Makefile` to build the example
- `main.f90` which is the basic caller
- `vars.f90` which defines the variables, allocates the allocatable arrays, and takes care of host-to-device (`h2d()`) and device-to-host (`d2h()`) data transfer using the `!$acc enter data` and `!$acc exit data` clauses. 
- `kern.f90` which 

## formula
this is $x$ and this is 

$$x = y $$

## Tips
+ It is possible to allocate an array declared as `allocatable` on the device. This means, the call to `alloc()` and `h2d()` functions in the `main` program are interchangeable.
+  
