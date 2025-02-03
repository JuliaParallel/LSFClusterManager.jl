import LSFClusterManager
import Test

import Distributed

# Bring some names into scope, just for convenience:
using Distributed: addprocs, rmprocs
using Distributed: workers, nworkers
using Distributed: procs, nprocs
using Distributed: remotecall_fetch, @spawnat
using Test: @testset, @test, @test_skip

# LSF:
using LSFClusterManager: addprocs_lsf, LSFManager

lsf_is_installed() = !isnothing(Sys.which("bsub"))

@testset "LSFClusterManager.jl" begin
    @info "" Sys.which("bsub")

    @test lsf_is_installed()

    include("lsf.jl")
end
