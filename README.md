# LSFClusterManager.jl

The `LSFClusterManager.jl` package implements code for the LSF (Load Sharing Facility) compute cluster job queue system.

`LSFManager` supports IBM's scheduler.  See the `addprocs_lsf` docstring
for more information.

Implemented in this package (the `LSFClusterManager.jl` package):

| Job queue system | Command to add processors |
| ---------------- | ------------------------- |
| Load Sharing Facility (LSF) | `addprocs_lsf(np::Integer; bsub_flags=``, ssh_cmd=``)` or `addprocs(LSFManager(np, bsub_flags, ssh_cmd, retry_delays, throttle))` |

### LSF: a simple interactive example

```julia
julia> using LSFClusterManager

julia> LSFClusterManager.addprocs_sge(5; qsub_flags=`-q queue_name`)
job id is 961, waiting for job to start .
5-element Array{Any,1}:
2
3
4
5
6

julia> @parallel for i=1:5
       run(`hostname`)
       end

julia>  From worker 2:  compute-6
        From worker 4:  compute-6
        From worker 5:  compute-6
        From worker 6:  compute-6
        From worker 3:  compute-6
```

Some clusters require the user to specify a list of required resources.
For example, it may be necessary to specify how much memory will be needed by the job - see this [issue](https://github.com/JuliaLang/julia/issues/10390).
The keyword `qsub_flags` can be used to specify these and other options.
Additionally the keyword `wd` can be used to specify the working directory (which defaults to `ENV["HOME"]`).

```julia
julia> using Distributed, LSFClusterManager

julia> addprocs_sge(5; qsub_flags=`-q queue_name -l h_vmem=4G,tmem=4G`, wd=mktempdir())
Job 5672349 in queue.
Running.
5-element Array{Int64,1}:
 2
 3
 4
 5
 6

julia> pmap(x->run(`hostname`),workers());

julia>  From worker 26: lum-7-2.local
        From worker 23: pace-6-10.local
        From worker 22: chong-207-10.local
        From worker 25: cheech-207-16.local

julia> rmprocs(workers())
Task (done)
```
