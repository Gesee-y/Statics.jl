## Promote Rule for the new types ##

## Promotion between Integers
Base.promote_rule(::Type{SInt64}, ::Type{<:StaticInteger}) = SInt64
Base.promote_rule(::Type{<:StaticInteger}, ::Type{SInt64}) = SInt64

# Promotion between SInt16 and SInt8
Base.promote_rule(::Type{SInt16}, ::Type{<:SInt8}) = SInt16
Base.promote_rule(::Type{<:SInt8}, ::Type{SInt16}) = SInt16

# Promotion between SInt32, SInt16 and SInt8
Base.promote_rule(::Type{SInt32}, ::Type{<:Union{SInt8,SInt16}}) = SInt32
Base.promote_rule(::Type{<:Union{SInt8,SInt16}}, ::Type{SInt32}) = SInt32

## Promotion between Signed and Unsigned
@generated Base.promote_rule(::Type{<:StaticUnsigned}, T::Type{<:StaticSigned}) = :($T.name.name)
@generated Base.promote_rule(T::Type{<:StaticSigned}, ::Type{<:StaticUnsigned}) = :($T.name.name)

## Promotion between Unsigned
Base.promote_rule(::Type{SUInt64}, ::Type{<:StaticUnsigned}) = SUInt64
Base.promote_rule(::Type{<:StaticUnsigned}, ::Type{SUInt64}) = SUInt64

# Promotion between SUInt16 and SUInt8
Base.promote_rule(::Type{SUInt16}, ::Type{<:SUInt8}) = SUInt16
Base.promote_rule(::Type{<:SUInt8}, ::Type{SUInt16}) = SUInt16

# Promotion between SUInt32, SUInt16 and SUInt8
Base.promote_rule(::Type{SUInt32}, ::Type{<:Union{SUInt8,SUInt16}}) = SUInt32
Base.promote_rule(::Type{<:Union{SUInt8,SUInt16}}, ::Type{SUInt32}) = SUInt32

## Promotion between Floats
Base.promote_rule(::Type{SFloat64}, ::Type{<:StaticAbstractFloat}) = SFloat64
Base.promote_rule(::Type{<:StaticAbstractFloat}, ::Type{SFloat64}) = SFloat64

# Promotion between SFloat32 and SFloat16 
Base.promote_rule(::Type{SFloat32}, ::Type{<:SFloat16}) = SFloat32
Base.promote_rule(::Type{<:SFloat16}, ::Type{SFloat32}) = SFloat32

## Promotion between Floats and Integers
@generated Base.promote_rule(::Type{<:StaticInteger}, T::Type{<:StaticAbstractFloat}) = :($T.name.name)
@generated Base.promote_rule(T::Type{<:StaticAbstractFloat}, ::Type{<:StaticInteger}) = :($T.name.name)

## Promotion between Integers and Bools
@generated Base.promote_rule(::Type{SBool}, T::Type{<:StaticInteger}) = :($T.name.name)
@generated Base.promote_rule(T::Type{<:StaticInteger}, ::Type{SBool}) = :($T.name.name)

## Promotion between Floats and Bools
@generated Base.promote_rule(::Type{SBool}, T::Type{<:StaticAbstractFloat}) = :($T.name.name)
@generated Base.promote_rule(T::Type{<:StaticAbstractFloat}, ::Type{SBool}) = :($T.name.name)

## Promotion between the same types

@generated Base.promote_rule(::Type{T},::Type{T}) where T <:StaticNumber = :($T.name.name)

## Promotion between StaticNumbers and Numbers
Base.promote_rule(T::Type{<:StaticSigned},::Type{<:Integer}) = SInt64
Base.promote_rule(::Type{<:Integer},T::Type{<:StaticSigned}) = SInt64

Base.promote_rule(T::Type{<:StaticUnsigned},::Type{<:Signed}) = SInt64
Base.promote_rule(::Type{<:Signed},T::Type{<:StaticUnsigned}) = SInt64

Base.promote_rule(T::Type{<:StaticUnsigned},::Type{<:Unsigned}) = SUInt64
Base.promote_rule(::Type{<:Unsigned},T::Type{<:StaticUnsigned}) = SUInt64

Base.promote_rule(::Type{<:StaticNumber},::Type{<:AbstractFloat}) = SFloat64
Base.promote_rule(::Type{<:AbstractFloat},::Type{<:StaticNumber}) = SFloat64


## Result promotion

@generated Base.promote_result(T::Type{<:StaticAbstractFloat}, ::Type{<:StaticInteger}, s1::Symbol, s2::Symbol) = :($T.parameters[1].name.name)
@generated Base.promote_result(::Type{<:StaticInteger}, T::Type{<:StaticAbstractFloat}, s1::Symbol, s2::Symbol) = :($T.parameters[1].name.name)

@generated Base.promote_result(T::Type{<:StaticNumber}, ::Type{<:Integer}, s1::Symbol, s2::Symbol) = :($T.parameters[1].name.name)
@generated Base.promote_result(::Type{<:Integer}, T::Type{<:StaticNumber}, s1::Symbol, s2::Symbol) = :($T.parameters[1].name.name)

Base.promote_result(T::Type{<:StaticNumber}, ::Type{<:AbstractFloat}, s1::Symbol, s2::Symbol) = SFloat64
Base.promote_result(::Type{<:AbstractFloat}, T::Type{<:StaticNumber}, s1::Symbol, s2::Symbol) = SFloat64