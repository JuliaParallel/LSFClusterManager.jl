module LSFClusterManager

using Distributed
using Sockets
using Pkg

export launch, manage, kill, init_worker, connect
import Distributed: launch, manage, kill, init_worker, connect

worker_cookie() = begin Distributed.init_multi(); cluster_cookie() end
worker_arg() = `--worker=$(worker_cookie())`

include("lsf.jl")

end # module
