#!/bin/bash

## Dimitri Komatitsch, CNRS, Marseille, France, February 2015:
## add new parameters (i.e. a default value for each of them)
## to the end of an existing Par_file in order to update it to the new format.

cat << EOF >> Par_file

SAVE_SEISMOGRAMS_PRESSURE       = .false.  # currently implemented in acoustic (i.e. fluid) elements only

# use a trick to increase accuracy of pressure seismograms in fluid (acoustic) elements:
# use the second derivative of the source for the source time function instead of the source itself,
# and then record -potential_acoustic() as pressure seismograms instead of -potential_dot_dot_acoustic();
# this is mathematically equivalent, but numerically significantly more accurate because in the explicit
# Newmark time scheme acceleration is accurate at zeroth order while displacement is accurate at second order,
# thus in fluid elements potential_dot_dot_acoustic() is accurate at zeroth order while potential_acoustic()
# is accurate at second order and thus contains significantly less numerical noise.
USE_TRICK_FOR_BETTER_PRESSURE   = .false.

#
# source encoding
#
# determines source encoding factor +/-1 depending on sign of moment tensor
# (see e.g. Krebs et al., 2009. Fast full-wavefield seismic inversion using encoded sources, Geophysics, 74 (6), WCC177-WCC188.)
USE_SOURCE_ENCODING             = .false.

#
# total energy calculation
#
# to plot total energy curves, for instance to monitor how CPML absorbing layers behave;
# should be turned OFF in most cases because expensive
OUTPUT_ENERGY                   = .false.
# every how many time steps we compute energy (which is expensive to compute)
NTSTEP_BETWEEN_OUTPUT_ENERGY    = 10

#
# adjoint kernel outputs
#
# this parameter must be set to .true. to compute anisotropic kernels
# in crust and mantle (related to the 21 Cij in geographical coordinates)
# default is .false. to compute isotropic kernels (related to alpha and beta)
ANISOTROPIC_KL                  = .false.

# compute transverse isotropic kernels (alpha_v,alpha_h,beta_v,beta_h,eta,rho)
# rather than fully anisotropic kernels in case ANISOTROPIC_KL is set to .true.
SAVE_TRANSVERSE_KL              = .false.

# outputs approximate Hessian for preconditioning
APPROXIMATE_HESS_KL             = .false.

# save Moho mesh and compute Moho boundary kernels
SAVE_MOHO_MESH                  = .false.

EOF

echo "Your existing Par_file has been updated to the new format by adding default values for the missing parameters at the end of your file"

