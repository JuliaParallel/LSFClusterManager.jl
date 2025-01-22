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

const test_args = lowercase.(strip.(ARGS))

@info "" test_args

lsf_is_installed() = !isnothing(Sys.which("bsub"))

@testset "LSFClusterManager.jl" begin
    if lsf_is_installed()
        @info "Running the LSF tests..." Sys.which("bsub")
        include("lsf.jl")
    else
        if "lsf" in test_args
            @error "ERROR: The LSF tests were explicitly requested in ARGS, but bsub was not found, so the LSF tests cannot be run" Sys.which("bsub") test_args
            @test false
        else
            @warn "bsub was not found - LSF tests will be skipped" Sys.which("bsub")
            @test_skip false
        end
    end
end # @testset
