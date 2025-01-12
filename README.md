# LSFClusterManagers.jl

The `LSFClusterManagers.jl` package implements code for the LSF (Load Sharing Facility) compute cluster job queue system.

`LSFClusterManagers.LSFManager` supports IBM's scheduler.  See the `addprocs_lsf` docstring
for more information.

Implemented in this package (the `LSFClusterManagers.jl` package):

| Job queue system | Command to add processors |
| ---------------- | ------------------------- |
| Load Sharing Facility (LSF) | `addprocs_lsf(np::Integer; bsub_flags=``, ssh_cmd=``)` or `addprocs(LSFClusterManagers.LSFManager(np, bsub_flags, ssh_cmd, retry_delays, throttle))` |

The functionality in this package originally useed to live in [`ClusterManagers.jl`](https://github.com/JuliaParallel/ClusterManagers.jl).
