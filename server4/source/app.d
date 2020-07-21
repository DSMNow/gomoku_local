import std.stdio;
import std.string;
import std.socket;
import std.conv;
import std.stdio: writeln;
import std.typecons: tuple, Tuple;
import vibe.vibe;
import std.regex;
import std.algorithm;
import core.stdc.stdlib;
import core.stdc.string;
import std.array;


class Game {

	int[15][15] a;
	
	string[10] vert;
	string[10] gor;
	string[10] NW;
	string[10] SW;
	
	int igra;
	
	int n;
	
	alias Position = Tuple!(char, char);
	
	alias Position1 = Tuple!(int, int);
	
	alias Position2 = Tuple!(int, string);
	
	int freeCells = 225;

	
	
	enum int[string] hashAt =  ["22222": 99999, "022220": 7000, "22220": 4000, "02222": 4000, 
		"020222": 2000,
		"022022": 2000,
		"022202": 2000,
		"222020": 2000,
		"220220": 2000,
		"202220": 2000,
		"02220": 3000,
		"0222": 1500,
		"2220": 1500,
		"22020": 800,
		"02202": 800,
		"02022": 800,
		"20220": 800,
		"0220": 200];
		
	enum int[string] hashDef =  ["11111": 99999, "011110": 7000, "11110": 4000, "01111": 4000, 
		"010111": 2000,
		"011011": 2000,
		"011101": 2000,
		"111010": 2000,
		"110110": 2000,
		"101110": 2000,
		"01110": 3000,
		"0111": 1500,
		"1110": 1500,
		"11010": 800,
		"01101": 800,
		"01011": 800,
		"10110": 800,
		"0110": 200];
			
		
	int[Position] maspothod;

	int[Position] masmaxhod;
	
	
	void nul()
	{int i,j;
		for(i=0; i<=14; i++){
			for (j=0;j<=14;j++){
				a[i][j]=0;
			}  
		}
	}

	void visual()
	{int i,j,pli0;
	char pli1;
	printf("  A B C D E F G H I J K L M N O \n");
		for(i=0; i<=14; i++){	
			pli0 = i+97;
			pli1=cast(char)pli0;
			printf("%c%",pli1);
			for (j=0;j<=14;j++){   
				if (a[i][j]==0)
					printf("| ");
				if (a[i][j]==1)
					printf("|O");
				if (a[i][j]==2)
					printf("|X");
			}
			printf ("|\n");   
			printf (" ________________________________\n");
		}      
	}
	
	Position hod () {
	int hi, hi3, hi4, place1, place2;
	char hi1, hi2;
	string place3, place4, place34;
	int i, g;
	int ver=0; 
	while (ver==0)
		{while (hi==0)
			{printf("Your turn. Input line and column numbers. ");
			scanf("%s", &hi1,&hi2);
			if (hi1 < 97 || hi2 > 80 || hi1 > 112 || hi2 < 65) {
				printf("Bad coordinates. Try again. ");
				hi = 0;
			}
			if (a[(cast(int)hi1)-97][(cast(int)hi2)-65] != 0)
				{printf("Bad coordinates. Try again. ");
				hi = 0;}
			else {
			hi3 = cast(int) hi1;
			hi4 = cast(int) hi2;
			hi = 1;
			}
		}
		printf("%d%d\n", hi3, hi4);
			for (i = 97; i <= 112; i++){
				for (g = 65; g <= 80; g++){
					if (hi3 == i && hi4 == g && a[hi3-97][hi4-65] == 0) {
							(ver++);
							place1 = hi3-97;
							place2 = hi4-65;
							
					}
				}
			}
		}
		if ( n==1 && a[hi3-97][hi4-65] == 0) 
			{a[hi3-97][hi4-65]=1;}
		if ( n==2 && a[hi3-97][hi4-65] == 0) 
			{a[hi3-97][hi4-65]=2;} 
		return tuple(hi1, hi2);
	}
	
