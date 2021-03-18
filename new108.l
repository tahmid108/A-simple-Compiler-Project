var [a-zA-Z]
digit [0-9]

%{
int i,cnt_keyword=0,cnt_operator=0,cnt_identifier=0,cnt_punctuation=0, cnt_header=0;
int k=0,ch_start_k=0,ch_finish_k=0;
int id=0;
int op=0, ch_op=0, pt;
int pc=0, cnt_pc=0, ch_pc=0,ch_b_pc=0;
char keyword[100][100];
char operator[100][100];
char identifier[100][100];
char punctuation[100][100];
char header[100][100];
%}

%%
",,""inc"[ ]+({var})+	{
header[cnt_header][0]='i';
header[cnt_header][1]='n';
header[cnt_header][2]='c';
cnt_header++;
printf("Header is found\n");
punctuation[cnt_punctuation][0]=',';
punctuation[cnt_punctuation++][1]=',';

}

\n

"getstarted"":"	{
printf("Main Function Starts\n");
for(i=0; i<yyleng; i++){
keyword[cnt_keyword][i]=yytext[i];
}
cnt_keyword++;
punctuation[cnt_punctuation++][0]=':';
}


"finish" {
for(i=0; i<yyleng; i++){
keyword[cnt_keyword][i]=yytext[i];
}
cnt_keyword++;
printf("Main Function Finished\n");
printf("\n\nHeader Found:\n");
for(i=0; i<cnt_header; i++){
        printf("%d. %s\n",i+1,header+i);
}
printf("\nKeyword Found:\n");
for(i=0; i<cnt_keyword; i++){
        printf("%d. %s\n",i+1,keyword+i);
}
printf("\nOperator Found:\n");
for(i=0; i<cnt_operator; i++){
        printf("%d. %s\n",i+1,operator+i);
}
printf("\nIdentifier Found:\n");
for(i=0; i<cnt_identifier; i++){
        printf("%d. %s\n",i+1,identifier+i);
}
printf("\nPunctuation Found:\n");
for(i=0; i<cnt_punctuation; i++){
        printf("%d. %s\n",i+1,punctuation+i);
}
}

[ ]+"integer"[ ]+({var})+	{
printf("Integer Variable Found\n");
keyword[cnt_keyword][0]='i';
keyword[cnt_keyword][1]='n';
keyword[cnt_keyword][2]='t';
keyword[cnt_keyword][3]='e';
keyword[cnt_keyword][4]='g';
keyword[cnt_keyword][5]='e';
keyword[cnt_keyword++][6]='r';
pt=0;
for(i=0; i<yyleng; i++){
if(yytext[i]=='i' && yytext[i+1]=='n' && yytext[i+2]=='t'&&yytext[i+3]=='e'&&yytext[i+4]=='g'&&yytext[i+5]=='e'&&yytext[i+6]=='r'){
	i+=7;
	while(yytext[i]==' '){
		i++;
	}
	while(yytext[i]!=':'){
		identifier[cnt_identifier][pt++]=yytext[i];
		i++;
	}
	i++;
  }
}
cnt_identifier++;
}

[ ]+"str"[ ]+({var})+	{
printf("String Variable Found\n");
keyword[cnt_keyword][0]='s';
keyword[cnt_keyword][1]='t';
keyword[cnt_keyword++][2]='r';
pt=0;
for(i=0; i<yyleng; i++){
if(yytext[i]=='s' && yytext[i+1]=='t' && yytext[i+2]=='r'){
	i+=3;
	while(yytext[i]==' '){
		i++;
	}
	while(yytext[i]!=':'){
	identifier[cnt_identifier][pt++]=yytext[i];
	i++;
	}
	i++;
  }
}
cnt_identifier++;
}


[ ]+"do""~"	{
printf("New Block created\n");

keyword[cnt_keyword][0]='d';
keyword[cnt_keyword++][1]='o';
punctuation[cnt_punctuation++][0]='~';

}


[ ]+"while~" 	{
printf("While loop found\n");

pt=0;
for(i=0; i<yyleng; i++){
if(yytext[i]=='~')
	break;
if(yytext[i]!=' '){
keyword[cnt_keyword][pt++]=yytext[i];
}
}
cnt_keyword++;

punctuation[cnt_punctuation][0]='[';
punctuation[cnt_punctuation++][1]=']';
}





[ ]+"done~"	{
printf("Block ended\n");
pt=0;
for(i=0; i<yyleng; i++){
if(yytext[i]!='~' && yytext[i]!=' '){
keyword[cnt_keyword][pt++]=yytext[i];
}
}
cnt_keyword++;
}


[ ]+"if~" 	{
printf("If condition\n");
keyword[cnt_keyword][0]='i';
keyword[cnt_keyword++][1]='f';
punctuation[cnt_punctuation][0]='[';
punctuation[cnt_punctuation++][1]=']';
}




[ ]+({var})+[ ]*[=][0-9]+":" 	{

operator[cnt_operator++][0]='=';
printf("Integer value assigned\n");
}


[ ]+({var})+[ ]*[=]({var}|[ ])+":"   {

operator[cnt_operator++][0]='=';
printf("String value assigned\n");
}


[ ]*"<<"({var}|[ ])+">>"	{

punctuation[cnt_punctuation][0]='<';
punctuation[cnt_punctuation][1]='<';
punctuation[cnt_punctuation][2]='>';
punctuation[cnt_punctuation++][3]='>';
printf("This is a comment\n");
}

. 
%%

int yywrap(){ 
    return 1;
}

int main(){
	yyin = freopen("input.txt", "r",stdin);
	yyout = freopen("output.txt","w", stdout);
	yylex();
	fclose(yyin);
	fclose(yyout);
	return 0;
}
