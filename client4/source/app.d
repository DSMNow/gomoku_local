import vibe.vibe;
import std.stdio;
import std.string;
import std.socket;
import std.conv;
import std.stdio: writeln;
import std.typecons: tuple, Tuple;

class Game {

	int[15][15] a;
	
	int igra;
	
	int n;
	
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
	
	alias Position = Tuple!(char, char);
	
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
		{b[k] = a[e-(4-k)][j+(4-k)];} // severo vostok i mb prosto j+k?
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

	runTask({{
	auto conn = connectTCP("127.0.0.1", 8080);
	Game game = new Game();
	string input;
	game.nul();
	game.visual();
	game.igra = 0;
	game.n = 1;

			while (game.igra==0)
			  
			{
			if (game.n == 1) 
			{auto res1 = game.hod();
			int CellInt1 = to!int(res1[0]);
			int CellInt2 = to!int(res1[1]);
			input = (to!string(res1[0]))~(to!string(res1[1]));
			conn.write(input~"\r\n");
			game.igra=game.proverka(CellInt1-97,CellInt2-65,1);
			game.visual();
			game.n = 2;
			}
	
			else if (game.n == 2)
 				{writeln("The second player will now make a turn.");
				input = cast(string)conn.readLine();
				int CellInt21 = to!int(input[0]);
				int CellInt22 = to!int(input[1]);
				if (input == "END") {
										game.n = 1;
										writeln("Your opponent gives up for the time being");
										break;
										}
				else {
					writeln("The other player went here: ", CellInt21, CellInt22);
					if (game.a[CellInt21-97][CellInt22-65] == 0) {
						game.a[CellInt21-97][CellInt22-65] = 2;
					}
					game.visual();
					game.igra=game.proverka(CellInt21-97, CellInt22-65, 2);
					}
				game.n = 1;
				}
				
				
			}


			if (game.igra==1)
				printf ("\nVictory for 0\n");

			if (game.igra==2)
				printf ("\nVictory for X\n");
			}});	
			runApplication();
			}
	

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("Hello, World!");
}