	Position aihod(string otch34) {
	int otch3 = to!int(otch34[0]);
	int otch4 = to!int(otch34[1]);
	int posk;
	int proto_max = 0;
	int maxc = 0;
	int CollInt1, CollInt2;
	string znachens1, znachens2, znachens3, znachens4, coorda, coordd;
	char lcoorda, rcoorda, lcoordd, rcoordd;
	int i,j,cellco;
	char otch1, otch2;
	char aic1, aic2;
	string choiceholder;
	auto resp1 = tuple(10, "aO");
	auto resp2 = tuple(10, "aO");
		for(i=0; i<=14; i++){
			for (j=0;j<=14;j++){
				if (a[i][j]==0) {
					cellco++;
					}		
				else {maspothod.remove(tuple((cast(char)(i+96)),(cast(char)(j+65))));}
			}  
		}
	if (cellco == 225) {a[7][7] = 2;
						otch3 = 7;
						otch4 = 7;}

	otch3 = otch3-97;
	otch4 = otch4-65;
	
	//vertikal
	
	if (otch3 <= 13) {
		if (a[otch3+1][otch4] == 0) {
			maspothod[tuple((cast(char)(otch3+98)),(cast(char)(otch4+65)))] = 200;
		}
	}
	
	if (otch3 <= 12) {
		if (a[otch3+1][otch4] == 0 && a[otch3+2][otch4] == 0) {
			maspothod[tuple((cast(char)(otch3+98)),(cast(char)(otch4+65)))] = 200;
			maspothod[tuple((cast(char)(otch3+99)),(cast(char)(otch4+65)))] = 100;
		}
	}
	
	if (otch3 >= 1) {
		if (a[otch3-1][otch4] == 0) {
			maspothod[tuple((cast(char)(otch3+96)),(cast(char)(otch4+65)))] = 200;
		}
	}
	
	if (otch3 >= 2) { 
		if (a[otch3-1][otch4] == 0 && a[otch3-2][otch4] == 0) {
			maspothod[tuple((cast(char)(otch3+96)),(cast(char)(otch4+65)))] = 200;
			maspothod[tuple((cast(char)(otch3+95)),(cast(char)(otch4+65)))] = 100;
		}
	}
	
	//gorizontal
	if (otch4 <= 13) {
		if (a[otch3][otch4+1] == 0) {
			maspothod[tuple((cast(char)(otch3+97)),(cast(char)(otch4+66)))] = 200;
		}
	}
	
	if (otch4 <= 12) {
		if (a[otch3][otch4+1] == 0 && a[otch3][otch4+2] == 0) {
			maspothod[tuple((cast(char)(otch3+97)),(cast(char)(otch4+66)))] = 200;
			maspothod[tuple((cast(char)(otch3+97)),(cast(char)(otch4+67)))] = 100;
		}
	}
	
	if (otch4 >= 1) {
		if (a[otch3][otch4-1] == 0) {
			maspothod[tuple((cast(char)(otch3+97)),(cast(char)(otch4+64)))] = 200;
		}
	}
	
	if (otch4 >= 2) {
		if (a[otch3][otch4-1] == 0 && a[otch3][otch4-2] == 0) {
			maspothod[tuple((cast(char)(otch3+97)),(cast(char)(otch4+64)))] = 200;
			maspothod[tuple((cast(char)(otch3+97)),(cast(char)(otch4+63)))] = 100;
		}
	}
	
	//yugo vostok 
	if (otch3 <= 13 && otch4 <= 13) {
		if (a[otch3+1][otch4+1] == 0) {
			maspothod[tuple((cast(char)(otch3+98)),(cast(char)(otch4+66)))] = 200;
		}
	}
	
	if (otch3 <= 12 && otch4 <= 12) {
		if (a[otch3+1][otch4+1] == 0 && a[otch3+2][otch4+2] == 0) {
			maspothod[tuple((cast(char)(otch3+98)),(cast(char)(otch4+66)))] = 200;
			maspothod[tuple((cast(char)(otch3+99)),(cast(char)(otch4+67)))] = 100;
		}
	}
	
	if (otch3 >= 1 && otch4 >= 1) {
		if (a[otch3-1][otch4-1] == 0) {
			maspothod[tuple((cast(char)(otch3+97)),(cast(char)(otch4+64)))] = 200;
		}
	}
	
	if (otch3 >= 2 && otch4 >= 2) {
		if (a[otch3-1][otch4-1] == 0 && a[otch3-2][otch4-2] == 0) {
			maspothod[tuple((cast(char)(otch3+97)),(cast(char)(otch4+64)))] = 200;
			maspothod[tuple((cast(char)(otch3+96)),(cast(char)(otch4+63)))] = 100;
		}
	}
	
	//severo vostok
	if (otch3 <= 13 && otch4 >= 1) {
		if (a[otch3+1][otch4-1] == 0) {
			maspothod[tuple((cast(char)(otch3+98)),(cast(char)(otch4+64)))] = 200;
		}
	}
	
	if (otch3 <= 12 && otch4 >= 2) {
		if (a[otch3+1][otch4-1] == 0 && a[otch3+2][otch4-2] == 0) {
			maspothod[tuple((cast(char)(otch3+98)),(cast(char)(otch4+64)))] = 200;
			maspothod[tuple((cast(char)(otch3+99)),(cast(char)(otch4+63)))] = 100;
		}
	}
	
	if (otch3 >= 1 && otch4 <= 13) {
		if (a[otch3-1][otch4+1] == 0) {
			maspothod[tuple((cast(char)(otch3+96)),(cast(char)(otch4+66)))] = 200;
		}
	}
	
	if (otch3 >= 2 && otch4 <= 12) {
		if (a[otch3-1][otch4+1] == 0 && a[otch3-2][otch4+2] == 0) {
			maspothod[tuple((cast(char)(otch3+96)),(cast(char)(otch4+66)))] = 200;
			maspothod[tuple((cast(char)(otch3+95)),(cast(char)(otch4+67)))] = 100;
		}
	} 
	
	foreach (Position posit; maspothod.byKey) {
		if (posit[0] < 'a' || posit[0] > 'o' || posit[1] < 'A' || posit[1] > 'O') {
			maspothod.remove(tuple((posit[0]),(posit[1])));
		}
	}
	
	foreach (Position posit; maspothod.byKey) {
		auto coords = posit;
		CollInt1 = (to!int(coords[0]))-97;
		CollInt2 = (to!int(coords[1]))-65;
		int iii = 10;	
		for(posk = 0;posk<=4;posk++)
			{if (CollInt1 >= 0 && CollInt2 >= 0 && CollInt1 <= 14 && CollInt2 <= 14 && CollInt1-(4-posk)>=0) {vert[posk] = to!string(a[CollInt1-(4-posk)][CollInt2]);}
			if (CollInt1 >= 0 && CollInt2 >= 0 && CollInt1 <= 14 && CollInt2 <= 14 && CollInt2-(4-posk)>=0) {gor[posk] = to!string(a[CollInt1][CollInt2-(4-posk)]);}
			if (CollInt1 >= 0 && CollInt2 >= 0 && CollInt1 <= 14 && CollInt2 <= 14 && CollInt1-(4-posk)>=0 && CollInt2-(4-posk)>=0) {NW[posk] = to!string(a[CollInt1-(4-posk)][CollInt2-(4-posk)]);}
			if (CollInt1 >= 0 && CollInt2 >= 0 && CollInt1 <= 14 && CollInt2 <= 14 && CollInt1-(4-posk)>=0 && CollInt2+(4-posk)<=14) 
			{SW[posk] = to!string(a[CollInt1-(4-posk)][CollInt2+(4-posk)]);}
		}
                
		for(posk=5;posk<=9;posk++)
			{if (CollInt1 >= 0 && CollInt2 >= 0 && CollInt1 <= 14 && CollInt2 <= 14 && CollInt1+posk-4<=14) {vert[posk] = to!string(a[CollInt1+posk-4][CollInt2]);}
			if (CollInt1 >= 0 && CollInt2 >= 0 && CollInt1 <= 14 && CollInt2 <= 14 && CollInt2+posk-4<=14) {gor[posk] = to!string(a[CollInt1][CollInt2+posk-4]);}
			if (CollInt1 >= 0 && CollInt2 >= 0 && CollInt1 <= 14 && CollInt2 <= 14 && CollInt1+posk-4<=14 && CollInt2+posk-4<=14) {NW[posk] = to!string(a[CollInt1+posk-4][CollInt2+posk-4]);}
			if (CollInt1 >= 0 && CollInt2 >= 0 && CollInt1 <= 14 && CollInt2 <= 14 && CollInt1+posk-4<=14 && CollInt2-posk+4>=0) {SW[posk] = to!string(a[CollInt1+posk-4][CollInt2-posk+4]);}
				}	

		
		if (coords[0] < 'a' || coords[0] > 'o' || coords[1] < 'A' || coords[1] > 'O') {
			maspothod.remove(tuple((coords[0]),(coords[1])));
			}

		attack(CollInt1, CollInt2);
		defense(CollInt1, CollInt2);
	}

	foreach (Position posit; maspothod.byKey) {
		if (posit[0] < 'a' || posit[0] > 'o' || posit[1] < 'A' || posit[1] > 'O') {
			maspothod.remove(tuple((posit[0]),(posit[1])));
		}
	}

	auto zaholder = maspothod.byPair
			.fold!((a,b) => a[1] < b[1] ? b : a)[0];
	aic1 = zaholder[0];
	aic2 = zaholder[1];

		while (a[to!int(aic1)-97][to!int(aic2)-65] != 0)
		{maspothod.remove(zaholder);
			zaholder = maspothod.byPair
				.fold!((a,b) => a[1] < b[1] ? b : a)[0];
			aic1 = zaholder[0];
			aic2 = zaholder[1];
		}

		if (a[to!int(aic1)-97][to!int(aic2)-65] == 0) {
			a[to!int(aic1)-97][to!int(aic2)-65]=2;
		}
				
		return tuple(aic1, aic2);	
	}
	
