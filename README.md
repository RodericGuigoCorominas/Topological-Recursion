# Topological Recursion 
This is some (very) preliminary and not optimized package to compute topological recursion invariant forms on a given spectral curve of genus 0, i.e. CP^1, arbitrary ramifications and with fundamental form of second kind B(z,z')=1/(z1-z2)^2. This package runs in parallel with Combinatorica, so they both must be loaded together. 

```
Needs["Combinatorica`"]
Needs["TopologicalRecursion`"]
```

The two main functions to be used are SetSpectralCurve and TopologicalRecursionForm. 

### Defining a Spectral Curve

A Spectral Curve contains the data of two maps x(z) and y(z), together with a deck transformation generator of the covering map x(z). The variable z is the coordinate on CP^1.  

```
SetSpectralCurve[{x(z),z},{y(z),z},{T(z),z}]
```

### Compute Topological Recursion Invariants

The characteristic invariant forms W_{gn} with boundary components {p1,...,pn} can be computed with TopologicalRecursionForm[g,n,{p1,...,pn}].   

```
TopologicalRecursionForm[1,1,{p1}]
TopologicalRecursionForm[0,3,{p1,p2,p3}]
TopologicalRecursionForm[1,2,{p1,p2}]
```
#### Remark
The number n must match the number of input variables.

### Examples

The fundamental example is the Airy Spectral curve. 
```
SetSpectralCurve[{z^2,z},{z,z},{-z,z}]
TopologicalRecursionForm[1,1,{p1}]
```
