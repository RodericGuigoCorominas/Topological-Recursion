# Topological Recursion 
This is some (very) preliminary and not optimized package to compute topological recursion invariant forms on a given spectral curve. This package runs in parallel with Combinatorica, so they both must be loaded together. 

```
Needs["Combinatorica`"]
Needs["TopologicalRecursion`"]
```

The two main functions to be used are SetSpectralCurve and TopologicalRecursionForm. 

### Defining a Spectral Curve

A Spectral Curve contains the data of two maps x(t) and y(t), together with a deck transformation generator for the covering map x(t). 

```
SetSpectralCurve[{z^2,z},{z,z},{-z,z}]
```

### Compute Topological Recursion Invariants

The characteristic invariant forms W_{gn} with boundary components {p1,...,pn} can be computed with TopologicalRecursionForm[g,n,{p1,...,pn}].   

```
TopologicalRecursionForm[1,1,{p1}]
TopologicalRecursionForm[0,3,{p1,p2,p3}]
TopologicalRecursionForm[1,2,{p1,p2}]
```