	void attack(int AttCollInt1, int AttCollInt2) {
		string sa1, sa2, sa3, sa4;
		int elemo;
		int [225] maxArray;
		Position [225] atakArray;
		string idi;
		foreach (string ki; vert) {
			sa1 ~= ki;
		}

		foreach (string ki; gor) {
			sa2 ~= ki;
		}

		foreach (string ki; NW) {
			sa3 ~= ki;
		}

		foreach (string ki; SW) {
			sa4 ~= ki;
		}

		foreach (string iterator; hashAt.byKey) {
			if (canFind(sa1, iterator)) {
				char* istr = strstr((cast(char*)(sa1)), (cast(char*)(iterator)));
				for (int si = ((cast(int)(*istr))-48); si <= iterator.length; si++) {
					if (sa1[si] == '0' && si < 5) {
						maspothod[tuple(to!char(AttCollInt1-(4-si)+97), to!char(AttCollInt2+65))] += hashAt[iterator];
					}
					if (sa1[si] == '0' && si >= 5) {
						maspothod[tuple(to!char(AttCollInt1+si+93), to!char(AttCollInt2+65))] += hashAt[iterator];
					}
				}
			}

			if (canFind(sa2,iterator)) {
				char* istr = strstr((cast(char*)(sa2)), (cast(char*)(iterator)));
				for (int si = ((cast(int)(*istr))-48); si <= iterator.length; si++) {
					if (sa2[si] == '0' && si < 5) {
						maspothod[tuple(to!char(AttCollInt1+97), to!char(AttCollInt2-(4-si)+65))] += hashAt[iterator];
					}
					if (sa2[si] == '0' && si >= 5) {
						maspothod[tuple(to!char(AttCollInt1+97), to!char(AttCollInt2+si+61))] += hashAt[iterator];
					}
				}
			}

			if (canFind(sa3,iterator)) {
				char* istr = strstr((cast(char*)(sa3)), (cast(char*)(iterator)));
				for (int si = ((cast(int)(*istr))-48); si <= iterator.length; si++) {
					if (sa3[si] == '0' && si < 5) {
						maspothod[tuple(to!char(AttCollInt1-(4-si)+97), to!char(AttCollInt2-(4-si)+65))] += hashAt[iterator];
					}
					if (sa3[si] == '0' && si >= 5) {
						maspothod[tuple(to!char(AttCollInt1+si+93), to!char(AttCollInt2+si+61))] += hashAt[iterator];
					}
				}
			}

			if (canFind(sa4,iterator)) {
				char* istr = strstr((cast(char*)(sa4)), (cast(char*)(iterator)));
				for (int si = ((cast(int)(*istr))-48); si <= iterator.length; si++) {
					if (SW[si] == "0" && si < 5) {
						maspothod[tuple(to!char(AttCollInt1-(4-si)+97), to!char(AttCollInt2+(4-si)+65))] += hashAt[iterator];
					}
					if (SW[si] == "0" && si >= 5) {
						maspothod[tuple(to!char(AttCollInt1+si+93), to!char(AttCollInt2-si+69))] += hashAt[iterator];
					}
				}
			}
		}

		sa1 = null;
		sa2 = null;
		sa3 = null;
		sa4 = null;
	}


