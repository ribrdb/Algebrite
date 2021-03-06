test_test = ->
	run_test [
		"a<a+1",
		"1",

		"a-1<a",
		"1",

		"0==-0",
		"1",

		"0!=-0",
		"0",

		"1==1",
		"1",

		"1==2",
		"0",

		"1!=1",
		"0",

		"1!=2",
		"1",

		"1>=1",
		"1",

		"1>=2",
		"0",

		"2>=1",
		"1",

		"1>1",
		"0",

		"1>2",
		"0",

		"2>1",
		"1",

		"1<=1",
		"1",

		"1<=2",
		"1",

		"2<=1",
		"0",

		"1<1",
		"0",

		"1<2",
		"1",

		"2<1",
		"0",

		"-1<-2",
		"0",

		"-2<-1",
		"1",

		"test(0,A,B)",
		"B",

		"test(1,A,B)",
		"A",

		"test(0,A,0,B)",
		"0",

		"test(0,A,0,B,C)",
		"C",

		"test(x<3,-x-4,3<=x,x*x+7,120/x+5)",
		"test(testlt(x,3),-x-4,testle(3,x),x^2+7,120/x+5)",

		"x = -1",
		"",

		"test(x<1,-x-4,3<=x,x*x+7,120/x+5)",
		"-3",

		"x = 3",
		"",

		"test(x<1,-x-4,3<=x,x*x+7,120/x+5)",
		"16",

		"x = 2",
		"",

		"test(x<1,-x-4,3<=x,x*x+7,120/x+5)",
		"65",

		"x=quote(x)",
		"",

		"not(1)",
		"0",

		"not(0)",
		"1",

		"not(a=a)",
		"0",

		"and(1,1)",
		"1",

		"and(1,0)",
		"0",

		"and(a=a,b=b)",
		"1",

		"or(1,0)",
		"1",

		"or(0,0)",
		"0",

		"[0,0]==0",
		"1",

		"1<sqrt(3)",
		"1",

		"cos(x)^2 + sin(x)^2 == 1",
		"1",

		"cos(x)^2 + sin(x)^2 >= 1",
		"1",

		"cos(x)^2 + sin(x)^2 <= 1",
		"1",

		"cos(x)^2 + sin(x)^2 < 1",
		"0",

		"cos(x)^2 + sin(x)^2 + 1 > 1",
		"1",

		"x + x > x",
		"Stop: relational operator: cannot determine due to non-numerical comparison of x",
	]

