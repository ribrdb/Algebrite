# If the number of args is odd then the last arg is the default result.



Eval_test = ->
	orig = p1
	p1 = cdr(p1)
	while (iscons(p1))

		# odd number of parameters means that the
		# last argument becomes the default case
		# i.e. the one without a test.
		if (cdr(p1) == symbol(NIL))
			push(car(p1)); # default case
			Eval()
			return
		
		# load the next test and eval it
		push(car(p1))
		Eval_predicate()
		p2 = pop()
		if isone(p2)
			# test succesful, we found out output
			push(cadr(p1))
			Eval()
			return
		else if !iszero(p2)
			# we couldn't determine the result
			# of a test. This means we can't conclude
			# anything about the result of the
			# overall test, so we must bail
			# with the unevalled test
			push orig
			return

		# test unsuccessful, continue to the
		# next pair of test,value
		p1 = cddr(p1)

	# no test matched and there was no
	# catch-all case, so we return zero.
	push_integer 0

# The test for equality is weaker than the other relational operators.

# For example, A<=B causes a stop when the result of A minus B is not a
# numerical value.

# However, A==B never causes a stop.

# For A==B, any nonzero result for A minus B indicates inequality.

Eval_testeq = ->
	# first try without simplifyng both sides
	push(cadr(p1))
	Eval()
	push(caddr(p1))
	Eval()
	subtract()
	subtractionResult = pop()
	if (iszero(subtractionResult))
		p1 = subtractionResult
		push_integer(1)
	else
		# they don't seem equal but
		# let's try again after doing
		# a simplification on both sides
		push(cadr(p1))
		Eval()
		simplify()
		push(caddr(p1))
		Eval()
		simplify()
		subtract()
		p1 = pop()
		if (iszero(p1))
			push_integer(1)
		else
			push_integer(0)

# Relational operators expect a numeric result for operand difference.

Eval_testge = ->
	if (cmp_args() >= 0)
		push_integer(1)
	else
		push_integer(0)

Eval_testgt = ->
	if (cmp_args() > 0)
		push_integer(1)
	else
		push_integer(0)

Eval_testle = ->
	if (cmp_args() <= 0)
		push_integer(1)
	else
		push_integer(0)

Eval_testlt = ->
	if (cmp_args() < 0)
		push_integer(1)
	else
		push_integer(0)

# not definition
Eval_not = ->
	push(cadr(p1))
	Eval_predicate()
	p1 = pop()
	if (iszero(p1))
		push_integer(1)
	else
		push_integer(0)

### and =====================================================================

Tags
----
scripting, JS, internal, treenode, general concept

Parameters
----------
a,b,...

General description
-------------------
Logical-and of predicate expressions.

###

# and definition
Eval_and = ->
	p1 = cdr(p1)
	while (iscons(p1))
		push(car(p1))
		Eval_predicate()
		p2 = pop()
		if (iszero(p2))
			push_integer(0)
			return
		p1 = cdr(p1)
	push_integer(1)

# or definition
Eval_or = ->
	p1 = cdr(p1)
	while (iscons(p1))
		push(car(p1))
		Eval_predicate()
		p2 = pop()
		if (!iszero(p2))
			push_integer(1)
			return
		p1 = cdr(p1)
	push_integer(0)

# use subtract for cases like A < A + 1

# TODO you could be smarter here and
# simplify both sides only in the case
# of "relational operator: cannot determine..."
# a bit like we do in Eval_testeq
cmp_args = ->
	t = 0

	push(cadr(p1))
	Eval()
	simplify()
	push(caddr(p1))
	Eval()
	simplify()
	subtract()
	p1 = pop()

	# try floating point if necessary

	if (p1.k != NUM && p1.k != DOUBLE)
		push(p1)
		yyfloat()
		Eval()
		p1 = pop()

	if (iszero(p1))
		return 0

	switch (p1.k)
		when NUM
			if (MSIGN(p1.q.a) == -1)
				t = -1
			else
				t = 1
		when DOUBLE
			if (p1.d < 0.0)
				t = -1
			else
				t = 1
		else
			stop("relational operator: cannot determine due to non-numerical comparison of " + p1)
			t = 0

	return t


