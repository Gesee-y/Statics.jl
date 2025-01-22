## A script for static data (know at compile time.) ##

abstract type StaticAny{N} end
abstract type StaticNumber{N} <: StaticAny{N} end
abstract type StaticInteger{N} <: StaticNumber{N} end
abstract type StaticSigned{N} <: StaticInteger{N} end
abstract type StaticUnsigned{N} <: StaticInteger{N} end
abstract type StaticAbstractFloat{N} <: StaticNumber{N} end

abstract type StaticSymbol{N} end

"""
	struct StaticInt{N} <: StaticNumber
		value :: Val{N}

The purpose of this structure is to provide to the compiler values known at compile time.
For this, the compiler need to receive a Val as arg

# Example

```julia-repl

julia> a = StaticInt(2)
2

julia> f(::StaticInt{2}) = true

julia> f(a)
true

```
"""
struct SInt8{N} <: StaticSigned{N}
	SInt8{N}() where N = new{Int8(N)}()
end
SInt8(N::Integer) = SInt8{N}()

struct SInt16{N} <: StaticSigned{N}
	SInt16{N}() where N = new{Int16(N)}()
end
SInt16(N::Integer) = SInt16{N}()

struct SInt32{N} <: StaticSigned{N}
	SInt32{N}() where N = new{Int32(N)}()
end
SInt32(N::Integer) = SInt32{N}()

struct SInt64{N} <: StaticSigned{N}
	SInt64{N}() where N = new{Int64(N)}()
end
SInt64(N::Integer) = SInt64{N}()
const SInt{N} = SInt64{N}

struct SUInt8{N} <: StaticUnsigned{N} 
	SUInt8{N}() where N = new{UInt8(N)}()
end
SUInt8(N::Integer) = SUInt8{N}()

struct SUInt16{N} <: StaticUnsigned{N} 
	SUInt16{N}() where N = new{UInt16(N)}()
end
SUInt16(N::Integer) = SUInt16{N}()

struct SUInt32{N} <: StaticUnsigned{N} 
	SUInt32{N}() where N = new{UInt32(N)}()
end
SUInt32(N::Integer) = SUInt32{N}()

struct SUInt64{N} <: StaticUnsigned{N} 
	SUInt64{N}() where N = new{UInt64(N)}()
end
SUInt64(N::Integer) = SUInt64{N}()
const SUInt{N} = SUInt64{N}

struct SFloat16{N} <: StaticAbstractFloat{N}
	SFloat16{N}() where N = new{Float16(N)}()
end
SFloat16(N::Real) = SFloat16{N}()

struct SFloat32{N} <: StaticAbstractFloat{N}
	SFloat32{N}() where N = new{Float32(N)}()
end
SFloat32(N::Real) = SFloat32{N}()

struct SFloat64{N} <: StaticAbstractFloat{N}
	SFloat64{N}() where N = new{Float64(N)}()
end
SFloat64(N::Real) = SFloat64{N}()

struct SBool{B} <: StaticAny{B}
	SBool{B}() where B = new{Bool(B)}()
end
SBool(B) = SBool{B}()

struct SSymbol{S} <: StaticAny{S}
	SSymbol{S}() where S = new{Symbol(S)}()
end
SSymbol(S) = SSymbol{S}()

StaticSigned{N}() where N = SInt64{N}()
StaticSigned(N::Integer) = SInt64{N}()

StaticUnsigned{N}() where N = SUInt64{N}()
StaticUnsigned(N::Integer) = SUInt64{N}()

StaticAbstractFloat{N}() where N = SFloat64{N}()
StaticAbstractFloat(N::Real) = SFloat64{N}()

include("promotion.jl")
include("operations.jl")

Base.show(io::IO,n::StaticAny{N}) where N = show(io,N)
Base.show(n::StaticAny{N}) where N = show(stdout,n)

Base.print(io::IO,n::StaticAny{N}) where N = print(io,N)
Base.print(n::StaticAny{N}) where N = print(stdout,n)

Base.println(io::IO,n::StaticAny{N}) where N = println(io,N)
Base.println(n::StaticAny{N}) where N = println(N)