(* ::Package:: *)

BeginPackage["TopologicalRecursion`"]

BKernel::usage="BKernel[z,w] gives the form of the Bergmann Kernel. This version is restricted to the case where the spectral curve is CP1."

dS0::usage="dS0[p,q1] computes an integral required for the recursion kernel"

RecursionKernel::usage="RecursionKernel[p0,q_List] computes the recursion kernel of the Topological Recursion given the data of a spectral curve."

GenusPartitions::usage="GenusPartitions[g,n] gives a list of admissible partitions of a surface of genus g into n surfaces."

BoundaryPartitions::usage="BoundaryPartitions[p,n] gives a list of admissible partitions of boiundary components p into n subsets." 

CurlyW::usage="CurlyW[g,k,n,q,p] enumerates the possible degenerations of a surface of genus g and n marked points by pinching k cycles."

TopologicalRecursionForm::usage="TopologicalRecursionForm[g,n,p] computes the W[g,n] invariant polynomial of the set spectral curve."

FreeEnergy::usage="FreeEnergy[g] computes the gth free energy."

SetSpectralCurve::usage="SetSpectralCurve[{x(t),t},{y(t),t},{d(t),t}] defines the underlying spectral curve, where x(t) is a covering map to CP1, d(t) a generator of the deck transformations, and y(t) staisfying certain properties.  "

SetArbitraryBasepoint::usage="SetArbitraryBasepoint[p] simplifies computations by setting an arbitrary basepoint on the computation of the recursion Kernel."

Begin["Private`"]

BKernel[t1_,t2_]:=(t1-t2)^-2;

dS0[p_,q1_]:=1/(-$b+p)-1/(p-q1);

RecursionKernel[p_,q_List]:=dS0[p,q[[1]]]/Product[($Y[q[[1]]]-$Y[i])$X'[q[[1]]],{i,q[[2;;]]}];

SetArbitraryBasepoint[p_]:={$b=p}

GenusPartitions[g_Integer,n_Integer]:=Flatten[Map[Permutations,Join[Table[0,n-Length[#]],#]&/@Flatten[Table[IntegerPartitions[g,{i}],{i,0,n}],1]],1];

BoundaryPartitions[p_List,n_Integer]:=Flatten[Map[Permutations,Join[Table[{},n-Length[#]],#]&/@Flatten[Table[Combinatorica`KSetPartitions[p,i],{i,0,n}],1]],1];

CurlyW[g_Integer,k_Integer,n_Integer,q_List,p_List]:=Sum[Sum[Sum[If[MemberQ[Table[{h[[l]],Length[mu[[l]]]+Length[r[[l]]]},{l,Length[mu]}],{0,1}],0,Product[TopologicalRecursionForm[h[[i]],Length[mu[[i]]]+Length[r[[i]]],Join[mu[[i]],r[[i]]]],{i,1,Length[mu]}]],{r,BoundaryPartitions[p,Length[mu]]}],{h,GenusPartitions[g+Length[mu]-k,Length[mu]]}],{mu,Combinatorica`SetPartitions[q]}]*Product[D[j,q[[1]]],{j,q[[2;;]]}];

TopologicalRecursionForm[g_,n_,p_List]:=FullSimplify[Module[{z},Sum[Residue[Sum[RecursionKernel[p[[1]],Join[{z},d]]CurlyW[g,Length[d]+1,n-1,Join[{z},d],p[[2;;]]],{d,Subsets[Table[Nest[$DeckTransformation,z,i],{i,$Degree-1}],{1,$Degree}]}],{z,a}],{a,$BranchPoints}]]];

TopologicalRecursionForm[0,2,{z1_,z2_}]:=BKernel[z1,z2];

TopologicalRecursionForm[-1,n_,p_List]:=0;
TopologicalRecursionForm[g_,0,p_List]:=0;
TopologicalRecursionForm[0,1,p_list]:=0;

SetSpectralCurve[{x_,varx_},{y_,vary_},{dt_,vardt_}]:={$X=(x/.{varx->#})&,$Y=(y/.{vary->#})&,$DeckTransformation=(dt/.{vardt->#})&,$BranchPoints=DeleteDuplicates[t/.Solve[$X'[t]==0,t]],$Degree=Length[Solve[$X[t]==$gen,{t}]]};

FreeEnergy[g_]:=Sum[Residue[Integrate[$Y[t]*$X'[t],{t,o,s}]*TopologicalRecursionForm[g,1,{s}],{s,a}],{a,$BranchPoints}]/(2g-2);

End[]

EndPackage[]
