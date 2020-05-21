using ArgParse

function ParseBenchmarkParameters()
    s = ArgParseSettings()

    @add_arg_table! s begin
        "--dataset"
        "--directed"
            arg_type = Bool
        "--source_vertex"
            arg_type = Int
        "--damping_factor"
            arg_type = Float64
        "--max_iteration"
            arg_type = Int64
        "--output"
        "--threadnum"
            arg_type = Int
        "--binary"
    end

    return parse_args(s)
end
