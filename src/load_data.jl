"""
    @extract_to_local_scope(data, block)

This macro will extract the variables in the `block` from `data`.

## Example

```julia
@extract_to_local_scope(data, begin
    set_i
    set_g
end)
```
"""
macro extract_to_local_scope(data, block)
    code = quote end
    last_line = block.args[1]
    for X in block.args
        if X isa LineNumberNode
            last_line = X
            continue
        end
        if Meta.isexpr(X, :call)
            element = X.args[2]
            name = X.args[3]
        else
            element = X
            name = X
        end

        push!(code.args, :($(esc(name)) = $(esc(data))[$(QuoteNode(element))]))
        
    end
    return code
end
