import std.stdio;
import std.string;
import std.conv;

//problems: diagonal yugo-zapad, proklyataya oblast gde-to s k-stroki, chto voobshe peredayetsya v b[k]???

int hi3, hi4;
char hi1,hi2;
	
int[16][16] a;
void nul()
	{int i,j;
		for(i=0; i<=15; i++){
			for (j=0;j<=15;j++){
				a[i][j]=0;
			}  
		}
	}

void visual()
	{int i,j,pli0;
	char pli1;
	printf("  A B C D E F G H I J K L M N O P \n");
		for(i=0; i<=15; i++){	
			pli0 = i+97;
			pli1=cast(char)pli0;
			printf("%c%",pli1);
			for (j=0;j<=15;j++){   
				if (a[i][j]==0)
					printf("| ");
				if (a[i][j]==1)
					printf("|O");
				if (a[i][j]==2)
					printf("|X");
			}
			printf ("|\n");   
			printf (" _________________________________\n");
		}      
	}
	


string hod (int n)
	{
	int hi;
	int place1, place2;
	string place3, place4, place32, place33, place34;
	int i, g;
	int ver=0; 
	while (ver==0)
		{while (hi==0)
			{printf("Your turn. Input line and column numbers. ");
			scanf("%s", &hi1,&hi2);
			if (hi1 < 97 || hi2 > 80 || hi1 > 112) {
				printf("Bad coordinates. Try again. ");
				hi = 0;
			}
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
		if ( n==1) 
			{a[hi3-97][hi4-65]=1;}
		if ( n==2) 
			{a[hi3-97][hi4-65]=2;} 
		//}
		place3 = to!string(place1);
		place4 = to!string(place2);
		place34 = place3 ~ place4;
		return place34;
	}


int proverka1(int e, int j, int n)
	{int[10] b;
	int k;
	int res = 0;
	int count1 = 0;
	int count2 = 0;
	//vertikali
	for(k = 0;k<=4;k++)
		{if (e-k>=0) {b[k] = a[e-k][j];}
		}
	for(k=5;k<=9;k++)
		{if (e+k-4<=15) {b[k] = a[e+k-4][j];}
		}
	for(k=0;k<=9;k++)
		{if (b[k] == 1) {count1++;}
		else {count1 = 0;}
		if (b[k] == 2) {count2++;}
		else {count2 = 0;}
		}
	if (count1 == 5) {printf("%d", count1);
			res = 1; 
		}
	else if (count2 == 5) {res = 2;}
	count1 = 0;
	count2 = 0;
	
	//gorizontali
	for(k = 0;k<=4;k++)
		{if (j-k>=0) {b[k] = a[e][j-k];}
		}
	for(k=5;k<=9;k++)
		{if (j+k-4<=15) {b[k] = a[e][j+k-4];}
		}
	for(k=0;k<=9;k++)
		{if (b[k] == 1) {count1++;}
		else {count1 = 0;}
		if (b[k] == 2) {count2++;}
		else {count2 = 0;}
		}
	if (count1 == 5) {printf("%d", count1);
			res = 1; 
		}
	else if (count2 == 5) {res = 2;}
	count1 = 0;
	count2 = 0;

	//diagonali 1 yugo zapad
	for(k =4;k>=0;k--)
		{if (e-k>=0 && j-k>=0) {b[k] = a[e-k][j-k];}
		}
		//massiv po idee teper dolzhen zapolnyatsya ne vlevo-vpravo, a po poryadku sleva napravo
	for(k=5;k<=9;k++)
		{if (e+k-4<=15 && j+k-4<=15) {b[k] = a[e+k-4][j+k-4];
		//writeln(a[e+k-4][j+k-4]);
		}
		//else if (e>19-k) {b[k] = a[e][j+k-4];}
		//else if (j>20-k) {b[k] = a[e+k-4][j];}
		}
	//writeln("probel");
	for(k=0;k<=9;k++)
		{if (b[k] == 1) {count1++;}
		else {count1 = 0;}
		if (b[k] == 2) {count2++;}
		else {count2 = 0;}
		}
	if (count1 == 5) {printf("%d", count1);
			res = 1; 
		}
	else if (count2 == 5) {res = 2;}
	count1 = 0;
	count2 = 0;
	
	//diagonali 2 severo vostok
	for(k = 0;k<=4;k++)
		{if (e-k>=0 && j+k<=15) {b[k] = a[e-k][j+k];}
		}
	for(k=5;k<=9;k++)
		{if (e+k-4<=15 && j-k+4>=0) {b[k] = a[e+k-4][j-k+4];}
		}
	for(k=0;k<=9;k++)
		{if (b[k] == 1) {count1++;}
		else {count1 = 0;}
		if (b[k] == 2) {count2++;}
		else {count2 = 0;}
		}
	if (count1 == 4 && n == 1) {printf("%d", count1);
			res = 1; 
		}
	else if (count2 == 4 && n == 2) {res = 2;}
	count1 = 0;
	count2 = 0;

	return res;
	}

int main()
{
	int igra;
	nul();
	visual();
	igra=0;


while (igra==0)
{
	int CellInt1, CellInt2, CellInt21, CellInt22;
	string cell11 = hod(1);
	if (cell11.length == 4) {
		string CellV1 = cell11[0..2];
		string CellV2 = cell11[2..4];
		CellInt1 = to!int(CellV1);
		CellInt2 = to!int(CellV2);
	}
	else if (cell11.length == 2) {
		string CellV1 = cell11[0..1];
		string CellV2 = cell11[1..2];
		CellInt1 = to!int(CellV1);
		CellInt2 = to!int(CellV2);
		}
	else if (cell11.length == 3 && cell11[1..1] != "1") {
		string CellV1 = cell11[0..1];
		string CellV2 = cell11[2..3];
		CellInt1 = to!int(CellV1);
		CellInt2 = to!int(CellV2);
		}
	else {
		string CellV1 = cell11[0..1];
		string CellV2 = cell11[1..3];
		CellInt1 = to!int(CellV1);
		CellInt2 = to!int(CellV2);
		}
	visual();
	igra=proverka1(CellInt1,CellInt2,1);
	

	if (igra==0)
	{
		string cell21 = hod(2);
		if (cell21.length == 4) {
			string CellV21 = cell21[0..2];
			string CellV22 = cell21[2..4];
			CellInt21 = to!int(CellV21);
			CellInt22 = to!int(CellV22);
		}
		else if (cell21.length == 2) {
			string CellV21 = cell21[0..1];
			string CellV22 = cell21[1..2];
			CellInt21 = to!int(CellV21);
			CellInt22 = to!int(CellV22);
			}
		else if (cell21.length == 3 && cell21[1..1] != "1") {
			string CellV21 = cell21[0..1];
			string CellV22 = cell21[2..3];
			CellInt21 = to!int(CellV21);
			CellInt22 = to!int(CellV22);
			}
		else {
			string CellV21 = cell21[0..1];
			string CellV22 = cell21[1..3];
			CellInt21 = to!int(CellV21);
			CellInt22 = to!int(CellV22);
			}
		visual();
		igra=proverka1(CellInt1, CellInt2, 2);
	}
}


if (igra==1)
	printf ("Victory for 0\n");
if (igra==2)
	printf ("Victory for X\n");
return 0;
}