	void defense(int DefCollInt1, int DefCollInt2) {
		string sd1, sd2, sd3, sd4;
		int [225] maxArray;
		Position [225] zashArray;
		int elemo = 0;
		foreach (string ki; vert) {
			sd1 ~= ki;
		}

		foreach (string ki; gor) {
			sd2 ~= ki;
		}

		foreach (string ki; NW) {
			sd3 ~= ki;
		}

		foreach (string ki; SW) {
			sd4 ~= ki;
		}

		foreach (string diterator; hashDef.byKey) {
			if (canFind(sd1, diterator)) {
				char* istr = strstr((cast(char*)(sd1)), (cast(char*)(diterator)));
				for (int si = ((cast(int)(*istr))-48); si <= diterator.length; si++) {
					if (sd1[si] == '0' && si < 5) {
						maspothod[tuple(to!char(DefCollInt1-(4-si)+97), to!char(DefCollInt2+65))] += hashDef[diterator];
					}
					if (sd1[si] == '0' && si >= 5) {
						maspothod[tuple(to!char(DefCollInt1+si+93), to!char(DefCollInt2+65))] += hashDef[diterator];
					}
				}
			}

			if (canFind(sd2,diterator)) {
				char* istr = strstr((cast(char*)(sd2)), (cast(char*)(diterator)));
				for (int si = ((cast(int)(*istr))-48); si <= diterator.length; si++) {
					if (sd2[si] == '0' && si < 5) {
						maspothod[tuple(to!char(DefCollInt1+97), to!char(DefCollInt2-(4-si)+65))] += hashDef[diterator];
					}
					if (sd2[si] == '0' && si >= 5) {
						maspothod[tuple(to!char(DefCollInt1+97), to!char(DefCollInt2+si+61))] += hashDef[diterator];
					}
				}
			}

			if (canFind(sd3,diterator)) {
				char* istr = strstr((cast(char*)(sd3)), (cast(char*)(diterator)));
				for (int si = ((cast(int)(*istr))-48); si <= diterator.length; si++) {
					if (sd3[si] == '0' && si < 5) {
						maspothod[tuple(to!char(DefCollInt1-(4-si)+97), to!char(DefCollInt2-(4-si)+65))] += hashDef[diterator];
					}
					if (sd3[si] == '0' && si >= 5) {
						maspothod[tuple(to!char(DefCollInt1+si+93), to!char(DefCollInt2+si+61))] += hashDef[diterator];
					}
				}
			}

			if (canFind(sd4,diterator)) {
				char* istr = strstr((cast(char*)(sd4)), (cast(char*)(diterator)));
				for (int si = ((cast(int)(*istr))-48); si <= diterator.length; si++) {
					if (SW[si] == "0" && si < 5) {
						maspothod[tuple(to!char(DefCollInt1-(4-si)+97), to!char(DefCollInt2+(4-si)+65))] += hashDef[diterator];
					}
					if (SW[si] == "0" && si >= 5) {
						maspothod[tuple(to!char(DefCollInt1+si+93), to!char(DefCollInt2-si+69))] += hashDef[diterator];
					}
				}
			}
		}
		sd1 = null;
		sd2 = null;
		sd3 = null;
		sd4 = null;
	}
			
				
		


int proverka(int e, int j, int n)
	{int[10] b;
	int[10] c;
	int k;
	int res = 0;
	int count11, count12, count13, count14 = 0;
	int count21, count22, count23, count24 = 0;
	//vertikali
	for(k = 0;k<=4;k++)
	{if (e-(4-k)>=0) 
		{b[k] = a[e-(4-k)][j];}
	}
	for(k=5;k<=9;k++)
	{if (e+k-4<=14) 
		{b[k] = a[e+k-4][j];}
	}
	if (b[0..5] == [1, 1, 1, 1, 1] || b[1..6] == [1, 1, 1, 1, 1] || b[2..7] == [1, 1, 1, 1, 1] || b[3..8] == [1, 1, 1, 1, 1] || b[4..9] == [1, 1, 1, 1, 1] || b[$-5..$] == [1, 1, 1, 1, 1]) {count11 = 5;} 
	else {count11 = count11;}
	if (b[0..5] == [2, 2, 2, 2, 2] || b[1..6] == [2, 2, 2, 2, 2] || b[2..7] == [2, 2, 2, 2, 2] || b[3..8] == [2, 2, 2, 2, 2]|| b[4..9] == [2, 2, 2, 2, 2] || b[$-5..$] == [2, 2, 2, 2, 2]) {count21 = 5;}
	else {count21 = count21;}

	if (count11 == 5) {printf("%d", count11);
		res = 1; 
	}
	if (count21 == 5) {printf("%d", count21);
		res = 2;
	}

	//gorizontali
	for(k = 0;k<=4;k++)
	{if (j-(4-k)>=0) 
		{b[k] = a[e][j-(4-k)];}
	}
	for(k=5;k<=9;k++)
	{if (j+k-4<=14) 
		{b[k] = a[e][j+k-4];}
	}
	
	if (b[0..5] == [1, 1, 1, 1, 1] || b[1..6] == [1, 1, 1, 1, 1] || b[2..7] == [1, 1, 1, 1, 1] || b[3..8] == [1, 1, 1, 1, 1] || b[4..9] == [1, 1, 1, 1, 1] || b[$-5..$] == [1, 1, 1, 1, 1]) {count12 = 5;} 
	else {count12 = count12;}
	if (b[0..5] == [2, 2, 2, 2, 2] || b[1..6] == [2, 2, 2, 2, 2] || b[2..7] == [2, 2, 2, 2, 2] || b[3..8] == [2, 2, 2, 2, 2]|| b[4..9] == [2, 2, 2, 2, 2] || b[$-5..$] == [2, 2, 2, 2, 2]) {count22 = 5;}
	else {count22 = count22;}

	if (count12 == 5) {printf("%d", count12);
		res = 1; 
	}
	if (count22 == 5) {res = 2;}

	//diagonali 1 yugo vostok
	for(k = 4;k>=0;k--)
	{if (e-(4-k)>=0 && j-(4-k)>=0) 
		{b[k] = a[e-(4-k)][j-(4-k)];} //severo zapad
	}
	for(k=5;k<=9;k++)
	{if (e+k-4<=14 && j+k-4<=14) 
		{b[k] = a[e+k-4][j+k-4]; //yugo vostok
		}
	}

	if (b[0..5] == [1, 1, 1, 1, 1] || b[1..6] == [1, 1, 1, 1, 1] || b[2..7] == [1, 1, 1, 1, 1] || b[3..8] == [1, 1, 1, 1, 1] || b[4..9] == [1, 1, 1, 1, 1] || b[$-5..$] == [1, 1, 1, 1, 1]) {count13 = 5;} 
	else {count13 = count13;}
	if (b[0..5] == [2, 2, 2, 2, 2] || b[1..6] == [2, 2, 2, 2, 2] || b[2..7] == [2, 2, 2, 2, 2] || b[3..8] == [2, 2, 2, 2, 2]|| b[4..9] == [2, 2, 2, 2, 2] || b[$-5..$] == [2, 2, 2, 2, 2]) {count23 = 5;}
	else {count23 = count23;}

	if (count13 == 5) {printf("%d", count13);
		res = 1; 
	}
	if (count23 == 5) {res = 2;}


	//diagonali 2 severo zapad
	for(k = 0;k<=4;k++)
	{if (e-(4-k)>=0 && j+(4-k)<=14) 
		{b[k] = a[e-(4-k)][j+(4-k)];} // severo vostok
	}
	for(k=5;k<=9;k++)
	{if (e+k-4<=14 && j-k+4>=0) 
		{b[k] = a[e+k-4][j-k+4];} // yugo zapad
	}
	if (b[0..5] == [1, 1, 1, 1, 1] || b[1..6] == [1, 1, 1, 1, 1] || b[2..7] == [1, 1, 1, 1, 1] || b[3..8] == [1, 1, 1, 1, 1] || b[4..9] == [1, 1, 1, 1, 1] || b[$-5..$] == [1, 1, 1, 1, 1]) {count14 = 5;}
	else {count14 = count14;}
	if (b[0..5] == [2, 2, 2, 2, 2] || b[1..6] == [2, 2, 2, 2, 2] || b[2..7] == [2, 2, 2, 2, 2] || b[3..8] == [2, 2, 2, 2, 2]|| b[4..9] == [2, 2, 2, 2, 2] || b[$-5..$] == [2, 2, 2, 2, 2]) {count24 = 5;}
	else {count24 = count24;}

	if (count14 == 5) {printf("%d", count14);
			res = 1; 
		}
	if (count24 == 5) {res = 2;}
	count14 = 0;
	count24 = 0;

	return res;
	}

}


