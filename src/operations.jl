## Some operations for our new static types ##

# Addition #

known(n::StaticNumber{N}) where N = N
known(n::Number) = n

function generate_operations()
	operations = (:+,:-,:*,:(>>),:(<<),:(|),:(&),:rem,:^,:min,:max)
	foperation = (:/,:inv)
	foperation2 = (:sin,:cos,:tan,:cosd,:sind,:tand,:atan,:exp,:deg2rad,:rad2deg,:sinh,:cosh,:tanh,
				:sec,:csc,:round,:floor,:ceil,:cbrt,:sqrt,:sinpi,:cospi,:mod2pi,:exp2,:exp10,:log,
				:log10,:log2,:log1p,:cot,:secd,:cotd,:cscd,:asecd,:acotd,:acscd,:acosd,:asind,:atand,
				:cosh,:sinh,:tanh,:coth,:sech,:csch,:acosh,:asinh,:atanh,:acoth,:asech,:acsch)
	unaries = (:+,:-,:abs,:abs2)
	Bunaries = (:isodd,:iseven)
	bool_op = (:<,:>,:(==),:isequal,:isinteger)

	for op in operations
		_create_operations(op)
	end

	for op in unaries
		_create_unaries(op)
	end

	for op in Bunaries
		_Bcreate_unaries(op)
	end

	for op in foperation
		_Fcreate_operations(op)
	end

	for op in foperation2
		_Fcreate_operations2(op)
	end

	for op in bool_op
		_Bcreate_operations(op)
	end
end

function _create_operations(op)
	eval(quote 
			@generated Base.$op(n1::StaticNumber{N1},n2::StaticNumber{N2}) where{N1,N2} = begin
				T = promote_type(n1,n2)
				result = $op(N1,N2)
	
				return :($T{$result}())
			end

			@generated Base.$op(n1::StaticNumber{N},n2::Number) where N = begin
				T = promote_type(n1,n2)
				op = $op

				return :($op(n1,$T(n2)))
			end

			@generated Base.$op(n1::Number, n2::StaticNumber{N}) where N = begin
				T = promote_type(n1,n2)
				op = $op

				return :($op($T(n1),n2))
			end
	 end)
end

function _create_unaries(op)
	eval(quote 
			@generated Base.$op(n1::StaticNumber{N}) where N = begin
				T = n1.name.name
				result = $op(N)
	
				return :($T{$result}())
			end
	 end)
end

function _Bcreate_unaries(op)
	eval(quote 
			@generated Base.$op(n1::StaticNumber{N}) where N = begin
				result = $op(N)
				return :(SBool{$result}())
			end
	 end)
end

function _Fcreate_operations(op)
	eval(quote 
			@generated Base.$op(n1::StaticNumber{N1},n2::StaticNumber{N2}) where{N1,N2} = begin
				result = $op(N1, N2)
				return :(SFloat64{$result}())
			end
	 end)
end

function _Fcreate_operations2(op)
	eval(quote 
			@generated Base.$op(n::StaticNumber{N}) where N = begin
				result = $op(N)
				return :(SFloat64{$result}())
			end
	 end)
end

function _Bcreate_operations(op)
	eval(quote 
			@generated Base.$op(n1::StaticNumber{N1},n2::StaticNumber{N2}) where{N1,N2} = begin
				result = $op(N1, N2)
				return :(SBool{$result}())
			end

			@generated Base.$op(n1::StaticNumber{N},n2::Number) where N = :(SBool{$op(N, $n2)}())
			@generated Base.$op(n1::Number,n2::StaticNumber{N}) where N = :(SBool{$op(N, $n1)}())
	 end)
end

generate_operations()