void main()
{

	listenTCP(8080,(conn) {
	Game game = new Game();
	string input;
	game.nul();
	game.visual();
	game.igra = 0;
	game.n = 1;
	int CellInt1, CellInt2, CellInt21, CellInt22;

			while (game.igra==0)
			
			{
			if (game.n == 2) 
			{auto res1 = game.aihod(input);
			CellInt1 = to!int(res1[0]);
			CellInt2 = to!int(res1[1]);
			input = (to!string(res1[0]))~(to!string(res1[1]));
			conn.write(input~"\r\n");
			game.igra=game.proverka(CellInt1-97,CellInt2-65,1);
			game.visual();
			game.n = 1;
			}				

			else
				{game.n = 1;
				writeln("The second player will now make a turn.");
				input = cast(string)conn.readLine();
				CellInt21 = to!int(input[0]);
				CellInt22 = to!int(input[1]);
				if (input == "END") {
										game.n = 2;
										writeln("Your opponent gives up for the time being");
										break;
										}
				else {
					writeln("The other player went here: ", CellInt21, CellInt22);
					if (game.a[CellInt21-97][CellInt22-65] == 0) {
						game.a[CellInt21-97][CellInt22-65] = 1;
					}
					game.visual();
					game.igra=game.proverka(CellInt21-97, CellInt22-65, 1);
					}
				game.n = 2;
				}
				

			}



if (game.igra==1)
	printf ("\nVictory for 0\n");

if (game.igra==2)
	printf ("\nVictory for X\n");

});
runApplication();
}
	

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("Hello, World!");
}
